% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/amDumbbellChart.R
\name{amDumbbellChart}
\alias{amDumbbellChart}
\title{HTML widget displaying a Dumbbell chart}
\usage{
amDumbbellChart(
  data,
  data2 = NULL,
  category,
  values,
  seriesNames = NULL,
  hline = NULL,
  yLimits = NULL,
  expandY = 5,
  valueFormatter = "#.",
  chartTitle = NULL,
  theme = NULL,
  animated = TRUE,
  draggable = FALSE,
  tooltip = NULL,
  segmentsStyle = NULL,
  bullets = NULL,
  backgroundColor = NULL,
  xAxis = NULL,
  yAxis = NULL,
  scrollbarX = FALSE,
  scrollbarY = FALSE,
  legend = NULL,
  caption = NULL,
  image = NULL,
  button = NULL,
  cursor = FALSE,
  width = NULL,
  height = NULL,
  export = FALSE,
  chartId = NULL,
  elementId = NULL
)
}
\arguments{
\item{data}{a dataframe}

\item{data2}{\code{NULL} or a dataframe used to update the data with the
button; its column names must include the column names of \code{data}
given in \code{values}, it must have the same number of rows as
\code{data} and its rows must be in the same order as those of \code{data}}

\item{category}{name of the column of \code{data} to be used for the
category axis}

\item{values}{a character matrix with two columns; each row corresponds to
a series and provides the names of two columns of \code{data} to be
used as the limits of the segments}

\item{seriesNames}{a character vector providing the names of the series
to appear in the legend; its length must equal the number of rows of the
\code{values} matrix: the n-th component corresponds to the n-th row of
the \code{values} matrix}

\item{hline}{an optional horizontal line to add to the chart; it must be a
named list of the form \code{list(value = h, line = settings)} where
\code{h} is the "intercept" and \code{settings} is a list of settings
created with \code{\link{amLine}}}

\item{yLimits}{range of the y-axis, a vector of two values specifying
the lower and the upper limits of the y-axis; \code{NULL} for default values}

\item{expandY}{if \code{yLimits = NULL}, a percentage of the range of the
y-axis used to expand this range}

\item{valueFormatter}{a
\href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string};
it is used to format the values displayed in the cursor tooltips,
the labels of the y-axis unless you specify
your own formatter in the \code{labels} field of the list passed on to
the \code{yAxis} option, and the values displayed in the tooltips unless
you specify your own tooltip text (see the first example of
\code{\link{amBarChart}} for the way to set
a number formatter in the tooltip text)}

\item{chartTitle}{chart title, it can be \code{NULL} or \code{FALSE} for no
title, a character string,
a list of settings created with \code{\link{amText}}, or a list with two
fields: \code{text}, a list of settings created with \code{\link{amText}},
and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}}

\item{theme}{theme, \code{NULL} or one of \code{"dataviz"},
\code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
\code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
\code{"microchart"}}

\item{animated}{Boolean, whether to animate the rendering of the graphic}

\item{draggable}{\code{TRUE}/\code{FALSE} to enable/disable dragging of
all bullets, otherwise a named list of the form
\code{list(value1 = TRUE, value2 = FALSE, ...)}}

\item{tooltip}{settings of the tooltips; \code{NULL} for default,
\code{FALSE} for no tooltip, otherwise a named list of the form
\code{list(value1 = settings1, value2 = settings2, ...)} where
\code{settings1}, \code{settings2}, ... are lists created with
\code{\link{amTooltip}}; this can also be a
single list of settings that will be applied to each series,
or a just a string for the text to display in the tooltip}

\item{segmentsStyle}{settings of the segments; \code{NULL} for default,
otherwise a named list of the form
\code{list(series1 = settings1, series2 = settings2, ...)} where
\code{series1}, \code{series2}, ... are the names of the series
provided in \code{seriesNames} and
\code{settings1}, \code{settings2}, ... are lists created with
\code{\link{amSegment}}; this can also be a
single list of settings that will be applied to each series}

\item{bullets}{settings of the bullets; \code{NULL} for default,
otherwise a named list of the form
\code{list(value1 = settings1, value2 = settings2, ...)} where
\code{settings1}, \code{settings2}, ... are lists created with
\code{\link{amCircle}}, \code{\link{amTriangle}} or
\code{\link{amRectangle}}; this can also be a
single list of settings that will be applied to each series}

\item{backgroundColor}{a color for the chart background; it can be
given by the name of a R color, the name of a CSS color, e.g.
\code{"lime"} or \code{"olive"}, an HEX code like
\code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
like \code{"hsl(360,11,255)"}}

\item{xAxis}{settings of the category axis given as a list, or just a string
for the axis title; the list of settings has four possible fields:
a field \code{title}, a list of settings for the axis title created
with \code{\link{amText}},
a field \code{labels}, a list of settings for the axis labels created
with \code{\link{amAxisLabels}},
a field \code{adjust}, a number defining the vertical adjustment of
the axis (in pixels), and
a field \code{gridLines}, a list of settings for
the grid lines created with \code{\link{amLine}}}

