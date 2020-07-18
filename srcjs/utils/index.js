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
