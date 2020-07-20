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
import * as utils from "./utils";
import regression from "regression";

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
      category = this.props.category,
      values = this.props.values,
      data = HTMLWidgets.dataframeToD3(
        utils.subset(this.props.data, [category].concat(values))
      ),
      dataCopy = data.map(row => ({...row})),
      data2 = this.props.data2 ?
        HTMLWidgets.dataframeToD3(utils.subset(this.props.data2, values)) :
        null,
      valueNames = this.props.valueNames,
      cellWidth = this.props.cellWidth,
      columnWidth = this.props.columnWidth,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      tooltips = this.props.tooltip,
      valueFormatter = this.props.valueFormatter,
      columnStyles = this.props.columnStyle,
      bulletsStyle = this.props.bullets,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    if(window.Shiny) {
      if(shinyId === undefined){
        shinyId = $(document.getElementById(chartId)).parent().attr("id");
      }
      Shiny.setInputValue(
        shinyId + ":rAmCharts4.dataframe", dataCopy
      );
    }

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
		if(chartTitle) {
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
    if(chartCaption) {
      let caption = chart.chartContainer.createChild(am4core.Label);
      caption.text = chartCaption.text;
      caption.fill =
        chartCaption.color || (theme === "dark" ? "#ffffff" : "#000000");
      caption.align = chartCaption.align || "right";
    }


    /* ~~~~\  image  /~~~~ */
    let img = this.props.image;
    if(img) {
      let image = chart.chartContainer.createChild(am4core.Image);
      image.width = img.width || 60;
      image.height = img.height || 60;
      image.verticalCenter = "top";
      image.horizontalCenter = "left";
      image.align = img.align || "right";
      image.href = img.base64;
    }


    /* ~~~~\  scrollbars  /~~~~ */
    if(this.props.scrollbarX) {
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
        if(window.Shiny) {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframe", chart.data
          );
          Shiny.setInputValue(shinyId + "_change", null);
        }
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
      let columnStyle = columnStyles[value];
      if(draggable[value]) {
        bullet = series.bullets.create();
        bullet.opacity = 0; // initially invisible
        bullet.defaultState.properties.opacity = 0;
        // resize cursor when over
        bullet.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        bullet.draggable = true;
        // create bullet hover state
        var hoverState = bullet.states.create("hover");
        hoverState.properties.opacity = 1; // visible when hovered
        // add sprite to bullet
        let shapeConfig = bulletsStyle[value];
        if(!shapeConfig.color){
          shapeConfig.color = columnStyle.color;
        }
        if(!shapeConfig.strokeColor){
          shapeConfig.strokeColor = columnStyle.strokeColor;
        }
        let shape =
          utils.Shape(am4core, chart, index, bullet, shapeConfig);
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
      let columnTemplate = series.columns.template;
      columnTemplate.width = am4core.percent(columnWidth);
      columnTemplate.fill =
        columnStyle.color || chart.colors.getIndex(index);
      columnTemplate.stroke = columnStyle.strokeColor ||
        am4core.color(columnTemplate.fill).lighten(-0.5);
      columnTemplate.strokeOpacity = 1;
      columnTemplate.column.fillOpacity = 0.8;
      columnTemplate.column.strokeWidth = columnStyle.strokeWidth;
      /* ~~~~\  tooltip  /~~~~ */
      if(tooltips) {
        columnTemplate.tooltipText = tooltips[value].text;
        let tooltip = utils.Tooltip(am4core, chart, index, tooltips[value]);
        tooltip.pointerOrientation = "vertical";
        tooltip.dy = 0;
        tooltip.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        tooltip.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return "none";
            } else {
              return "bottom";
            }
          } else {
            return x;
          }
        });
        tooltip.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        columnTemplate.tooltip = tooltip;
        columnTemplate.adapter.add("tooltipY", (x, target) => {
          if(target.dataItem.valueY > 0) {
            return 0;
          } else {
            return -valueAxis.valueToPoint(maxValue - target.dataItem.valueY).y;
          }
        });
      }
      let cr = columnStyle.cornerRadius || 8;
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
      let columnHoverState = columnTemplate.column.states.create("hover");
      // you can change any property on hover state and it will be animated
      columnHoverState.properties.fillOpacity = 1;
      columnHoverState.properties.strokeWidth = columnStyle.strokeWidth + 2;
      if(tooltips) {
        // hide label when hovered because the tooltip is shown
        columnTemplate.events.on("over", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        columnTemplate.events.on("out", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });
      }
      if(draggable[value]) {
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        columnTemplate.events.on("down", event => {
          let dataItem = event.target.dataItem;
          let itemBullet = dataItem.bullets.getKey(bullet.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when columns position changes, adjust minX/maxX of bullets so that we could only dragg vertically
        columnTemplate.events.on("positionchanged", event => {
          let dataItem = event.target.dataItem;
          if(dataItem.bullets) {
            //console.log('dataItem.bullets', dataItem.bullets);
            //console.log('bullet.uid', bullet.uid);
            let itemBullet = dataItem.bullets.getKey(bullet.uid);
            let column = dataItem.column;
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
      category = this.props.category,
      values = this.props.values,
      data = HTMLWidgets.dataframeToD3(
        utils.subset(this.props.data, [category].concat(values))
      ),
      dataCopy = data.map(row => ({...row})),
      data2 = this.props.data2 ?
        HTMLWidgets.dataframeToD3(utils.subset(this.props.data2, values)) :
        null,
      valueNames = this.props.valueNames,
      minValue = this.props.minValue,
      maxValue = this.props.maxValue,
      cellWidth = this.props.cellWidth,
      columnWidth = this.props.columnWidth,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      tooltips = this.props.tooltip,
      valueFormatter = this.props.valueFormatter,
      columnStyles = this.props.columnStyle,
      bulletsStyle = this.props.bullets,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    if(window.Shiny) {
      if(shinyId === undefined){
        shinyId = $(document.getElementById(chartId)).parent().attr("id");
      }
      Shiny.setInputValue(
        shinyId + ":rAmCharts4.dataframe", dataCopy
      );
    }

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


    /* ~~~~\  image  /~~~~ */
    let img = this.props.image;
    if(img) {
      let image = chart.chartContainer.createChild(am4core.Image);
      image.width = img.width || 60;
      image.height = img.height || 60;
      image.verticalCenter = "top";
      image.horizontalCenter = "left";
      image.align = img.align || "right";
      image.href = img.base64;
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
        if(window.Shiny) {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframe", chart.data
          );
          Shiny.setInputValue(shinyId + "_change", null);
        }
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
		valueAxis.min = minValue;
		valueAxis.max = maxValue;
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


      /* ~~~~\  value label  /~~~~ */
      var valueLabel = new am4charts.LabelBullet();
      series.bullets.push(valueLabel);
      valueLabel.label.text =
        "{valueX.value.formatNumber('" + valueFormatter + "')}";
      valueLabel.label.hideOversized = true;
      valueLabel.label.truncate = false;
      valueLabel.strokeOpacity = 0;
			valueLabel.adapter.add("dx", (x, target) => {
				if(target.dataItem.valueX > 0) {
					return -10;
				} else {
					return 10;
				}
			});
			valueLabel.label.adapter.add("horizontalCenter", (x, target) => {
				if(target.dataItem.valueX > 0) {
					return "left";
				} else {
					return "right";
				}
			});
			valueLabel.label.adapter.add("dx", (x, target) => {
				if(target.dataItem.valueX > 0) {
					return 13;
				} else {
					return -13;
				}
			});

      /* ~~~~\  bullet  /~~~~ */
      let bullet;
      let columnStyle = columnStyles[value];
      if(draggable[value]) {
        bullet = series.bullets.create();
        bullet.opacity = 0; // initially invisible
        bullet.defaultState.properties.opacity = 0;
        // resize cursor when over
        bullet.cursorOverStyle = am4core.MouseCursorStyle.horizontalResize;
        bullet.draggable = true;
        // create bullet hover state
        let hoverState = bullet.states.create("hover");
        hoverState.properties.opacity = 1; // visible when hovered
        // add sprite to bullet
        let shapeConfig = bulletsStyle[value];
        if(!shapeConfig.color){
          shapeConfig.color = columnStyle.color;
        }
        if(!shapeConfig.strokeColor){
          shapeConfig.strokeColor = columnStyle.strokeColor;
        }
        let shape =
          utils.Shape(am4core, chart, index, bullet, shapeConfig);
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
      let columnTemplate = series.columns.template;
      columnTemplate.width = am4core.percent(columnWidth);
      columnTemplate.fill =
        columnStyle.color || chart.colors.getIndex(index);
      columnTemplate.stroke = columnStyle.strokeColor ||
        am4core.color(columnTemplate.fill).lighten(-0.5);
      columnTemplate.strokeOpacity = 1;
      columnTemplate.column.fillOpacity = 0.8;
      columnTemplate.column.strokeWidth = columnStyle.strokeWidth;
      /* ~~~~\  tooltip  /~~~~ */
      if(tooltips) {
        columnTemplate.tooltipText = tooltips[value].text;
        let tooltip = utils.Tooltip(am4core, chart, index, tooltips[value]);
  			tooltip.pointerOrientation = "horizontal";
	  		tooltip.dx = 0;
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
        columnTemplate.tooltip = tooltip;
	  		columnTemplate.adapter.add("tooltipX", (x, target) => {
		  		if(target.dataItem.valueX > 0) {
			  		return valueAxis.valueToPoint(target.dataItem.valueX + minValue).x;
				  } else {
					  return 0;
				  }
			  });
      }
      let cr = columnStyle.cornerRadius || 8;
			columnTemplate.column.adapter.add("cornerRadiusTopRight", (x, target) => {
				if(target.dataItem.valueX > 0) {
					return target.isHover ? 2 * cr : cr;
				} else {
					return 0;
				}
			});
			columnTemplate.column.adapter.add("cornerRadiusBottomRight", (x, target) => {
				if(target.dataItem.valueX > 0) {
					return target.isHover ? 2 * cr : cr;
				} else {
					return 0;
				}
			});
			columnTemplate.column.adapter.add("cornerRadiusTopLeft", (x, target) => {
				if(target.dataItem.valueX > 0) {
					return 0;
				} else {
					return target.isHover ? 2 * cr : cr;
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
      let columnHoverState = columnTemplate.column.states.create("hover");
      // you can change any property on hover state and it will be animated
      columnHoverState.properties.fillOpacity = 1;
      columnHoverState.properties.strokeWidth = columnStyle.strokeWidth + 2;
      if(tooltips) {
        // hide label when hovered because the tooltip is shown
        columnTemplate.events.on("over", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        columnTemplate.events.on("out", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });
      }
      if(draggable[value]) {
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        columnTemplate.events.on("down", event => {
          let dataItem = event.target.dataItem;
          let itemBullet = dataItem.bullets.getKey(bullet.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when columns position changes, adjust minX/maxX of bullets so that we could only dragg horizontally
  			columnTemplate.events.on("positionchanged", event => {
	  			let dataItem = event.target.dataItem;
			  	if(dataItem.bullets !== undefined){
  			  	let itemBullet = dataItem.bullets.getKey(bullet.uid);
	  			  let column = dataItem.column;
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


/* COMPONENT: LINE CHART */

class AmLineChart extends React.PureComponent {

  constructor(props) {
    super(props);
    this.style = this.style.bind(this);
    this.toggleHover = this.toggleHover.bind(this);
  }

  style() {
    if(window.Shiny && !window.FlexDashboard) {
      return {width: "100%", height: "100%"};
    } else {
      return {width: this.props.width, height: this.props.height};
    }
  }

  toggleHover(series, over) {
    series.segments.each(function(segment) {
      segment.isHover = over;
    });
  }


  componentDidMount() {

    let theme = this.props.theme,
      xValue = this.props.xValue,
      yValues = this.props.yValues,
      data = utils.subset(this.props.data, [xValue].concat(yValues)),
      data2 = this.props.data2 ?
        HTMLWidgets.dataframeToD3(
          utils.subset(this.props.data2, [xValue].concat(yValues))
        ) : null,
      trendData0 = this.props.trendData,
      trendData = trendData0 ?
        Object.assign({}, ...Object.keys(trendData0)
          .map(k => ({[k]: HTMLWidgets.dataframeToD3(trendData0[k])}))
        ) : null,
/*      trendDataCopy = trendData ?
        Object.assign({}, ...Object.keys(trendData)
          .map(k => ({[k]: trendData[k].map(row => ({...row}))}))
        ) : null,                                                 */
      trendStyles = this.props.trendStyle,
      trendJS = this.props.trendJS,
      yValueNames = this.props.yValueNames,
      minY = this.props.minY,
      maxY = this.props.maxY,
      isDate = this.props.isDate,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      tooltips = this.props.tooltip,
      bulletsStyle = this.props.bullets,
      alwaysShowBullets = this.props.alwaysShowBullets,
      valueFormatter = this.props.valueFormatter,
      lineStyles = this.props.lineStyle,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    if(isDate) {
      data[xValue] = data[xValue].map(utils.toDate);
    }
    data = HTMLWidgets.dataframeToD3(data);
    let dataCopy = data.map(row => ({...row}));

    if(window.Shiny) {
      if(shinyId === undefined){
        shinyId = $(document.getElementById(chartId)).parent().attr("id");
      }
      if(isDate) {
        Shiny.setInputValue(
          shinyId + ":rAmCharts4.dataframeWithDate",
          {
            data: dataCopy,
            date: xValue
          }
        );
      } else {
        Shiny.setInputValue(
          shinyId + ":rAmCharts4.dataframe", dataCopy
        );
      }
    }


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
		if(chartTitle) {
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


    /* ~~~~\  image  /~~~~ */
    let img = this.props.image;
    if(img) {
      let image = chart.chartContainer.createChild(am4core.Image);
      image.width = img.width || 60;
      image.height = img.height || 60;
      image.verticalCenter = "top";
      image.horizontalCenter = "left";
      image.align = img.align || "right";
      image.href = img.base64;
    }


    /* ~~~~\  scrollbars  /~~~~ */
    if(this.props.scrollbarX) {
      chart.scrollbarX = new am4core.Scrollbar();
    }
    if(this.props.scrollbarY) {
      chart.scrollbarY = new am4core.Scrollbar();
    }

		/* ~~~~\  button  /~~~~ */
		let button = this.props.button;
		if(button) {
  		let Button = chart.chartContainer.createChild(am4core.Button);
      Button.label.text = button.text;
      Button.label.fill = button.color || Button.label.fill;
      Button.background.fill = button.fill || Button.background.fill;
      Button.dy = -Button.parent.innerHeight * (button.position || 0.8);
      Button.padding(5, 5, 5, 5);
      Button.align = "right";
      Button.marginRight = 15;
      Button.events.on("hit", function() {
        for(let r = 0; r < data.length; ++r){
          for(let v = 0; v < yValues.length; ++v) {
            chart.data[r][yValues[v]] = data2[r][yValues[v]];
          }
        }
        chart.invalidateRawData();
        if(window.Shiny) {
          if(isDate) {
            Shiny.setInputValue(
              shinyId + ":rAmCharts4.dataframeWithDate",
              {
                data: chart.data,
                date: xValue
              }
            );
            Shiny.setInputValue(shinyId + "_change", null);
          } else {
            Shiny.setInputValue(
              shinyId + ":rAmCharts4.dataframe", chart.data
            );
            Shiny.setInputValue(shinyId + "_change", null);
          }
        }

        if(trendJS) {
          let seriesNames = chart.series.values.map(function(x){return x.name});
          yValues.forEach(function(value, index) {
            if(trendJS[value]) {
              let thisSeriesName = yValueNames[value],
                trendSeriesName = thisSeriesName + "_trend",
                trendSeriesIndex = seriesNames.indexOf(trendSeriesName),
                trendSeries = chart.series.values[trendSeriesIndex],
                trendSeriesData = trendSeries.data,
                regData = data2.map(function(row){
                  return [row[xValue], row[value]];
                }),
                fit = regression.polynomial(
                  regData, { order: trendJS[value], precision: 15 }
                ),
                regressionLine = trendSeriesData.map(function(row){
                  let xy = fit.predict(row.x);
                  return {x: xy[0], y: xy[1]};
                });
              regressionLine.forEach(function(point, i){
                trendSeriesData[i] = point;
              });
              trendSeries.invalidateData();
            }
          })
        }

      });
		}

		/* ~~~~\  x-axis  /~~~~ */
		let XAxis;
		if(isDate) {
		  XAxis = chart.xAxes.push(new am4charts.DateAxis());
		} else {
		  XAxis = chart.xAxes.push(new am4charts.ValueAxis());
		}
		XAxis.min = this.props.minX;
		XAxis.max = this.props.maxX;
		XAxis.renderer.grid.template.location = 0;
		if(xAxis && xAxis.title && xAxis.title.text !== ""){
  		XAxis.title.text = xAxis.title.text || xValue;
  		XAxis.title.fontWeight = "bold";
  		XAxis.title.fontSize = xAxis.title.fontSize || 20;
  		XAxis.title.fill =
  		  xAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		var xAxisLabels = XAxis.renderer.labels.template;
		xAxisLabels.fontSize = xAxis.labels.fontSize || 17;
		xAxisLabels.rotation = xAxis.labels.rotation || 0;
		if(xAxisLabels.rotation !== 0){
		  xAxisLabels.horizontalCenter = "right";
		}
		xAxisLabels.fill =
		  xAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		if(isDate) {
		  XAxis.dataFields.dateX = xValue;
		} else {
  		XAxis.dataFields.valueX = xValue;
  	}
		XAxis.renderer.grid.template.disabled = true;
		XAxis.renderer.minGridDistance = 50;
		XAxis.numberFormatter.numberFormat = valueFormatter;

		/* ~~~~\  y-axis  /~~~~ */
		let YAxis = chart.yAxes.push(new am4charts.ValueAxis());
    YAxis.renderer.grid.template.stroke =
      gridLines.color || (theme === "dark" ? "#ffffff" : "#000000");
    YAxis.renderer.grid.template.strokeOpacity = gridLines.opacity || 0.15;
    YAxis.renderer.grid.template.strokeWidth = gridLines.width || 1;
		if (yAxis && yAxis.title && yAxis.title.text !== "") {
			YAxis.title.text = yAxis.title.text;
			YAxis.title.fontWeight = "bold";
			YAxis.title.fontSize = yAxis.title.fontSize || 20;
			YAxis.title.fill =
			  yAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		if(yAxis.labels !== false) {
  		let yAxisLabels = YAxis.renderer.labels.template;
	  	yAxisLabels.fontSize = yAxis.labels.fontSize || 17;
		  yAxisLabels.rotation = yAxis.labels.rotation || 0;
		  yAxisLabels.fill =
		    yAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		} else {
		  YAxis.renderer.labels.template.disabled = true;
		}
		// we set fixed min/max and strictMinMax to true, as otherwise value axis will adjust min/max while dragging and it won't look smooth
		YAxis.strictMinMax = true;
		YAxis.min = minY;
		YAxis.max = maxY;
		YAxis.renderer.minWidth = 60;

    /* ~~~~\  legend  /~~~~ */
    if(this.props.legend) {
      chart.legend = new am4charts.Legend();
      chart.legend.useDefaultMarker = false;
      let markerTemplate = chart.legend.markers.template;
      markerTemplate.width = 20;
      markerTemplate.strokeWidth = 1;
      markerTemplate.strokeOpacity = 1;
//      markerTemplate.stroke = am4core.color("#000000"); no effect
      let toggleHover = this.toggleHover;
      chart.legend.itemContainers.template.events.on("over", function(ev) {
        toggleHover(ev.target.dataItem.dataContext, true);
      });
      chart.legend.itemContainers.template.events.on("out", function(ev) {
        toggleHover(ev.target.dataItem.dataContext, false);
      });
    }

		/* ~~~~\  function handling the drag event  /~~~~ */
		function handleDrag(event) {
			let dataItem = event.target.dataItem;
			//console.log("dataItem", dataItem);
			// convert coordinate to value
			let value = YAxis.yToValue(event.target.pixelY);
			// set new value
			dataItem.valueY = value;
			// make line hover
			dataItem.segment.isHover = true;
			// hide tooltip not to interrupt
			dataItem.segment.hideTooltip(0);
			// make bullet hovered (as it might hide if mouse moves away)
			event.target.isHover = true;
		}

		/* ~~~~\  function handling the dragstop event  /~~~~ */
		function handleDragStop(event, value) {
      console.log("bullet dragstop");
      handleDrag(event);
      let dataItem = event.target.dataItem;
      dataItem.component.isHover = false; // XXXX
      event.target.isHover = false;
      dataCopy[dataItem.index][value] = dataItem.values.valueY.value;

      if(trendJS && trendJS[value]){
        let newvalue = YAxis.yToValue(event.target.pixelY),
          seriesNames = chart.series.values.map(function(x){return x.name}),
          thisSeriesName = dataItem.component.name,
          thisSeriesData = dataItem.component.dataProvider.data,
          thisSeriesDataCopy = thisSeriesData.map(row => ({...row}));
			  thisSeriesDataCopy[dataItem.index][value] = newvalue;
			  thisSeriesData[dataItem.index][value] = newvalue;
			  let trendSeriesName = thisSeriesName + "_trend",
			    trendSeriesIndex = seriesNames.indexOf(trendSeriesName),
			    trendSeries = chart.series.values[trendSeriesIndex],
			    trendSeriesData = trendSeries.data,
			    regData = thisSeriesDataCopy.map(function(row){
			      return [row[xValue], row[value]];
			    }),
			    fit = regression.polynomial(
			      regData, { order: trendJS[value], precision: 15 }
			    ),
			    regressionLine = trendSeriesData.map(function(row){
			      let xy = fit.predict(row.x);
			      return {x: xy[0], y: xy[1]};
			    });
			  regressionLine.forEach(function(point, i){trendSeriesData[i] = point;});
			  trendSeries.invalidateData();
			}

      if(window.Shiny) {
        if(isDate) {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframeWithDate",
            {
              data: dataCopy,
              date: xValue
            }
          );
          Shiny.setInputValue(shinyId + "_change:rAmCharts4.lineChange", {
            index: dataItem.index,
            x: dataItem.dateX,
            variable: value,
            y: dataItem.values.valueY.value
          });
        } else {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframe", dataCopy
          );
          Shiny.setInputValue(shinyId + "_change", {
            index: dataItem.index,
            x: dataItem.values.valueX.value,
            variable: value,
            y: dataItem.values.valueY.value
          });
        }
      }
		}


		yValues.forEach(function(value, index){

      let lineStyle = lineStyles[value];

      let series = chart.series.push(new am4charts.LineSeries());
      if(isDate) {
        series.dataFields.dateX = xValue;
      } else {
        series.dataFields.valueX = xValue;
      }
      series.dataFields.valueY = value;
      series.name = yValueNames[value];
      series.sequencedInterpolation = true;
      series.defaultState.interpolationDuration = 1500;
      series.tensionX = lineStyle.tensionX || 1;
      series.tensionY = lineStyle.tensionY || 1;

      /* ~~~~\  value label  /~~~~ */
/*    let valueLabel = new am4charts.LabelBullet();
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
      */

      /* ~~~~\  bullet  /~~~~ */
      let bullet = series.bullets.push(new am4charts.Bullet());
      let shape =
        utils.Shape(am4core, chart, index, bullet, bulletsStyle[value]);
      if(!alwaysShowBullets){
        shape.opacity = 0; // initially invisible
        shape.defaultState.properties.opacity = 0;
      }
      if(tooltips) {
        /* ~~~~\  tooltip  /~~~~ */
        bullet.tooltipText = tooltips[value].text;
        let tooltip = utils.Tooltip(am4core, chart, index, tooltips[value]);
        tooltip.pointerOrientation = "vertical";
        tooltip.dy = 0;
        tooltip.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        tooltip.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return "none";
            } else {
              return "bottom";
            }
          } else {
            return x;
          }
        });
        tooltip.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        bullet.tooltip = tooltip;
        // hide label when hovered because the tooltip is shown
        // XXX y'a pas de label
/*      bullet.events.on("over", event => {
          let dataItem = event.target.dataItem;
          console.log("dataItem bullet on over", dataItem);
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        bullet.events.on("out", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });
        */
      }
      // create bullet hover state
      let hoverState = shape.states.create("hover");
      hoverState.properties.strokeWidth = shape.strokeWidth + 3;
      hoverState.properties.opacity = 1; // visible when hovered
      if(draggable[value]){
        bullet.draggable = true;
        // resize cursor when over
        bullet.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        // while dragging
        bullet.events.on("drag", event => {
          handleDrag(event);
        });
        // on dragging stop
        bullet.events.on("dragstop", event => {
          handleDragStop(event, value);
        });
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        bullet.events.on("down", event => {
          let dataItem = event.target.dataItem;
          let itemBullet = dataItem.bullets.getKey(bullet.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when line position changes, adjust minX/maxX of bullets so that we could only dragg vertically
        bullet.events.on("positionchanged", event => {
          let dataItem = event.target.dataItem;
          //console.log("dataItem", dataItem);
          if(dataItem.bullets) {
            let itemBullet = dataItem.bullets.getKey(bullet.uid);
            let point = dataItem.point;
            itemBullet.minX = point.x;
            itemBullet.maxX = itemBullet.minX;
            itemBullet.minY = 0;
            itemBullet.maxY = chart.seriesContainer.pixelHeight;
          }
        });
      }

      /* ~~~~\  line template  /~~~~ */
      console.log("series", series);
      let lineTemplate = series.segments.template;
      lineTemplate.interactionsEnabled = true;
      series.strokeWidth = lineStyle.width || 3;
      series.stroke = lineStyle.color ||
        chart.colors.getIndex(index).saturate(0.7);
      if(lineStyle.dash)
        series.strokeDasharray = lineStyle.dash;
      // line hover state
      let lineHoverState = lineTemplate.states.create("hover");
      // you can change any property on hover state and it will be animated
      lineHoverState.properties.fillOpacity = 1;
      lineHoverState.properties.strokeWidth = series.strokeWidth + 2;

      /* ~~~~\ trend line /~~~~ */
      if(trendData && trendData[value]) {
      console.log("trendData[value]", trendData[value]);
        let trend = chart.series.push(new am4charts.LineSeries());
        trend.name = yValueNames[value] + "_trend";
        trend.hiddenInLegend = true;
        trend.data = trendData[value];
        trend.dataFields.valueX = "x";
        trend.dataFields.valueY = "y";
        trend.sequencedInterpolation = true;
        trend.defaultState.interpolationDuration = 1500;
        let trendStyle = trendStyles[value];
        trend.strokeWidth = trendStyle.width || 3;
        trend.stroke = trendStyle.color ||
          chart.colors.getIndex(index).saturate(0.7);
        if(trendStyle.dash)
          trend.strokeDasharray = trendStyle.dash;
        trend.tensionX = trendStyle.tensionX || 0.8;
        trend.tensionY = trendStyle.tensionY || 0.8;
      }

    }); /* end of forEach */

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


/* COMPONENT: SCATTER CHART */

class AmScatterChart extends React.PureComponent {

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
      xValue = this.props.xValue,
      yValues = this.props.yValues,
      data = utils.subset(this.props.data, [xValue].concat(yValues)),
      data2 = this.props.data2 ?
        HTMLWidgets.dataframeToD3(
          utils.subset(this.props.data2, [xValue].concat(yValues))
        ) : null,
      trendData0 = this.props.trendData,
      trendData = trendData0 ?
        Object.assign({}, ...Object.keys(trendData0)
          .map(k => ({[k]: HTMLWidgets.dataframeToD3(trendData0[k])}))
        ) : null,
      trendStyles = this.props.trendStyle,
      trendJS = this.props.trendJS,
      yValueNames = this.props.yValueNames,
      minY = this.props.minY,
      maxY = this.props.maxY,
      isDate = this.props.isDate,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      tooltips = this.props.tooltip,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      valueFormatter = this.props.valueFormatter,
      pointsStyle = this.props.pointsStyle,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    if(isDate) {
      data[xValue] = data[xValue].map(utils.toDate);
    }
    data = HTMLWidgets.dataframeToD3(data);
    let dataCopy = data.map(row => ({...row}));

    if(window.Shiny) {
      if(shinyId === undefined){
        shinyId = $(document.getElementById(chartId)).parent().attr("id");
      }
      if(isDate) {
        Shiny.setInputValue(
          shinyId + ":rAmCharts4.dataframeWithDate",
          {
            data: dataCopy,
            date: xValue
          }
        );
      } else {
        Shiny.setInputValue(
          shinyId + ":rAmCharts4.dataframe", dataCopy
        );
      }
    }

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
    if(chartCaption) {
      let caption = chart.chartContainer.createChild(am4core.Label);
      caption.text = chartCaption.text;
      caption.fill =
        chartCaption.color || (theme === "dark" ? "#ffffff" : "#000000");
      caption.align = chartCaption.align || "right";
    }


    /* ~~~~\  image  /~~~~ */
    let img = this.props.image;
    if(img) {
      let image = chart.chartContainer.createChild(am4core.Image);
      image.width = img.width || 60;
      image.height = img.height || 60;
      image.verticalCenter = "top";
      image.horizontalCenter = "left";
      image.align = img.align || "right";
      image.href = img.base64;
    }


    /* ~~~~\  scrollbars  /~~~~ */
    if(this.props.scrollbarX) {
      chart.scrollbarX = new am4core.Scrollbar();
    }
    if(this.props.scrollbarY) {
      chart.scrollbarY = new am4core.Scrollbar();
    }

		/* ~~~~\  button  /~~~~ */
		let button = this.props.button;
		if(button) {
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
          for (let v = 0; v < yValues.length; ++v) {
            chart.data[r][yValues[v]] = data2[r][yValues[v]];
          }
        }
        chart.invalidateRawData();

        if(trendJS) {
          let seriesNames = chart.series.values.map(function(x){return x.name});
          yValues.forEach(function(value, index) {
            if(trendJS[value]) {
              let thisSeriesName = yValueNames[value],
                trendSeriesName = thisSeriesName + "_trend",
                trendSeriesIndex = seriesNames.indexOf(trendSeriesName),
                trendSeries = chart.series.values[trendSeriesIndex],
                trendSeriesData = trendSeries.data,
                regData = data2.map(function(row){
                  return [row[xValue], row[value]];
                }),
                fit = regression.polynomial(
                  regData, { order: trendJS[value], precision: 15 }
                ),
                regressionLine = trendSeriesData.map(function(row){
                  let xy = fit.predict(row.x);
                  return {x: xy[0], y: xy[1]};
                });
              regressionLine.forEach(function(point, i){
                trendSeriesData[i] = point;
              });
              trendSeries.invalidateData();
            }
          })
        }

        if(window.Shiny) {
          if(isDate) {
            Shiny.setInputValue(
              shinyId + ":rAmCharts4.dataframeWithDate",
              {
                data: chart.data,
                date: xValue
              }
            );
            Shiny.setInputValue(shinyId + "_change", null);
          } else {
            Shiny.setInputValue(
              shinyId + ":rAmCharts4.dataframe", chart.data
            );
            Shiny.setInputValue(shinyId + "_change", null);
          }
        }
      });
		}

		/* ~~~~\  x-axis  /~~~~ */
		let XAxis;
		if(isDate) {
		  XAxis = chart.xAxes.push(new am4charts.DateAxis());
		} else {
		  XAxis = chart.xAxes.push(new am4charts.ValueAxis());
		}
		XAxis.min = this.props.minX;
		XAxis.max = this.props.maxX;
		XAxis.renderer.grid.template.location = 0;
		if(xAxis && xAxis.title && xAxis.title.text !== ""){
  		XAxis.title.text = xAxis.title.text || xValue;
  		XAxis.title.fontWeight = "bold";
  		XAxis.title.fontSize = xAxis.title.fontSize || 20;
  		XAxis.title.fill =
  		  xAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		var xAxisLabels = XAxis.renderer.labels.template;
		xAxisLabels.fontSize = xAxis.labels.fontSize || 17;
		xAxisLabels.rotation = xAxis.labels.rotation || 0;
		if(xAxisLabels.rotation !== 0){
		  xAxisLabels.horizontalCenter = "right";
		}
		xAxisLabels.fill =
		  xAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		if(isDate) {
		  XAxis.dataFields.dateX = xValue;
		} else {
  		XAxis.dataFields.valueX = xValue;
  	}
		XAxis.renderer.grid.template.disabled = true;
		XAxis.renderer.minGridDistance = 50;
		XAxis.numberFormatter.numberFormat = valueFormatter;

		/* ~~~~\  y-axis  /~~~~ */
		let YAxis = chart.yAxes.push(new am4charts.ValueAxis());
    YAxis.renderer.grid.template.stroke =
      gridLines.color || (theme === "dark" ? "#ffffff" : "#000000");
    YAxis.renderer.grid.template.strokeOpacity = gridLines.opacity || 0.15;
    YAxis.renderer.grid.template.strokeWidth = gridLines.width || 1;
		if (yAxis && yAxis.title && yAxis.title.text !== "") {
			YAxis.title.text = yAxis.title.text;
			YAxis.title.fontWeight = "bold";
			YAxis.title.fontSize = yAxis.title.fontSize || 20;
			YAxis.title.fill =
			  yAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		let yAxisLabels = YAxis.renderer.labels.template;
		yAxisLabels.fontSize = yAxis.labels.fontSize || 17;
		yAxisLabels.rotation = yAxis.labels.rotation || 0;
		yAxisLabels.fill =
		  yAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		// we set fixed min/max and strictMinMax to true, as otherwise value axis will adjust min/max while dragging and it won't look smooth
		YAxis.strictMinMax = true;
		YAxis.min = minY;
		YAxis.max = maxY;
		YAxis.renderer.minWidth = 60;

    /* ~~~~\  legend  /~~~~ */
    if(this.props.legend) {
      chart.legend = new am4charts.Legend();
      chart.legend.useDefaultMarker = false;
      let markerTemplate = chart.legend.markers.template;
      markerTemplate.width = 20;
      markerTemplate.strokeWidth = 1;
      markerTemplate.strokeOpacity = 1;
//      markerTemplate.stroke = am4core.color("#000000"); no effect
      chart.legend.itemContainers.template.events.on("over", function(ev) {
        ev.target.dataItem.dataContext.bulletsContainer.children.each(
          function(bullet){
            bullet.children.each(
              function(c){c.isHover = true;}
            );
          }
        );
      });
      chart.legend.itemContainers.template.events.on("out", function(ev) {
        ev.target.dataItem.dataContext.bulletsContainer.children.each(
          function(bullet){
            bullet.children.each(
              function(c){c.isHover = false;}
            );
          }
        );
      });
    }

		/* ~~~~\  function handling the drag event  /~~~~ */
		function handleDrag(event) {
			var dataItem = event.target.dataItem;
			// convert coordinate to value
			let value = YAxis.yToValue(event.target.pixelY);
			// set new value
			dataItem.valueY = value;
			// make line hover
			dataItem.segment.isHover = true;
			// hide tooltip not to interrupt
			dataItem.segment.hideTooltip(0);
			// make bullet hovered (as it might hide if mouse moves away)
			event.target.isHover = true;
		}

		/* ~~~~\  function handling the dragstop event  /~~~~ */
		function handleDragStop(event, value) {
      console.log("bullet dragstop");
      handleDrag(event);
      let dataItem = event.target.dataItem;
      dataItem.component.isHover = false; // XXXX
      event.target.isHover = false;
      dataCopy[dataItem.index][value] = dataItem.values.valueY.value;

      if(trendJS && trendJS[value]){
        let newvalue = YAxis.yToValue(event.target.pixelY),
          seriesNames = chart.series.values.map(function(x){return x.name}),
          thisSeriesName = dataItem.component.name,
          thisSeriesData = dataItem.component.dataProvider.data,
          thisSeriesDataCopy = thisSeriesData.map(row => ({...row}));
			  thisSeriesDataCopy[dataItem.index][value] = newvalue;
			  thisSeriesData[dataItem.index][value] = newvalue;
			  let trendSeriesName = thisSeriesName + "_trend",
			    trendSeriesIndex = seriesNames.indexOf(trendSeriesName),
			    trendSeries = chart.series.values[trendSeriesIndex],
			    trendSeriesData = trendSeries.data,
			    regData = thisSeriesDataCopy.map(function(row){
			      return [row[xValue], row[value]];
			    }),
			    fit = regression.polynomial(
			      regData, { order: trendJS[value], precision: 15 }
			    ),
			    regressionLine = trendSeriesData.map(function(row){
			      let xy = fit.predict(row.x);
			      return {x: xy[0], y: xy[1]};
			    });
			  regressionLine.forEach(function(point, i){trendSeriesData[i] = point;});
			  trendSeries.invalidateData();
			}

      if(window.Shiny) {
        if(isDate) {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframeWithDate",
            {
              data: dataCopy,
              date: xValue
            }
          );
          Shiny.setInputValue(shinyId + "_change:rAmCharts4.lineChange", {
            index: dataItem.index,
            x: dataItem.dateX,
            variable: value,
            y: dataItem.values.valueY.value
          });
        } else {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframe", dataCopy
          );
          Shiny.setInputValue(shinyId + "_change", {
            index: dataItem.index,
            x: dataItem.values.valueX.value,
            variable: value,
            y: dataItem.values.valueY.value
          });
        }
      }
		}

		yValues.forEach(function(value, index){

      let series = chart.series.push(new am4charts.LineSeries());
      series.strokeOpacity = 0;
      if(isDate) {
        series.dataFields.dateX = xValue;
      } else {
        series.dataFields.valueX = xValue;
      }
      series.dataFields.valueY = value;
      series.name = yValueNames[value];
      series.sequencedInterpolation = true;
      series.defaultState.interpolationDuration = 1500;

      /* ~~~~\  value label  /~~~~ */
/*    let valueLabel = new am4charts.LabelBullet();
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
      */

      /* ~~~~\  bullet  /~~~~ */
      let bullet = series.bullets.push(new am4charts.Bullet());
      let shape =
        utils.Shape(am4core, chart, index, bullet, pointsStyle[value]);
      if(tooltips) {
        /* ~~~~\  tooltip  /~~~~ */
        bullet.tooltipText = tooltips[value].text;
        let tooltip = utils.Tooltip(am4core, chart, index, tooltips[value]);
        tooltip.pointerOrientation = "vertical";
        tooltip.dy = 0;
        tooltip.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        tooltip.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return "none";
            } else {
              return "bottom";
            }
          } else {
            return x;
          }
        });
        tooltip.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        bullet.tooltip = tooltip;
        // hide label when hovered because the tooltip is shown
        // XXX y'a pas de label
/*      bullet.events.on("over", event => {
          let dataItem = event.target.dataItem;
          console.log("dataItem bullet on over", dataItem);
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        bullet.events.on("out", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });
        */
      }
      // create bullet hover state
      let hoverState = shape.states.create("hover");
      hoverState.properties.strokeWidth = shape.strokeWidth + 3;
      if(draggable[value]){
        bullet.draggable = true;
        // resize cursor when over
        bullet.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        // while dragging
        bullet.events.on("drag", event => {
          handleDrag(event);
        });
        // on dragging stop
        bullet.events.on("dragstop", event => {
          handleDragStop(event, value);
        });
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        bullet.events.on("down", event => {
          let dataItem = event.target.dataItem;
          let itemBullet = dataItem.bullets.getKey(bullet.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when point position changes, adjust minX/maxX of bullets so that we could only dragg vertically
        bullet.events.on("positionchanged", event => {
          let dataItem = event.target.dataItem;
          if(dataItem.bullets) {
            let itemBullet = dataItem.bullets.getKey(bullet.uid);
            let point = dataItem.point;
            itemBullet.minX = point.x;
            itemBullet.maxX = itemBullet.minX;
            itemBullet.minY = 0;
            itemBullet.maxY = chart.seriesContainer.pixelHeight;
          }
        });
      }

      /* ~~~~\ trend line /~~~~ */
      if(trendData && trendData[value]) {
        let trend = chart.series.push(new am4charts.LineSeries());
        trend.name = yValueNames[value] + "_trend";
        trend.hiddenInLegend = true;
        trend.data = trendData[value];
        trend.dataFields.valueX = "x";
        trend.dataFields.valueY = "y";
        trend.sequencedInterpolation = true;
        trend.defaultState.interpolationDuration = 1500;
        let trendStyle = trendStyles[value];
        trend.strokeWidth = trendStyle.width || 3;
        trend.stroke = trendStyle.color ||
          chart.colors.getIndex(index).saturate(0.7);
        if(trendStyle.dash)
          trend.strokeDasharray = trendStyle.dash;
        trend.tensionX = trendStyle.tensionX || 0.8;
        trend.tensionY = trendStyle.tensionY || 0.8;
      }

    }); /* end of forEach */

    this.chart = chart;

  }

  componentWillUnmount() {
    if(this.chart) {
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


/* COMPONENT: RANGE AREA CHART */

class AmRangeAreaChart extends React.PureComponent {

  constructor(props) {
    super(props);
    this.style = this.style.bind(this);
    this.toggleHover = this.toggleHover.bind(this);
  }

  style() {
    if(window.Shiny && !window.FlexDashboard) {
      return {width: "100%", height: "100%"};
    } else {
      return {width: this.props.width, height: this.props.height};
    }
  }

  toggleHover(series, over) {
    series.segments.each(function(segment) {
      segment.isHover = over;
    });
  }


  componentDidMount() {

    let theme = this.props.theme,
      xValue = this.props.xValue,
      yValues = this.props.yValues,
      data = utils.subset(this.props.data, [xValue].concat(yValues.flat())),
      data2 = this.props.data2 ?
        HTMLWidgets.dataframeToD3(
          utils.subset(this.props.data2, yValues.flat())
        ) : null,
      yValueNames = this.props.yValueNames,
      isDate = this.props.isDate,
      minX = isDate ? utils.toDate(this.props.minX) : this.props.minX,
      maxX = isDate ? utils.toDate(this.props.maxX) : this.props.maxX,
      minY = this.props.minY,
      maxY = this.props.maxY,
      xAxis = this.props.xAxis,
      yAxis = this.props.yAxis,
      gridLines = this.props.gridLines,
      draggable = this.props.draggable,
      tooltips = this.props.tooltip,
      bulletsStyle = this.props.bullets,
      alwaysShowBullets = this.props.alwaysShowBullets,
      valueFormatter = this.props.valueFormatter,
      lineStyles = this.props.lineStyle,
      areas = this.props.areas,
      chartId = this.props.chartId,
      shinyId = this.props.shinyId;

    if(isDate) {
      data[xValue] = data[xValue].map(utils.toDate);
    }
    data = HTMLWidgets.dataframeToD3(data);
    let dataCopy = data.map(row => ({...row}));

    if(window.Shiny) {
      if(shinyId === undefined){
        shinyId = $(document.getElementById(chartId)).parent().attr("id");
      }
      if(isDate) {
        Shiny.setInputValue(
          shinyId + ":rAmCharts4.dataframeWithDate",
          {
            data: dataCopy,
            date: xValue
          }
        );
      } else {
        Shiny.setInputValue(
          shinyId + ":rAmCharts4.dataframe", dataCopy
        );
      }
    }


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
		if(chartTitle) {
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
    if(chartCaption) {
      let caption = chart.chartContainer.createChild(am4core.Label);
      caption.text = chartCaption.text;
      caption.fill =
        chartCaption.color || (theme === "dark" ? "#ffffff" : "#000000");
      caption.align = chartCaption.align || "right";
    }


    /* ~~~~\  image  /~~~~ */
    let img = this.props.image;
    if(img) {
      let image = chart.chartContainer.createChild(am4core.Image);
      image.width = img.width || 60;
      image.height = img.height || 60;
      image.verticalCenter = "top";
      image.horizontalCenter = "left";
      image.align = img.align || "right";
      image.href = img.base64;
    }


    /* ~~~~\  scrollbars  /~~~~ */
    if(this.props.scrollbarX) {
      chart.scrollbarX = new am4core.Scrollbar();
    }
    if(this.props.scrollbarY) {
      chart.scrollbarY = new am4core.Scrollbar();
    }


		/* ~~~~\  button  /~~~~ */
		let button = this.props.button;
		if(button) {
  		let Button = chart.chartContainer.createChild(am4core.Button);
      Button.label.text = button.text;
      Button.label.fill = button.color || Button.label.fill;
      Button.background.fill = button.fill || Button.background.fill;
      Button.dy = -Button.parent.innerHeight * (button.position || 0.8);
      Button.padding(5, 5, 5, 5);
      Button.align = "right";
      Button.marginRight = 15;
      Button.events.on("hit", function() {
        for(let r = 0; r < data.length; ++r){
          for(let v = 0; v < yValues.length; ++v) {
            chart.data[r][yValues[v][0]] = data2[r][yValues[v][0]];
            chart.data[r][yValues[v][1]] = data2[r][yValues[v][1]];
          }
        }
        chart.invalidateRawData();
        if(window.Shiny) {
          if(isDate) {
            Shiny.setInputValue(
              shinyId + ":rAmCharts4.dataframeWithDate",
              {
                data: chart.data,
                date: xValue
              }
            );
            Shiny.setInputValue(shinyId + "_change", null);
          } else {
            Shiny.setInputValue(
              shinyId + ":rAmCharts4.dataframe", chart.data
            );
            Shiny.setInputValue(shinyId + "_change", null);
          }
        }
      });
		}

		/* ~~~~\  x-axis  /~~~~ */
		let XAxis;
		if(isDate) {
		  XAxis = chart.xAxes.push(new am4charts.DateAxis());
		} else {
		  XAxis = chart.xAxes.push(new am4charts.ValueAxis());
		}
		XAxis.strictMinMax = true;
		XAxis.min = minX;
		XAxis.max = maxX;
		XAxis.renderer.grid.template.location = 0;
		if(xAxis && xAxis.title && xAxis.title.text !== ""){
  		XAxis.title.text = xAxis.title.text || xValue;
  		XAxis.title.fontWeight = "bold";
  		XAxis.title.fontSize = xAxis.title.fontSize || 20;
  		XAxis.title.fill =
  		  xAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		var xAxisLabels = XAxis.renderer.labels.template;
		xAxisLabels.fontSize = xAxis.labels.fontSize || 17;
		xAxisLabels.rotation = xAxis.labels.rotation || 0;
		if(xAxisLabels.rotation !== 0){
		  xAxisLabels.horizontalCenter = "right";
		}
		xAxisLabels.fill =
		  xAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		if(isDate) {
		  XAxis.dataFields.dateX = xValue;
		} else {
  		XAxis.dataFields.valueX = xValue;
  	}
		XAxis.renderer.grid.template.disabled = true;
		XAxis.renderer.minGridDistance = 50;
		XAxis.numberFormatter.numberFormat = valueFormatter;

		/* ~~~~\  y-axis  /~~~~ */
		let YAxis = chart.yAxes.push(new am4charts.ValueAxis());
		YAxis.tooltip.disabled = true;
    YAxis.renderer.grid.template.stroke =
      gridLines.color || (theme === "dark" ? "#ffffff" : "#000000");
    YAxis.renderer.grid.template.strokeOpacity = gridLines.opacity || 0.15;
    YAxis.renderer.grid.template.strokeWidth = gridLines.width || 1;
		if (yAxis && yAxis.title && yAxis.title.text !== "") {
			YAxis.title.text = yAxis.title.text;
			YAxis.title.fontWeight = "bold";
			YAxis.title.fontSize = yAxis.title.fontSize || 20;
			YAxis.title.fill =
			  yAxis.title.color || (theme === "dark" ? "#ffffff" : "#000000");
		}
		if(yAxis.labels !== false) {
  		let yAxisLabels = YAxis.renderer.labels.template;
	  	yAxisLabels.fontSize = yAxis.labels.fontSize || 17;
		  yAxisLabels.rotation = yAxis.labels.rotation || 0;
		  yAxisLabels.fill =
		    yAxis.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
		} else {
		  YAxis.renderer.labels.template.disabled = true;
		}
		// we set fixed min/max and strictMinMax to true, as otherwise value axis will adjust min/max while dragging and it won't look smooth
		YAxis.strictMinMax = true;
		YAxis.min = minY;
		YAxis.max = maxY;
		YAxis.renderer.minWidth = 60;


    /* ~~~~\  legend  /~~~~ */
    if(this.props.legend) {
      let legend = new am4charts.Legend();
      legend.useDefaultMarker = false;
      legend.events.on("dataitemsvalidated", function(ev) {
        let allSeries = chart.series.values;
        ev.target.markers.values.forEach(function(container, index){
          let y2series = allSeries[2*index+1];
          let line = new am4core.Line();
          line.stroke = y2series.stroke;
          line.valign = "bottom";
          line.x2 = 40; // it is the width given below
          line.strokeWidth = y2series.strokeWidth;
          line.strokeOpacity = y2series.strokeOpacity;
          //let l = chart.legend.markers.template.createChild(am4core.Line);
          //chart.legend.markers.values[0].children.push(line);
          line.parent = container;
          //console.log("l", l);
          let children = container.children.values.map(
            function(child){ return child.className; }
          ),
            bullet = children.indexOf("Bullet");
          if(bullet > -1)
            container.children.values[bullet].dispose();
        });
      });

      let markerTemplate = legend.markers.template;
      markerTemplate.width = 40;
      markerTemplate.strokeWidth = 1;
      markerTemplate.strokeOpacity = 1;

      let toggleHover = this.toggleHover;
      legend.itemContainers.template.events.on("over", function(ev) {
        let thisSeries = ev.target.dataItem.dataContext;
        toggleHover(thisSeries, true);
        let allSeries = chart.series.values,
          seriesNames = allSeries.map(function(x){return x.name}),
          y2 = thisSeries.dataFields.openValueY,
          y2series = allSeries[seriesNames.indexOf(y2)];
        toggleHover(y2series, true);
      });
      legend.itemContainers.template.events.on("out", function(ev) {
        let thisSeries = ev.target.dataItem.dataContext;
        toggleHover(thisSeries, false);
        let allSeries = chart.series.values,
          seriesNames = allSeries.map(function(x){return x.name}),
          y2 = thisSeries.dataFields.openValueY,
          y2series = allSeries[seriesNames.indexOf(y2)];
        toggleHover(y2series, false);
      });

      chart.legend = legend;
    }

		/* ~~~~\  function handling the drag event  /~~~~ */
		function handleDrag(event) {
			let dataItem = event.target.dataItem;
			//console.log("dataItem", dataItem);
			// convert coordinate to value
			let value = YAxis.yToValue(event.target.pixelY);
			// set new value
			dataItem.valueY = value;
			// make line hover
			dataItem.segment.isHover = true;
			// hide tooltip not to interrupt
			dataItem.segment.hideTooltip(0);
			// make bullet hovered (as it might hide if mouse moves away)
			event.target.isHover = true;
		}

		/* ~~~~\  function handling the dragstop event  /~~~~ */
		function handleDragStop(event, value) {
      console.log("bullet dragstop");
      handleDrag(event);
      let dataItem = event.target.dataItem;
      dataItem.component.isHover = false; // XXXX
      event.target.isHover = false;
      dataCopy[dataItem.index][value] = dataItem.values.valueY.value;

      if(window.Shiny) {
        if(isDate) {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframeWithDate",
            {
              data: dataCopy,
              date: xValue
            }
          );
          Shiny.setInputValue(shinyId + "_change:rAmCharts4.lineChange", {
            index: dataItem.index,
            x: dataItem.dateX,
            variable: value,
            y: dataItem.values.valueY.value
          });
        } else {
          Shiny.setInputValue(
            shinyId + ":rAmCharts4.dataframe", dataCopy
          );
          Shiny.setInputValue(shinyId + "_change", {
            index: dataItem.index,
            x: dataItem.values.valueX.value,
            variable: value,
            y: dataItem.values.valueY.value
          });
        }
      }
		}


		yValues.forEach(function(y1y2, index){

      let y1 = y1y2[0], y2 = y1y2[1];

      let lineStyle1 = lineStyles[y1];
      let lineStyle2 = lineStyles[y2];

      let series1 = chart.series.push(new am4charts.LineSeries()),
        series2 = chart.series.push(new am4charts.LineSeries());
        series2.hiddenInLegend = true;
      if(isDate) {
        series1.dataFields.dateX = xValue;
        series2.dataFields.dateX = xValue;
      } else {
        series1.dataFields.valueX = xValue;
        series2.dataFields.valueX = xValue;
      }
      series1.dataFields.valueY = y1;
      series2.dataFields.valueY = y2;
      series1.name = areas[index].name;
      series2.name = yValueNames[y2];
      series1.dataFields.openValueY = y2;
      series2.dataFields.openValueY = y1;
      //series1.tooltipText = "yyyyy";// "y1: {openValueY} y2: {valueY}";
      series1.fill = areas[index].color;
      series1.fillOpacity = areas[index].opacity;
      series2.fillOpacity = 0;
      series1.sequencedInterpolation = true;
      series2.sequencedInterpolation = true;
      series1.defaultState.interpolationDuration = 1000;
      series2.defaultState.interpolationDuration = 1500;
      series1.tensionX = lineStyle1.tensionX || 1;
      series1.tensionY = lineStyle1.tensionY || 1;
      series2.tensionX = lineStyle2.tensionX || 1;
      series2.tensionY = lineStyle2.tensionY || 1;
      chart.cursor = new am4charts.XYCursor();
      chart.cursor.xAxis = XAxis;
      console.log(chart.cursor);
      chart.cursor.tooltipText = "uuuu";
      /* ~~~~\  bullet  /~~~~ */
      let bullet1 = series1.bullets.push(new am4charts.Bullet()),
        shape1 = utils.Shape(am4core, chart, index, bullet1, bulletsStyle[y1]);
      let bullet2 = series2.bullets.push(new am4charts.Bullet()),
        shape2 = utils.Shape(am4core, chart, index, bullet2, bulletsStyle[y2]);
      if(!alwaysShowBullets){
        shape1.opacity = 0; // initially invisible
        shape1.defaultState.properties.opacity = 0;
        shape2.opacity = 0; // initially invisible
        shape2.defaultState.properties.opacity = 0;
      }
      if(tooltips) {
        /* ~~~~\  tooltip  /~~~~ */
        bullet1.tooltipText = tooltips[y1].text;
        let tooltip1 = utils.Tooltip(am4core, chart, index, tooltips[y1]);
        bullet2.tooltipText = tooltips[y2].text;
        let tooltip2 = utils.Tooltip(am4core, chart, index, tooltips[y2]);
        tooltip1.pointerOrientation = "vertical";
        tooltip1.dy = 0;
        tooltip2.pointerOrientation = "vertical";
        tooltip2.dy = 0;
        tooltip1.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        tooltip1.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return "none";
            } else {
              return "bottom";
            }
          } else {
            return x;
          }
        });
        tooltip1.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        tooltip2.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        tooltip2.label.adapter.add("verticalCenter", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return "none";
            } else {
              return "bottom";
            }
          } else {
            return x;
          }
        });
        tooltip2.label.adapter.add("rotation", (x, target) => {
          if(target.dataItem) {
            if(target.dataItem.valueY >= 0) {
              return 0;
            } else {
              return 180;
            }
          } else {
            return x;
          }
        });
        bullet1.tooltip = tooltip1;
        bullet2.tooltip = tooltip2;
        // hide label when hovered because the tooltip is shown
        // XXX y'a pas de label
      /*bullet.events.on("over", event => {
          let dataItem = event.target.dataItem;
          console.log("dataItem bullet on over", dataItem);
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 0;
        });
        // show label when mouse is out
        bullet.events.on("out", event => {
          let dataItem = event.target.dataItem;
          let itemLabelBullet = dataItem.bullets.getKey(valueLabel.uid);
          itemLabelBullet.fillOpacity = 1;
        });*/

      }
      // create bullet hover state
      let hoverState1 = shape1.states.create("hover");
      hoverState1.properties.strokeWidth = shape1.strokeWidth + 3;
      hoverState1.properties.opacity = 1; // visible when hovered
      let hoverState2 = shape2.states.create("hover");
      hoverState2.properties.strokeWidth = shape2.strokeWidth + 3;
      hoverState2.properties.opacity = 1; // visible when hovered
      if(draggable[y1]){
        bullet1.draggable = true;
        // resize cursor when over
        bullet1.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        // while dragging
        bullet1.events.on("drag", event => {
          handleDrag(event);
        });
        // on dragging stop
        bullet1.events.on("dragstop", event => {
          handleDragStop(event, y1);
        });
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        bullet1.events.on("down", event => {
          let dataItem = event.target.dataItem;
          let itemBullet = dataItem.bullets.getKey(bullet1.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when line position changes, adjust minX/maxX of bullets so that we could only dragg vertically
        bullet1.events.on("positionchanged", event => {
          let dataItem = event.target.dataItem;
          //console.log("dataItem", dataItem);
          if(dataItem.bullets) {
            let itemBullet = dataItem.bullets.getKey(bullet1.uid);
            let point = dataItem.point;
            itemBullet.minX = point.x;
            itemBullet.maxX = itemBullet.minX;
            itemBullet.minY = 0;
            itemBullet.maxY = chart.seriesContainer.pixelHeight;
          }
        });
      }
      if(draggable[y2]){
        bullet2.draggable = true;
        // resize cursor when over
        bullet2.cursorOverStyle = am4core.MouseCursorStyle.verticalResize;
        // while dragging
        bullet2.events.on("drag", event => {
          handleDrag(event);
        });
        // on dragging stop
        bullet2.events.on("dragstop", event => {
          handleDragStop(event, y2);
        });
        // start dragging bullet even if we hit on column not just a bullet, this will make it more friendly for touch devices
        bullet2.events.on("down", event => {
          let dataItem = event.target.dataItem;
          let itemBullet = dataItem.bullets.getKey(bullet2.uid);
          itemBullet.dragStart(event.pointer);
        });
        // when line position changes, adjust minX/maxX of bullets so that we could only dragg vertically
        bullet2.events.on("positionchanged", event => {
          let dataItem = event.target.dataItem;
          //console.log("dataItem", dataItem);
          if(dataItem.bullets) {
            let itemBullet = dataItem.bullets.getKey(bullet2.uid);
            let point = dataItem.point;
            itemBullet.minX = point.x;
            itemBullet.maxX = itemBullet.minX;
            itemBullet.minY = 0;
            itemBullet.maxY = chart.seriesContainer.pixelHeight;
          }
        });
      }


      /* ~~~~\  line template  /~~~~ */
      let lineTemplate1 = series1.segments.template,
        lineTemplate2 = series2.segments.template;
//      lineTemplate1.tooltipText = "{valueY}";
//      lineTemplate2.tooltipText = "y2: {valueY}";
      lineTemplate1.interactionsEnabled = true;
      lineTemplate2.interactionsEnabled = true;
      series1.strokeWidth = lineStyle1.width || 3;
      series2.strokeWidth = lineStyle2.width || 3;
      series1.stroke = lineStyle1.color ||
        chart.colors.getIndex(index).saturate(0.7);
      series2.stroke = lineStyle2.color ||
        chart.colors.getIndex(index).saturate(0.7);
      if(lineStyle1.dash)
        series1.strokeDasharray = lineStyle1.dash;
      if(lineStyle2.dash)
        series2.strokeDasharray = lineStyle2.dash;
      // line hover state
      let lineHoverState1 = lineTemplate1.states.create("hover"),
        lineHoverState2 = lineTemplate2.states.create("hover");;
      // you can change any property on hover state and it will be animated
      lineHoverState1.properties.fillOpacity = 0.4;
      lineHoverState1.properties.strokeWidth = series1.strokeWidth + 2;
      lineHoverState2.properties.fillOpacity = 0.4;
      lineHoverState2.properties.strokeWidth = series2.strokeWidth + 2;

    }); /* end of forEach */


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
    AmHorizontalBarChart: AmHorizontalBarChart,
    AmLineChart: AmLineChart,
    AmScatterChart: AmScatterChart,
    AmRangeAreaChart: AmRangeAreaChart
  },
  {}
);
