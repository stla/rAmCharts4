export const toDate = function(string) {
  let ymd = string.split("-");
  return new Date(ymd[0], ymd[1]-1, ymd[2]);
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
  function(am4core, Axis, values, lineconfig, labelsconfig, theme, isDate) {
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
    let isArray = Array.isArray(values);
    console.log(values);
    let length = isArray ? values.length : Object.keys(values).length;

    for(let i = 0; i < length; ++i) {
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
      }
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
