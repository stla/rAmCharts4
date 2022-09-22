# rAmCharts4 1.6.0 (2022-09-22)

* Upgraded 'amcharts4'.
* It is now possible to turn off the animation of the graphics rendering.
* The chart JavaScript object is now accessible with `htmlwidgets::onRender`.


# rAmCharts4 1.5.0 (2021-10-10)

* Fixed a bug: bullets were unresponsive on zooming.
* New option "zoom buttons" for the line chart and the scatter chart.


# rAmCharts4 1.4.1 (2021-09-30)

* Fixed a bug: `amPercentageBarChart` did not work with Shiny.
* New function `updateAmPercentageBarChart`, to update the data of a 100% 
stacked bar chart in Shiny.
* Enabled the data exporting (CSV, JSON, HTML).
* Upgraded 'amcharts4'.


# rAmCharts4 1.4.0 (2021-09-11)

Added the 100% stacked bar chart (`amPercentageBarChart`).


# rAmCharts4 1.3.2 (2021-06-25)

* Updated 'amcharts4'.
* Fixed bug #10 (chart did not dispose when using `renderUI`).


# rAmCharts4 1.3.1 (2021-03-06)

* Updated 'amcharts4'.
* Compliance with the new 'htmlwidgets' convention.


# rAmCharts4 1.3.0 (2021-01-11)

* New options for legends: `maxWidth`, `maxHeight`, and `scrollable`.
* New chart: pie chart.


# rAmCharts4 1.2.0 (2020-11-27)

* Updated 'amcharts4'.
* New option `colors` in `amStackedBarChart`, to set the colors of the bars.
* Possibility to add horizontal lines or vertical lines to the charts (options 
`hline` and `vline`).
* New chart: boxplot chart.


# rAmCharts4 1.1.0 (2020-10-30)

* Updated 'amcharts4'.
* New chart: stacked bar chart.
* New function `updateAmBarChart`, to update the data of a bar chart in Shiny 
(vertical, horizontal, radial, or stacked bar chart).


# rAmCharts4 1.0.0 (2020-10-01)

* Updated 'amcharts4'.
* New chart: gauge chart.


# rAmCharts4 0.1.0 (2020-08-24)

First release.
