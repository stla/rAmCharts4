/* jshint esversion: 6 */

export const toUTCtime = function(string) {
  let ymd = string.split("-");
  return Date.UTC(ymd[0], ymd[1]-1, ymd[2]);
};

export const toDate = function(string) {
  return new Date(toUTCtime(string));
};


export const subset = function(data, keys) {
  return keys.reduce((a,b) => (a[b]=data[b],a), {});
};


export const isLightColor = function(color) {  // color is given in HEX
  let r, g, b;
  color = +("0x" + color.slice(1).replace(
    color.length < 5 && /./g, '$&$&'
  ));
  r = color >> 16;
  g = color >> 8 & 255;
  b = color & 255;
  // HSP (Highly Sensitive Poo) equation from http://alienryderflex.com/hsp.html
  let hsp = Math.sqrt(
    0.299 * (r * r) +
    0.587 * (g * g) +
    0.114 * (b * b)
  );
  // Using the HSP value, determine whether the color is light or dark
  return hsp > 127.5;
};


export const Tooltip = function(am4core, chart, index, tooltipStyle) {
  let tooltip = new am4core.Tooltip();
  tooltip.getFillFromObject = tooltipStyle.auto;
  tooltip.background.fill = tooltipStyle.backgroundColor ||
    chart.colors.getIndex(index);
  tooltip.background.fillOpacity = tooltipStyle.backgroundOpacity || 0.6;
  tooltip.autoTextColor = tooltipStyle.auto || !tooltipStyle.textColor;
  tooltip.label.fill = tooltipStyle.textColor ||
    (isLightColor(am4core.color(tooltip.background.fill).hex) ? 'black' : 'white');
  tooltip.label.textAlign = tooltipStyle.textAlign;
  tooltip.background.stroke = tooltipStyle.borderColor ||
    am4core.color(tooltip.background.fill).lighten(-0.5);
  tooltip.background.strokeWidth = tooltipStyle.borderWidth;
  tooltip.scale = tooltipStyle.scale || 1;
  tooltip.background.filters.clear(); // remove tooltip shadow
  tooltip.background.pointerLength = tooltipStyle.pointerLength;

  return tooltip;
};


export const Shape = function(am4core, chart, index, bullet, shapeConfig) {
  let shape;
  switch(shapeConfig.shape) {
    case "triangle":
      shape = bullet.createChild(am4core.Triangle);
      shape.direction = shapeConfig.direction;
      shape.width = shapeConfig.width;
      shape.height = shapeConfig.height;
      shape.rotation = shapeConfig.rotation;
      break;
    case "circle":
      shape = bullet.createChild(am4core.Circle);
      shape.radius = shapeConfig.radius;
      break;
    case "rectangle":
      shape = bullet.createChild(am4core.RoundedRectangle);
      shape.width = shapeConfig.width;
      shape.height = shapeConfig.height;
      shape.rotation = shapeConfig.rotation;
      shape.cornerRadiusBottomLeft = shapeConfig.cornerRadius;
      shape.cornerRadiusTopLeft = shapeConfig.cornerRadius;
      shape.cornerRadiusBottomRight = shapeConfig.cornerRadius;
      shape.cornerRadiusTopRight = shapeConfig.cornerRadius;
      break;
  }
  shape.horizontalCenter = "middle";
  shape.verticalCenter = "middle";
  shape.fill = shapeConfig.color || chart.colors.getIndex(index);
  shape.fillOpacity = shapeConfig.opacity || 1;
  shape.strokeWidth = shapeConfig.strokeWidth;
  shape.stroke = shapeConfig.strokeColor ||
    chart.colors.getIndex(index).lighten(-0.5);
  shape.strokeOpacity = shapeConfig.strokeOpacity || 1;
  if(shapeConfig.colorAdapter) {
    shape.adapter.add("fill", shapeConfig.colorAdapter);
  }
  if(shapeConfig.strokeColorAdapter) {
    shape.adapter.add("stroke", shapeConfig.strokeColorAdapter);
  }
  if(shapeConfig.image) {
    let image = bullet.createChild(am4core.Image);
    image.width = shapeConfig.image.width;
    image.height = shapeConfig.image.height;
    image.horizontalCenter = "middle";
    image.verticalCenter = "middle";
    if(shapeConfig.image.href.match(/^inData:/)) {
      let href = shapeConfig.image.href.split(":")[1];
      image.propertyFields.href = href;
    } else {
      image.href = shapeConfig.image.href;
    }
  }

  return shape;
};