\item{yAxis}{settings of the value axis given as a list, or just a string
for the axis title; the list of settings has five possible fields:
a field \code{title}, a list of settings for the axis title created
with \code{\link{amText}},
a field \code{labels}, a list of settings for the axis labels created
with \code{\link{amAxisLabels}},
a field \code{adjust}, a number defining the horizontal adjustment of
the axis (in pixels),
a field \code{gridLines}, a list of settings for
the grid lines created with \code{\link{amLine}} and
a field \code{breaks} to control the axis breaks, an R object created with
\code{\link{amAxisBreaks}}}

\item{scrollbarX}{logical, whether to add a scrollbar for the category axis}

\item{scrollbarY}{logical, whether to add a scrollbar for the value axis}

\item{legend}{either a logical value, whether to display the legend, or
a list of settings for the legend created with \code{\link{amLegend}}}

\item{caption}{\code{NULL} or \code{FALSE} for no caption, a formatted
text created with \code{\link{amText}}, or a list with two fields:
\code{text}, a list created with \code{\link{amText}}, and \code{align},
can be \code{"left"}, \code{"right"} or \code{"center"}}

\item{image}{option to include an image at a corner of the chart;
\code{NULL} or \code{FALSE} for no image, otherwise a named list with four
possible fields: the field \code{image} (required) is a list created with
\code{\link{amImage}},
the field \code{position} can be \code{"topleft"}, \code{"topright"},
\code{"bottomleft"} or \code{"bottomright"}, the field \code{hjust}
defines the horizontal adjustment, and the field \code{vjust} defines
the vertical adjustment}

\item{button}{\code{NULL} for the default, \code{FALSE} for no button,
or a list of settings created with \code{\link{amButton}}; this button is
used to replace the current data with \code{data2}}

\item{cursor}{option to add a cursor on the chart; \code{FALSE} for no
cursor, \code{TRUE} for a cursor with default settings for the tooltips,
or a list of settings created with \code{\link{amTooltip}} to
set the style of the tooltips, or a list with three possible fields:
a field \code{tooltip}, a list of tooltip settings created with
\code{\link{amTooltip}}, a field
\code{extraTooltipPrecision}, an integer, the number of additional
decimals to display in the tooltips, and a field \code{modifier},
which defines a modifier for the
values displayed in the tooltips; a modifier is some JavaScript code
given as a string, which performs a modification of a string named
\code{text}, e.g. \code{modifier = "text = '>>>' + text;"}}

\item{width}{the width of the chart, e.g. \code{"600px"} or \code{"80\%"};
ignored if the chart is displayed in Shiny, in which case the width is
given in \code{\link{amChart4Output}}}

\item{height}{the height of the chart, e.g. \code{"400px"};
ignored if the chart is displayed in Shiny, in which case the height is
given in \code{\link{amChart4Output}}}

\item{export}{logical, whether to enable the export menu}

\item{chartId}{a HTML id for the chart}

\item{elementId}{a HTML id for the container of the chart; ignored if the
chart is displayed in Shiny, in which case the id is given by the Shiny id}
}
\description{
Create a HTML widget displaying a Dumbbell chart.
}
\examples{
dat <- data.frame(
  x = c("T0", "T1", "T2"),
  y1 = c(7, 15, 10),
  y2 = c(20, 25, 23),
  z1 = c(5, 10, 5),
  z2 = c(25, 20, 15)
)

amDumbbellChart(
  width = "500px",
  data = dat,
  draggable = TRUE,
  category = "x",
  values = rbind(c("y1","y2"), c("z1","z2")),
  seriesNames = c("Control", "Treatment"),
  yLimits = c(0, 30),
  segmentsStyle = list(
    "Control" = amSegment(width = 2),
    "Treatment" = amSegment(width = 2)
  ),
  bullets = list(
    y1 = amTriangle(strokeWidth = 0),
    y2 = amTriangle(rotation = 180, strokeWidth = 0),
    z1 = amTriangle(strokeWidth = 0),
    z2 = amTriangle(rotation = 180, strokeWidth = 0)
  ),
  tooltip = amTooltip("upper: {openValueY}\nlower: {valueY}", scale = 0.75),
  xAxis = list(
    title = amText(
      "timepoint",
      fontSize = 17, fontWeight = "bold", fontFamily = "Helvetica"
    )
  ),
  yAxis = list(
    title = amText(
      "response",
      fontSize = 17, fontWeight = "bold", fontFamily = "Helvetica"
    ),
    gridLines = amLine("silver", width = 1, opacity = 0.4)
  ),
  legend = amLegend(position = "right", itemsWidth = 15, itemsHeight = 15),
  backgroundColor = "lightyellow",
  theme = "dataviz"
)
}
