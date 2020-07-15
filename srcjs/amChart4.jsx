import { reactWidget } from 'reactR';
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";
import am4themes_dark from "@amcharts/amcharts4/themes/dark";
import am4themes_dataviz from "@amcharts/amcharts4/themes/dataviz";
import am4themes_frozen from "@amcharts/amcharts4/themes/frozen";
import am4themes_kelly from "@amcharts/amcharts4/themes/kelly";
import am4themes_material from "@amcharts/amcharts4/themes/material";
import am4themes_microchart from "@amcharts/amcharts4/themes/microchart";
import am4themes_moonrisekingdom from "@amcharts/amcharts4/themes/moonrisekingdom";
import am4themes_patterns from "@amcharts/amcharts4/themes/patterns";
import am4themes_spiritedaway from "@amcharts/amcharts4/themes/spiritedaway";
//import * as barChart from "./utils/barChart";

am4core.useTheme(am4themes_animated);

/* COMPONENT: VERTICAL BAR CHART */

class AmBarChart extends React.PureComponent {

  constructor(props) {
    super(props);
    this.style = this.style.bind(this);
  }

  style() {
    if(window.Shiny && !window.FlexDashboard) {
      return {width: "100%", height: "100%"};
    } else {
      return {width: this.props.width, height: this.props.height};
    }
  }