export const createGridLines =
  function(am4core, Axis, breaks, lineconfig, labelsconfig, theme, isDate) {
/*    if(labelsconfig && labelsconfig.formatter) {
      let formatter = labelsconfig.formatter;
      if(isDate) {
        Axis.dateFormats.setKey("day", formatter.day[0]);
        if(formatter.day[1]) {
          Axis.periodChangeDateFormats.setKey("day", formatter.day[1]);
        }
        Axis.dateFormats.setKey("week", formatter.week[0]);
        if(formatter.week[1]) {
          Axis.periodChangeDateFormats.setKey("week", formatter.week[1]);
        }
        Axis.dateFormats.setKey("month", formatter.month[0]);
        if(formatter.month[1]) {
          Axis.periodChangeDateFormats.setKey("month", formatter.month[1]);
        }
      } else {
        Axis.numberFormatter = new am4core.NumberFormatter();
        Axis.numberFormatter.numberFormat = formatter;
        Axis.adjustLabelPrecision = false;
      }
    } */
//let formatter = labelsconfig.formatter;
//    let isArray = Array.isArray(values);
//    console.log(values);
//    let length = isArray ? values.length : Object.keys(values).length;

    Axis.axisRanges.template.grid.location = 0.5;
    Axis.axisRanges.template.label.location = 0.5;
    if(!lineconfig) {
      Axis.axisRanges.template.grid.disabled = true;
    }

    for(let i = 0; i < breaks.value.length; ++i) {
      let range = Axis.axisRanges.create();

/*        range.component.dateFormats.setKey("day", formatter.day[0]);
        if(formatter.day[1]) {
          range.component.periodChangeDateFormats.setKey("day", formatter.day[1]);
        }
        range.component.dateFormats.setKey("week", formatter.week[0]);
        if(formatter.week[1]) {
          range.component.periodChangeDateFormats.setKey("week", formatter.week[1]);
        }
        range.component.dateFormats.setKey("month", formatter.month[0]);
        if(formatter.month[1]) {
          range.component.periodChangeDateFormats.setKey("month", formatter.month[1]);
        } */
      if(isDate) {
        range.value = toDate(breaks.value[i]);
        range.label.text = breaks.label[i] || "{date}";
        //range.label.location = 0.5;
        //range.grid.location = 0.5;
      } else {
        range.value = breaks.value[i];
        range.label.text = breaks.label[i] || "{value}";
      }

/*      if(isDate) {
        if(isArray) {
          range.date = toDate(values[i]);
          range.label.text = "{date}";
        } else {
          let entry = Object.entries(values)[i];
          console.log(entry);
          range.date = toDate(entry[1]);
          range.label.text = entry[0];
        }
      } else {
        if(isArray) {
          range.value = values[i];
          range.label.text = "{value}";
        } else {
          let entry = Object.entries(values)[i];
          range.value = entry[1];
          range.label.text = entry[0];
        }
      } */
      //range.xx = Axis.formatLabel(values[i]);
      console.log(range);
      if(lineconfig) {
        range.grid.stroke =
          lineconfig.color || (theme === "dark" ? "#ffffff" : "#000000");
        range.grid.strokeWidth = lineconfig.width || 1;
        range.grid.strokeOpacity = lineconfig.opacity || 0.2;
        if(lineconfig.dash) {
          range.grid.strokeDasharray = lineconfig.dash;
        }
      }
      if(labelsconfig) {
        range.label.fontSize = labelsconfig.fontSize || 17;
        range.label.rotation = labelsconfig.rotation || 0;
        range.label.fill =
          labelsconfig.color || (theme === "dark" ? "#ffffff" : "#000000");
      }
    }
/*    setTimeout(function() {
    for(let i = 0; i < values.length; ++i) {
      let range = Axis.axisRanges.getIndex(i);
      range.xx = Axis.getPositionLabel(Axis.valueToPosition(values[i]));
      range.label.text = "{date}";
    }
    }, 500); */
  };


export const createAxis = function(
  XY, am4charts, am4core, chart, axisSettings, 
  min, max, isDate, theme, cursor, xValue
){

  let Axis, Formatter;

  if(axisSettings.labels) {
    Formatter = axisSettings.labels.formatter;
  }

  if(isDate) {
    switch(XY) {
      case "X": 
        Axis = chart.xAxes.push(new am4charts.DateAxis());
        Axis.dataFields.dateX = xValue;
        break;
      case "Y": 
        Axis = chart.yAxes.push(new am4charts.DateAxis());
        break;  
    }
    if(Formatter) {
      Axis.dateFormats.setKey("day", Formatter.day[0]);
      if(Formatter.day[1]) {
        Axis.periodChangeDateFormats.setKey("day", Formatter.day[1]);
      }
      Axis.dateFormats.setKey("week", Formatter.week[0]);
      if(Formatter.week[1]) {
        Axis.periodChangeDateFormats.setKey("week", Formatter.week[1]);
      }
      Axis.dateFormats.setKey("month", Formatter.month[0]);
      if(Formatter.month[1]) {
        Axis.periodChangeDateFormats.setKey("month", Formatter.month[1]);
      }
    }
  } else {
    switch(XY) {
      case "X": 
        Axis = chart.xAxes.push(new am4charts.ValueAxis());
        Axis.dataFields.valueX = xValue;
        break;
      case "Y": 
        Axis = chart.yAxes.push(new am4charts.ValueAxis());
        break;  
    }
    if(Formatter) {
      Axis.numberFormatter = new am4core.NumberFormatter();
      Axis.numberFormatter.numberFormat = Formatter;
      Axis.adjustLabelPrecision = false;
    }
  }

  Axis.renderer.minWidth = 60;

  if(axisSettings) {
    switch(XY) {
      case "X": 
        Axis.paddingBottom = axisSettings.adjust || 0;
        break;
      case "Y": 
        Axis.paddingRight = axisSettings.adjust || 0;
        break;  
    }
  }

  Axis.strictMinMax = true;
  Axis.min = min;
  Axis.max = max;

  if(axisSettings && axisSettings.title && axisSettings.title.text !== "") {
    Axis.title.text = axisSettings.title.text;
    Axis.title.fontWeight = "bold";
    Axis.title.fontSize = axisSettings.title.fontSize || 20;
    Axis.title.fill =
      axisSettings.title.color || (theme === "dark" ? "#ffffff" : "#000000");
  }

  let BreaksType; 
  if(axisSettings.breaks) { 
    BreaksType = 
      typeof axisSettings.breaks === "number" ? "interval" : 
      (Array.isArray(axisSettings.breaks) ? "timeInterval" : "breaks");
  }

  if(axisSettings.gridLines) {
    if(BreaksType === "interval")
      Axis.renderer.minGridDistance = axisSettings.breaks;
    Axis.renderer.grid.template.stroke =
      axisSettings.gridLines.color || (theme === "dark" ? "#ffffff" : "#000000");
    Axis.renderer.grid.template.strokeOpacity = 
      axisSettings.gridLines.opacity || 0.2;
    Axis.renderer.grid.template.strokeWidth = 
      axisSettings.gridLines.width || 1;
    if(axisSettings.gridLines.dash) {
      Axis.renderer.grid.template.strokeDasharray = 
        axisSettings.gridLines.dash;
    }
  } else {
    Axis.renderer.grid.template.disabled = true;
  }

  if(BreaksType === "breaks") {
    Axis.renderer.grid.template.disabled = true;
    Axis.renderer.labels.template.disabled = true;
    if(isDate) {
      Axis.renderer.minGridDistance = 10;
      Axis.startLocation = 0.5; // ??
      Axis.endLocation = 0.5; // ??
    }
    createGridLines(
      am4core, Axis, axisSettings.breaks, axisSettings.gridLines, 
      axisSettings.labels, theme, isDate
    );
  } else {
    if(BreaksType === "timeInterval") {
      Axis.gridIntervals.setAll(axisSettings.breaks);
      Axis.renderer.grid.template.location = 0.5;
      Axis.renderer.labels.template.location = 0.5;
      Axis.startLocation = 0.5; // ??
      Axis.endLocation = 0.5; // ??
    }
    let axisSettingsLabels = Axis.renderer.labels.template;
    axisSettingsLabels.fontSize = axisSettings.labels.fontSize || 17;
    axisSettingsLabels.rotation = axisSettings.labels.rotation || 0;
    if(XY === "x" && axisSettingsLabels.rotation !== 0) {
      axisSettingsLabels.horizontalCenter = "right";
    }
    axisSettingsLabels.fill =
      axisSettings.labels.color || (theme === "dark" ? "#ffffff" : "#000000");
  }

  if(XY === "X") {
    if(cursor &&
      (cursor === true || !cursor.axes || ["x","xy"].indexOf(cursor.axes)) > -1)
    {
      if(cursor.tooltip)
        Axis.tooltip = Tooltip(am4core, chart, 0, cursor.tooltip);
      if(cursor.extraTooltipPrecision)
        Axis.extraTooltipPrecision = cursor.extraTooltipPrecision.x;
      if(cursor.renderer && cursor.renderer.x)
        Axis.adapter.add("getTooltipText", cursor.renderer.x);
      if(cursor.dateFormat)
        Axis.tooltipDateFormat = cursor.dateFormat;
    } else {
      Axis.cursorTooltipEnabled = false;
    }
  } else {
    if(cursor &&
      (cursor === true || !cursor.axes || ["y","xy"].indexOf(cursor.axes)) > -1)
    {
      if(cursor.tooltip)
        Axis.tooltip = Tooltip(am4core, chart, 0, cursor.tooltip);
      if(cursor.extraTooltipPrecision)
        Axis.extraTooltipPrecision = cursor.extraTooltipPrecision.y;
      if(cursor.renderer && cursor.renderer.y)
        Axis.adapter.add("getTooltipText", cursor.renderer.y);
      if(cursor.dateFormat)
        Axis.tooltipDateFormat = cursor.dateFormat;
    } else {
      Axis.cursorTooltipEnabled = false;
    }
  }

  return Axis;
};