  componentDidMount() {
    let theme = this.props.theme,
      data = HTMLWidgets.dataframeToD3(this.props.data),
      dataCopy = HTMLWidgets.dataframeToD3(this.props.data),
      data2 = this.props.data2 ? HTMLWidgets.dataframeToD3(this.props.data2) : null,
      values = this.props.values,
      valueNames = this.props.valueNames,
      category = this.props.category,
      cellWidth = this.props.cellWidth,
      columnWidth = this.props.columnWidth,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      tooltipStyle = this.props.tooltip,
      valueFormatter = this.props.valueFormatter,
      columnStyle = this.props.columnStyle,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    switch(theme) {
      case "dark":
        am4core.useTheme(am4themes_dark);
        break;
      case "dataviz":
        am4core.useTheme(am4themes_dataviz);
        break;
      case "frozen":
        am4core.useTheme(am4themes_frozen);
        break;
      case "kelly":
        am4core.useTheme(am4themes_kelly);
        break;
      case "material":
        am4core.useTheme(am4themes_material);
        break;
      case "microchart":
        am4core.useTheme(am4themes_microchart);
        break;
      case "moonrisekingdom":
        am4core.useTheme(am4themes_moonrisekingdom);
        break;
      case "patterns":
        am4core.useTheme(am4themes_patterns);
        break;
      case "spiritedaway":
        am4core.useTheme(am4themes_spiritedaway);
        break;
    }

    let chart = am4core.create(this.props.chartId, am4charts.XYChart);

    chart.data = data;

    chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect
    chart.padding(50, 40, 0, 10);
    chart.maskBullets = false; // allow bullets to go out of plot area
    let chartBackgroundColor =
      this.props.backgroundColor || chart.background.fill;
    chart.background.fill = chartBackgroundColor;

		/* ~~~~\  title  /~~~~ */
		let chartTitle = this.props.chartTitle;
		if (chartTitle) {
			let title = chart.plotContainer.createChild(am4core.Label);
			title.text = chartTitle.text;
			title.fill =
			  chartTitle.color || (theme === "dark" ? "#ffffff" : "#000000");
			title.fontSize = chartTitle.fontSize || 22;
			title.fontWeight = "bold";
			title.fontFamily = "Tahoma";
			title.y = this.props.scrollbarX ? -56 : -42;
			title.x = -45;
			title.horizontalCenter = "left";
			title.zIndex = 100;
			title.fillOpacity = 1;
		}

    /* ~~~~\  caption  /~~~~ */
    let chartCaption = this.props.caption;
    if (chartCaption) {
      var caption = chart.chartContainer.createChild(am4core.Label);
      caption.text = chartCaption.text;
      caption.fill =
        chartCaption.color || (theme === "dark" ? "#ffffff" : "#000000");
      caption.align = chartCaption.align || "right";
    }


    /* ~~~~\  scrollbars  /~~~~ */
    if (this.props.scrollbarX) {
      chart.scrollbarX = new am4core.Scrollbar();
    }
    if (this.props.scrollbarY) {
      chart.scrollbarY = new am4core.Scrollbar();
    }

		/* ~~~~\  button  /~~~~ */
		let button = this.props.button;
		if (button) {
  		let Button = chart.chartContainer.createChild(am4core.Button);
      Button.label.text = button.text;
      Button.label.fill = button.color || Button.label.fill;
      Button.background.fill = button.fill || Button.background.fill;
      Button.dy = -Button.parent.innerHeight * (button.position || 0.8);
      Button.padding(5, 5, 5, 5);
      Button.align = "right";
      Button.marginRight = 15;
      Button.events.on("hit", function() {
        for (let r = 0; r < data.length; ++r){
          for (let v = 0; v < values.length; ++v) {
            chart.data[r][values[v]] = data2[r][values[v]];
          }
        }
        chart.invalidateRawData();
      });
		}

		/* ~~~~\  category axis  /~~~~ */
		let categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.cellStartLocation = 1 - cellWidth/100;
		categoryAxis.renderer.cellEndLocation = cellWidth/100;
		if(xAxis && xAxis.title && xAxis.title.text !== ""){
  		categoryAxis.title.text = xAxis.title.text || category;
  		categoryAxis.title.fontWeight = "bold";
  		categoryAxis.title.fontSize = xAxis.title.fontSize || 20;
  		categoryAxis.title.fill =
  		  xAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		var xAxisLabels = categoryAxis.renderer.labels.template;
		xAxisLabels.fontSize = xAxis.labels.fontSize || 17;
		xAxisLabels.rotation = xAxis.labels.rotation || 0;
		if(xAxisLabels.rotation !== 0){
		  xAxisLabels.horizontalCenter = "right";
		}
		xAxisLabels.fill =
		  xAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		categoryAxis.dataFields.category = category;
		categoryAxis.renderer.grid.template.disabled = true;
		categoryAxis.renderer.minGridDistance = 50;
		categoryAxis.numberFormatter.numberFormat = valueFormatter;

		/* ~~~~\  value axis  /~~~~ */
		let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
    valueAxis.renderer.grid.template.stroke =
      gridLines.color || (theme === "dark" ? "#ffffff" : "#000000");
    valueAxis.renderer.grid.template.strokeOpacity = gridLines.opacity || 0.15;
    valueAxis.renderer.grid.template.strokeWidth = gridLines.width || 1;
		if (yAxis && yAxis.title && yAxis.title.text !== "") {
			valueAxis.title.text = yAxis.title.text;
			valueAxis.title.fontWeight = "bold";
			valueAxis.title.fontSize = yAxis.title.fontSize || 20;
			valueAxis.title.fill =
			  yAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		let yAxisLabels = valueAxis.renderer.labels.template;
		yAxisLabels.fontSize = yAxis.labels.fontSize || 17;
		yAxisLabels.rotation = yAxis.labels.rotation || 0;
		yAxisLabels.fill =
		  yAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		// we set fixed min/max and strictMinMax to true, as otherwise value axis will adjust min/max while dragging and it won't look smooth
		valueAxis.strictMinMax = true;
		valueAxis.min = this.props.minValue;
		valueAxis.max = this.props.maxValue;
		valueAxis.renderer.minWidth = 60;

    /* ~~~~\  legend  /~~~~ */
    if (this.props.legend) {
      chart.legend = new am4charts.Legend();
      chart.legend.useDefaultMarker = false;
      let markerTemplate = chart.legend.markers.template;
      markerTemplate.width = 20;
      markerTemplate.strokeWidth = 1;
      markerTemplate.strokeOpacity = 1;
//      markerTemplate.stroke = am4core.color("#000000"); no effect
    }

		/* ~~~~\  function handling the drag event  /~~~~ */
		function handleDrag(event) {
			var dataItem = event.target.dataItem;
			// convert coordinate to value
			let value = valueAxis.yToValue(event.target.pixelY);
			// set new value
			dataItem.valueY = value;
			// make column hover
			dataItem.column.isHover = true;
			// hide tooltip not to interrupt
			dataItem.column.hideTooltip(0);
			// make bullet hovered (as it might hide if mouse moves away)
			event.target.isHover = true;
		}

		values.forEach(function(value, index){
      var series = chart.series.push(new am4charts.ColumnSeries());
      series.dataFields.categoryX = category;
      series.dataFields.valueY = value;
      series.name = valueNames[value];
      series.sequencedInterpolation = true;
      series.defaultState.interpolationDuration = 1500;

      /* ~~~~\  tooltip  /~~~~ */
      if(tooltipStyle) {
        var tooltip = series.tooltip;
        tooltip.pointerOrientation = "vertical";
        tooltip.dy = 0;
        tooltip.getFillFromObject = false;
        tooltip.background.fill = tooltipStyle.backgroundColor; //am4core.color("#101010");
        tooltip.background.fillOpacity = tooltipStyle.backgroundOpacity;
        tooltip.autoTextColor = false;
        tooltip.label.fill = tooltipStyle.labelColor; //am4core.color("#FFFFFF");
        tooltip.label.textAlign = "middle";
        tooltip.scale = tooltipStyle.scale || 1;
        tooltip.background.filters.clear(); // remove tooltip shadow
        tooltip.background.pointerLength = 10;
        tooltip.adapter.add("rotation", (x, target) => {
          if(target.dataItem.valueY >= 0) {
            return 0;
          } else {
            return 180;
          }
        });
        tooltip.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem.valueY >= 0) {
            return "none";
          } else {
            return "bottom";
          }
        });
        tooltip.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem.valueY >= 0) {
            return 0;
          } else {
            return 180;
          }
        });
      }

      /* ~~~~\  value label  /~~~~ */
      var valueLabel = new am4charts.LabelBullet();
      series.bullets.push(valueLabel);
      valueLabel.label.text =
        "{valueY.value.formatNumber('" + valueFormatter + "')}";
      valueLabel.label.hideOversized = true;
      valueLabel.label.truncate = false;
      valueLabel.strokeOpacity = 0;
      valueLabel.adapter.add("dy", (x, target) => {
        if(target.dataItem.valueY > 0) {
          return -10;
        } else {
          return 10;
        }
      });

      /* ~~~~\  bullet  /~~~~ */
      let bullet;
      if(draggable[value]) {
        bullet = series.bullets.create();
        bullet.fill = columnStyle.fill[value];
        bullet.stroke =
          columnStyle.stroke || chart.colors.getIndex(index).saturate(0.7);
        bullet.strokeWidth = 3;
        bullet.opacity = 0; // initially invisible
        bullet.defaultState.properties.opacity = 0;
        // resize cursor when over
        bullet.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        bullet.draggable = true;
        // create bullet hover state
        var hoverState = bullet.states.create("hover");
        hoverState.properties.opacity = 1; // visible when hovered
        // add circle sprite to bullet
        var circle = bullet.createChild(am4core.Circle);
        circle.radius = 8;
        // while dragging
        bullet.events.on("drag", event => {
          handleDrag(event);
        });
        // on dragging stop
        bullet.events.on("dragstop", event => {
          handleDrag(event);
          var dataItem = event.target.dataItem;
          dataItem.column.isHover = false;
          event.target.isHover = false;
          dataCopy[dataItem.index][value] = dataItem.values.valueY.value;
          if(window.Shiny) {
            if(shinyId === undefined){
              shinyId = $(document.getElementById(chartId)).parent().attr("id");
            }
            Shiny.setInputValue(shinyId + ":rAmCharts4.dataframe", dataCopy);
            Shiny.setInputValue(shinyId + "_change", {
              index: dataItem.index,
              category: dataItem.categoryX,
              field: value,
              value: dataItem.values.valueY.value
            });
          }
        });
      }

      /* ~~~~\  column template  /~~~~ */
      var columnTemplate = series.columns.template;
      columnTemplate.width = am4core.percent(columnWidth);
      columnTemplate.fill = columnStyle.fill[value];
      columnTemplate.stroke =
        columnStyle.stroke || chart.colors.getIndex(index).saturate(0.7);
      columnTemplate.strokeOpacity = 1;
      columnTemplate.column.fillOpacity = 0.8;
      columnTemplate.column.strokeWidth = 1;
      if(tooltipStyle) {
        columnTemplate.tooltipText = tooltipStyle.text;
        columnTemplate.adapter.add("tooltipY", (x, target) => {
          if(target.dataItem.valueY > 0) {
            return 0;
          } else {
            return -valueAxis.valueToPoint(maxValue - target.dataItem.valueY).y;
          }
        });
      }
      var cr = columnStyle.cornerRadius || 8;
      columnTemplate.column.adapter.add("cornerRadiusTopRight", (x, target) => {
        if(target.dataItem.valueY > 0) {
          return target.isHover ? 2 * cr : cr;
        } else {
          return 0;
        }
      });
      columnTemplate.column.adapter.add("cornerRadiusBottomRight", (x, target) => {
        if(target.dataItem.valueY > 0) {
          return 0;
        } else {
          return target.isHover ? 2 * cr : cr;
        }
      });
      columnTemplate.column.adapter.add("cornerRadiusTopLeft", (x, target) => {
        if(target.dataItem.valueY > 0) {
          return target.isHover ? 2 * cr : cr;
        } else {
          return 0;
        }
      });
      columnTemplate.column.adapter.add("cornerRadiusBottomLeft", (x, target) => {
        if(target.dataItem.valueY > 0) {
          return 0;
        } else {
          return target.isHover ? 2 * cr : cr;
        }
      });
      // columns hover state
      var columnHoverState = columnTemplate.column.states.create("hover");
      // you can change any property on hover state and it will be animated
      columnHoverState.properties.fillOpacity = 1;
      columnHoverState.properties.strokeWidth = 3;
      if(tooltipStyle) {
        // hide label when hovered because the tooltip is shown
        columnTemplate.events.on("over", event => {
          var dataItem = event.target.dataItem;
          var itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        columnTemplate.events.on("out", event => {
          var dataItem = event.target.dataItem;
          var itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });
      }
      if(draggable[value]) {
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        columnTemplate.events.on("down", event => {
          var dataItem = event.target.dataItem;
          var itemBullet = dataItem.bullets.getKey(bullet.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when columns position changes, adjust minX/maxX of bullets so that we could only dragg vertically
        columnTemplate.events.on("positionchanged", event => {
          var dataItem = event.target.dataItem;
          if(dataItem.bullets) {
          console.log('dataItem.bullets', dataItem.bullets);
          console.log('bullet.uid', bullet.uid);
            var itemBullet = dataItem.bullets.getKey(bullet.uid);
            var column = dataItem.column;
            itemBullet.minX = column.pixelX + column.pixelWidth / 2;
            itemBullet.maxX = itemBullet.minX;
            itemBullet.minY = 0;
            itemBullet.maxY = chart.seriesContainer.pixelHeight;
          }
        });
      }
    });

    this.chart = chart;

  }

  componentWillUnmount() {
    if (this.chart) {
      this.chart.dispose();
    }
  }

  render() {
    return (
      <div
        id = {this.props.chartId}
        style = {this.style()}
      ></div>
    );
  }
}


/* COMPONENT: HORIZONTAL BAR CHART */

class AmHorizontalBarChart extends React.PureComponent {

  constructor(props) {
    super(props);
    this.style = this.style.bind(this);
  }

  style() {
    if(window.Shiny && !window.FlexDashboard) {
      return {width: "100%", height: "100%"};
    } else {
      return {width: this.props.width, height: this.props.height};
    }
  }

  componentDidMount() {
    let theme = this.props.theme,
      data = HTMLWidgets.dataframeToD3(this.props.data),
      dataCopy = HTMLWidgets.dataframeToD3(this.props.data),
      data2 = this.props.data2 ? HTMLWidgets.dataframeToD3(this.props.data2) : null,
      values = this.props.values,
      valueNames = this.props.valueNames,
      category = this.props.category,
      cellWidth = this.props.cellWidth,
      columnWidth = this.props.columnWidth,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      tooltipStyle = this.props.tooltip,
      valueFormatter = this.props.valueFormatter,
      columnStyle = this.props.columnStyle,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    switch(theme) {
      case "dark":
        am4core.useTheme(am4themes_dark);
        break;
      case "dataviz":
        am4core.useTheme(am4themes_dataviz);
        break;
      case "frozen":
        am4core.useTheme(am4themes_frozen);
        break;
      case "kelly":
        am4core.useTheme(am4themes_kelly);
        break;
      case "material":
        am4core.useTheme(am4themes_material);
        break;
      case "microchart":
        am4core.useTheme(am4themes_microchart);
        break;
      case "moonrisekingdom":
        am4core.useTheme(am4themes_moonrisekingdom);
        break;
      case "patterns":
        am4core.useTheme(am4themes_patterns);
        break;
      case "spiritedaway":
        am4core.useTheme(am4themes_spiritedaway);
        break;
    }

    let chart = am4core.create(this.props.chartId, am4charts.XYChart);

    chart.data = data;

    chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect
    chart.padding(50, 40, 0, 10);
    chart.maskBullets = false; // allow bullets to go out of plot area
    let chartBackgroundColor =
      this.props.backgroundColor || chart.background.fill;
    chart.background.fill = chartBackgroundColor;

		/* ~~~~\  title  /~~~~ */
		let chartTitle = this.props.chartTitle;
		if (chartTitle) {
			let title = chart.plotContainer.createChild(am4core.Label);
			title.text = chartTitle.text;
			title.fill =
			  chartTitle.color || (theme === "dark" ? "#ffffff" : "#000000");
			title.fontSize = chartTitle.fontSize || 22;
			title.fontWeight = "bold";
			title.fontFamily = "Tahoma";
			title.y = this.props.scrollbarX ? -56 : -42;
			title.x = -45;
			title.horizontalCenter = "left";
			title.zIndex = 100;
			title.fillOpacity = 1;
		}

    /* ~~~~\  caption  /~~~~ */
    let chartCaption = this.props.caption;
    if (chartCaption) {
      var caption = chart.chartContainer.createChild(am4core.Label);
      caption.text = chartCaption.text;
      caption.fill =
        chartCaption.color || (theme === "dark" ? "#ffffff" : "#000000");
      caption.align = chartCaption.align || "right";
    }


    /* ~~~~\  scrollbars  /~~~~ */
    if (this.props.scrollbarX) {
      chart.scrollbarX = new am4core.Scrollbar();
    }
    if (this.props.scrollbarY) {
      chart.scrollbarY = new am4core.Scrollbar();
    }

		/* ~~~~\  button  /~~~~ */
		let button = this.props.button;
		if (button) {
  		let Button = chart.chartContainer.createChild(am4core.Button);
      Button.label.text = button.text;
      Button.label.fill = button.color || Button.label.fill;
      Button.background.fill = button.fill || Button.background.fill;
      Button.dy = -Button.parent.innerHeight * (button.position || 0.8);
      Button.padding(5, 5, 5, 5);
      Button.align = "right";
      Button.marginRight = 15;
      Button.events.on("hit", function() {
        for (let r = 0; r < data.length; ++r){
          for (let v = 0; v < values.length; ++v) {
            chart.data[r][values[v]] = data2[r][values[v]];
          }
        }
        chart.invalidateRawData();
      });
		}

		/* ~~~~\  category axis  /~~~~ */
		let categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
		categoryAxis.renderer.inversed = true;
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.cellStartLocation = 1 - cellWidth/100;
		categoryAxis.renderer.cellEndLocation = cellWidth/100;
		if(yAxis && yAxis.title && yAxis.title.text !== ""){
  		categoryAxis.title.text = yAxis.title.text || category;
  		categoryAxis.title.fontWeight = "bold";
  		categoryAxis.title.fontSize = yAxis.title.fontSize || 20;
  		categoryAxis.title.fill =
  		  yAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		var yAxisLabels = categoryAxis.renderer.labels.template;
		yAxisLabels.fontSize = yAxis.labels.fontSize || 17;
		yAxisLabels.rotation = yAxis.labels.rotation || 0;
		yAxisLabels.fill =
		  yAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		categoryAxis.dataFields.category = category;
		categoryAxis.renderer.grid.template.disabled = true;
		categoryAxis.renderer.minGridDistance = 50;
		categoryAxis.numberFormatter.numberFormat = valueFormatter;

		/* ~~~~\  value axis  /~~~~ */
		let valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
    valueAxis.renderer.grid.template.stroke =
      gridLines.color || (theme === "dark" ? "#ffffff" : "#000000");
    valueAxis.renderer.grid.template.strokeOpacity = gridLines.opacity || 0.15;
    valueAxis.renderer.grid.template.strokeWidth = gridLines.width || 1;
		if (xAxis && xAxis.title && xAxis.title.text !== "") {
			valueAxis.title.text = xAxis.title.text;
			valueAxis.title.fontWeight = "bold";
			valueAxis.title.fontSize = xAxis.title.fontSize || 20;
			valueAxis.title.fill =
			  xAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		let xAxisLabels = valueAxis.renderer.labels.template;
		xAxisLabels.fontSize = xAxis.labels.fontSize || 17;
		xAxisLabels.rotation = xAxis.labels.rotation || 0;
		xAxisLabels.fill =
		  xAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		// we set fixed min/max and strictMinMax to true, as otherwise value axis will adjust min/max while dragging and it won't look smooth
		valueAxis.strictMinMax = true;
		valueAxis.min = this.props.minValue;
		valueAxis.max = this.props.maxValue;
		valueAxis.renderer.minWidth = 60;

    /* ~~~~\  legend  /~~~~ */
    if (this.props.legend) {
      chart.legend = new am4charts.Legend();
      chart.legend.useDefaultMarker = false;
      let markerTemplate = chart.legend.markers.template;
      markerTemplate.width = 20;
      markerTemplate.strokeWidth = 1;
      markerTemplate.strokeOpacity = 1;
//      markerTemplate.stroke = am4core.color("#000000"); no effect
    }

		/* ~~~~\  function handling the drag event  /~~~~ */
		function handleDrag(event) {
			var dataItem = event.target.dataItem;
			// convert coordinate to value
			let value = valueAxis.xToValue(event.target.pixelX);
			// set new value
			dataItem.valueX = value;
			// make column hover
			dataItem.column.isHover = true;
			// hide tooltip not to interrupt
			dataItem.column.hideTooltip(0);
			// make bullet hovered (as it might hide if mouse moves away)
			event.target.isHover = true;
		}

		values.forEach(function(value, index){
      var series = chart.series.push(new am4charts.ColumnSeries());
      series.dataFields.categoryY = category;
      series.dataFields.valueX = value;
      series.name = valueNames[value];
      series.sequencedInterpolation = true;
      series.defaultState.interpolationDuration = 1500;

      /* ~~~~\  tooltip  /~~~~ */
      if(tooltipStyle) {
        var tooltip = series.tooltip;
  			tooltip.pointerOrientation = "horizontal";
	  		tooltip.dx = 0;
        tooltip.getFillFromObject = false;
        tooltip.background.fill = tooltipStyle.backgroundColor; //am4core.color("#101010");
        tooltip.background.fillOpacity = tooltipStyle.backgroundOpacity;
        tooltip.autoTextColor = false;
        tooltip.label.fill = tooltipStyle.labelColor; //am4core.color("#FFFFFF");
        tooltip.label.textAlign = "middle";
        tooltip.scale = tooltipStyle.scale || 1;
        tooltip.background.filters.clear(); // remove tooltip shadow
        tooltip.background.pointerLength = 10;
  			tooltip.rotation = 180;
  			tooltip.label.verticalCenter = "bottom";
  			tooltip.label.rotation = 180;
/*      tooltip.adapter.add("rotation", (x, target) => {
          if(target.dataItem.valueY >= 0) {
            return 0;
          } else {
            return 180;
          }
        });
        tooltip.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem.valueY >= 0) {
            return "none";
          } else {
            return "bottom";
          }
        });
        tooltip.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem.valueY >= 0) {
            return 0;
          } else {
            return 180;
          }
        });
        */
      }

      /* ~~~~\  value label  /~~~~ */
      var valueLabel = new am4charts.LabelBullet();
      series.bullets.push(valueLabel);
      valueLabel.label.text =
        "{valueX.value.formatNumber('" + valueFormatter + "')}";
      valueLabel.label.hideOversized = true;
      valueLabel.label.truncate = false;
      valueLabel.strokeOpacity = 0;
			valueLabel.adapter.add("dx", (x, target) => {
				if (target.dataItem.valueX > 0) {
					return -10;
				} else {
					return 10;
				}
			});
			valueLabel.label.adapter.add("horizontalCenter", (x, target) => {
				if (target.dataItem.valueX > 0) {
					return "left";
				} else {
					return "right";
				}
			});
			valueLabel.label.adapter.add("dx", (x, target) => {
				if (target.dataItem.valueX > 0) {
					return 13;
				} else {
					return -13;
				}
			});

      /* ~~~~\  bullet  /~~~~ */
      let bullet;
      if(draggable[value]) {
        bullet = series.bullets.create();
        bullet.fill = columnStyle.fill[value];
        bullet.stroke =
          columnStyle.stroke || chart.colors.getIndex(index).saturate(0.7);
        bullet.strokeWidth = 3;
        bullet.opacity = 0; // initially invisible
        bullet.defaultState.properties.opacity = 0;
        // resize cursor when over
        bullet.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        bullet.draggable = true;
        // create bullet hover state
        var hoverState = bullet.states.create("hover");
        hoverState.properties.opacity = 1; // visible when hovered
        // add circle sprite to bullet
        var circle = bullet.createChild(am4core.Circle);
        circle.radius = 8;
        // while dragging
        bullet.events.on("drag", event => {
          handleDrag(event);
        });
        // on dragging stop
        bullet.events.on("dragstop", event => {
          handleDrag(event);
          var dataItem = event.target.dataItem;
          dataItem.column.isHover = false;
          event.target.isHover = false;
          dataCopy[dataItem.index][value] = dataItem.values.valueX.value;
          if(window.Shiny) {
            if(shinyId === undefined){
              shinyId = $(document.getElementById(chartId)).parent().attr("id");
            }
            Shiny.setInputValue(shinyId + ":rAmCharts4.dataframe", dataCopy);
            Shiny.setInputValue(shinyId + "_change", {
              index: dataItem.index,
              category: dataItem.categoryY,
              field: value,
              value: dataItem.values.valueX.value
            });
          }
        });
      }

      /* ~~~~\  column template  /~~~~ */
      var columnTemplate = series.columns.template;
      columnTemplate.width = am4core.percent(columnWidth);
      columnTemplate.fill = columnStyle.fill[value];
      columnTemplate.stroke =
        columnStyle.stroke || chart.colors.getIndex(index).saturate(0.7);
      columnTemplate.strokeOpacity = 1;
      columnTemplate.column.fillOpacity = 0.8;
      columnTemplate.column.strokeWidth = 1;
      if(tooltipStyle) {
        columnTemplate.tooltipText = tooltipStyle.text;
	  		columnTemplate.adapter.add("tooltipX", (x, target) => {
		  		if (target.dataItem.valueX > 0) {
			  		return valueAxis.valueToPoint(target.dataItem.valueX + minValue).x;
				  } else {
					  return 0;
				  }
			  });
      }
      var cr = columnStyle.cornerRadius || 8;
      columnTemplate.column.adapter.add("cornerRadiusTopRight", (x, target) => {
        if(target.dataItem.valueX > 0) {
          return target.isHover ? 2 * cr : cr;
        } else {
          return 0;
        }
      });
      columnTemplate.column.adapter.add("cornerRadiusBottomRight", (x, target) => {
        if(target.dataItem.valueX > 0) {
          return 0;
        } else {
          return target.isHover ? 2 * cr : cr;
        }
      });
      columnTemplate.column.adapter.add("cornerRadiusTopLeft", (x, target) => {
        if(target.dataItem.valueX > 0) {
          return target.isHover ? 2 * cr : cr;
        } else {
          return 0;
        }
      });
      columnTemplate.column.adapter.add("cornerRadiusBottomLeft", (x, target) => {
        if(target.dataItem.valueX > 0) {
          return 0;
        } else {
          return target.isHover ? 2 * cr : cr;
        }
      });
      // columns hover state
      var columnHoverState = columnTemplate.column.states.create("hover");
      // you can change any property on hover state and it will be animated
      columnHoverState.properties.fillOpacity = 1;
      columnHoverState.properties.strokeWidth = 3;
      if(tooltipStyle) {
        // hide label when hovered because the tooltip is shown
        columnTemplate.events.on("over", event => {
          var dataItem = event.target.dataItem;
          var itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        columnTemplate.events.on("out", event => {
          var dataItem = event.target.dataItem;
          var itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });
      }
      if(draggable[value]) {
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        columnTemplate.events.on("down", event => {
          var dataItem = event.target.dataItem;
          var itemBullet = dataItem.bullets.getKey(bullet.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when columns position changes, adjust minX/maxX of bullets so that we could only dragg vertically
  			columnTemplate.events.on("positionchanged", event => {
	  			var dataItem = event.target.dataItem;
			  	if(dataItem.bullets !== undefined){
  			  	var itemBullet = dataItem.bullets.getKey(bullet.uid);
	  			  var column = dataItem.column;
  		  		itemBullet.minY = column.pixelY + column.pixelHeight / 2;
	  		  	itemBullet.maxY = itemBullet.minY;
  				  itemBullet.minX = 0;
  				  itemBullet.maxX = chart.seriesContainer.pixelWidth;
  				}
  			});
      }
    });

    this.chart = chart;

  }

  componentWillUnmount() {
    if (this.chart) {
      this.chart.dispose();
    }
  }

  render() {
    return (
      <div
        id = {this.props.chartId}
        style = {this.style()}
      ></div>
    );
  }
}


/* CREATE WIDGETS */

reactWidget(
  'amChart4',
  'output',
  {
    AmBarChart: AmBarChart,
    AmHorizontalBarChart: AmHorizontalBarChart
  },
  {}
);