export const Image = function(am4core, chart, settings) {
  let img = settings.image;
  img.position = settings.position;
  img.hjust = settings.hjust;
  img.vjust = settings.vjust;
  let image = chart.topParent.children.getIndex(1).createChild(am4core.Image); // same as: chart.logo.parent.createChild(am4core.Image);
  image.layout = "absolute";
  image.width = img.width || 60;
  image.height = img.height || 60;
  image.fillOpacity = img.opacity || 1;
  img.position = img.position || "bottomleft";
  switch(img.position) {
    case "bottomleft":
      chart.logo.dispose();
      image.x = 0;
      image.y = chart.pixelHeight - image.height;
      break;
    case "bottomright":
      image.x = chart.pixelWidth - image.width;
      image.y = chart.pixelHeight - image.height;
      break;
    case "topleft":
      image.x = 0;
      image.y = 0;
      break;
    case "topright":
      image.x = chart.pixelWidth - image.width;
      image.y = 0;
      break;
  }
  image.dx = img.hjust || 0;
  image.dy = img.vjust || 0;
  image.href = img.href;
};


export const exportMenuItems = [
  {
    "label": "Export",
    "menu": [
      { "type": "png", "label": "PNG" },
      { "type": "jpg", "label": "JPG" },
      { "type": "svg", "label": "SVG" },
      { "label": "Print", "type": "print" }
    ]
  }
];