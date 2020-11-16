#' HTML widget displaying a line chart
#' @description Create a HTML widget displaying a line chart.
#'
#' @param data a dataframe
#' @param data2 \code{NULL} or a dataframe used to update the data with the
#'   button; its column names must include the column names of \code{data}
#'   given in \code{yValues} as well as the column name given in \code{xValue};
#'   moreover it must have the same number of rows as \code{data} and its rows
#'   must be in the same order as those of \code{data}
#' @param xValue name of the column of \code{data} to be used on the x-axis
#' @param yValues name(s) of the column(s) of \code{data} to be used on the
#'   y-axis
#' @param yValueNames names of the variables on the y-axis, to appear in the
#'   legend; \code{NULL} to use \code{yValues} as names, otherwise a named list
#'   of the form \code{list(yvalue1 = "ValueName1", yvalue2 = "ValueName2", ...)}
#'   where \code{yvalue1}, \code{yvalue2}, ... are the column names given in
#'   \code{yValues} and \code{"ValueName1"}, \code{"ValueName2"}, ... are the
#'   desired names to appear in the legend
#' @param hline an optional horizontal line to add to the chart; it must be a
#'   named list of the form \code{list(value = h, line = settings)} where
#'   \code{h} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param vline an optional vertical line to add to the chart; it must be a
#'   named list of the form \code{list(value = v, line = settings)} where
#'   \code{v} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param xLimits range of the x-axis, a vector of two values specifying the
#'   left and right limits of the x-axis; \code{NULL} for default values
#' @param yLimits range of the y-axis, a vector of two values specifying the
#'   lower and the upper limits of the y-axis; \code{NULL} for default values
#' @param expandX if \code{xLimits = NULL}, a percentage of the range of the
#'   x-axis used to expand this range
#' @param expandY if \code{yLimits = NULL}, a percentage of the range of the
#'   y-axis used to expand this range
#' @param Xformatter a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string}
#'   if \code{xValue} is set to a numeric column of \code{data};
#'   it is used to format the values displayed in the cursor tooltips if
#'   \code{cursor = TRUE}, the labels of the x-axis unless you specify
#'   your own formatter in the \code{labels} field of the list passed on to
#'   the \code{xAxis} option, and the values displayed in the tooltips unless
#'   you specify your own tooltip text;
#'   if \code{xValue} is set to a date column of \code{data}, this option should
#'   be set to a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-date-time/}{date formatting string},
#'   and it has an effect only on the values displayed in the tooltips (unless
#'   you specify your own tooltip text); formatting the dates on the x-axis is
#'   done via the \code{labels} field of the list passed on to the \code{xAxis}
#'   option
#' @param Yformatter a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string};
#'   it is used to format the values displayed in the cursor tooltips if
#'   \code{cursor = TRUE}, the labels of the y-axis unless you specify
#'   your own formatter in the \code{labels} field of the list passed on to
#'   the \code{yAxis} option, and the values displayed in the tooltips unless
#'   you specify your own tooltip text (see the first example of
#'   \code{\link{amBarChart}} for the way to set a number formatter in the
#'   tooltip text)
#' @param trend option to request trend lines and to set their settings;
#'   \code{FALSE} for no trend line, otherwise a named list of the form
#'   \code{list(yvalue1 = trend1, yvalue2 = trend2, ...)} where
#'   \code{trend1}, \code{trend2}, ... are lists with the following fields:
#'   \describe{
#'     \item{\code{method}}{
#'       the modelling method, can be \code{"lm"}, \code{"lm.js"}, \code{"nls"},
#'       \code{"nlsLM"}, or \code{"loess"}; \code{"lm.js"} performs a polynomial
#'       regression in JavaScript, its advantage is that the fitted regression
#'       line is updated when the points of the line are dragged
#'     }
#'     \item{\code{formula}}{
#'       a formula passed on to the modelling function for methods \code{"lm"},
#'       \code{"nls"} or \code{"nlsLM"}; the
#'       lefthandside of this formula must always be \code{y}, and its
#'       righthandside must be a symbolic expression depending on \code{x} only,
#'       e.g. \code{y ~ x}, \code{y ~ x + I(x^2)}, \code{y ~ poly(x,2)}
#'     }
#'     \item{\code{interval}}{
#'       effective for methods \code{"lm"} and \code{"lm.js"} only;
#'       a list with five possible fields:
#'       \code{type} can be \code{"confidence"} or \code{"prediction"},
#'       \code{level} is the confidence or prediction level (number between 0
#'       and 1), \code{color} is the color of the shaded area, \code{opacity}
#'       is the opacity of the shaded area (number between 0 and 1),
#'       \code{tensionX} and \code{tensionY} to control the smoothing
#'       (see \code{\link{amLine}})
#'     }
#'     \item{\code{order}}{
#'       the order of the polynomial regression when \code{method = "lm.js"}
#'     }
#'     \item{\code{method.args}}{
#'       a list of additional arguments passed on to the modelling function
#'       defined by \code{method} for methods \code{"nls"}, \code{"nlsLM"} or
#'       \code{"loess"}, e.g. \code{method.args = list(span = 0.3)} for
#'       method \code{"loess"}
#'     }
#'     \item{\code{style}}{
#'       a list of settings for the trend line created with \code{\link{amLine}}
#'     }
#'   }
#'   it is also possible to request the same kind of trend lines for all series
#'   given by the \code{yValues} argument, by passing a list of the
#'   form \code{list("_all" = trendconfig)}, e.g.
#'   \code{list("_all" = list(method = "lm", formula = y ~ 0+x, style = amLine()))}
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @param theme theme, \code{NULL} or one of \code{"dataviz"},
#'   \code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
#'   \code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
#'   \code{"microchart"}
#' @param draggable \code{TRUE}/\code{FALSE} to enable/disable dragging of
#'   all lines, otherwise a named list of the form
#'   \code{list(yvalue1 = TRUE, yvalue2 = FALSE, ...)} to enable/disable the
#'   dragging for each series corresponding to a column given in \code{yValues}
#' @param tooltip settings of the tooltips; \code{NULL} for default,
#'   \code{FALSE} for no tooltip, otherwise a named list of the form
#'   \code{list(yvalue1 = settings1, yvalue2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amTooltip}}; this can also be a
#'   single list of settings that will be applied to each series,
#'   or a just a string for the text to display in the tooltip
#' @param bullets settings of the bullets; \code{NULL} for default,
#'   otherwise a named list of the form
#'   \code{list(yvalue1 = settings1, yvalue2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amCircle}}, \code{\link{amTriangle}} or
#'   \code{\link{amRectangle}}; this can also be a
#'   single list of settings that will be applied to each series
#' @param alwaysShowBullets logical, whether the bullets should always be
#'   visible, or visible on hover only
#' @param lineStyle settings of the lines; \code{NULL} for default,
#'   otherwise a named list of the form
#'   \code{list(yvalue1 = settings1, yvalue2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amLine}}; this can also be a
#'   single list of settings that will be applied to each line
#' @param backgroundColor a color for the chart background; it can be given by
#'   the name of a R color, the name of a CSS
#'   color, e.g. \code{"teal"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @template axesTemplate
#' @param scrollbarX logical, whether to add a scrollbar for the x-axis
#' @param scrollbarY logical, whether to add a scrollbar for the y-axis
#' @param legend \code{FALSE} for no legend, \code{TRUE} for a legend with
#'   default settings, or a list of settings created with
#'   \code{\link{amLegend}}
#' @param caption \code{NULL} or \code{FALSE} for no caption, a formatted
#'   text created with \code{\link{amText}}, or a list with two fields:
#'   \code{text}, a list created with \code{\link{amText}}, and \code{align},
#'   can be \code{"left"}, \code{"right"} or \code{"center"}
#' @param image option to include an image at a corner of the chart;
#'   \code{NULL} or \code{FALSE} for no image, otherwise a named list with four
#'   possible fields: the field \code{image} (required) is a list created with
#'   \code{\link{amImage}},
#'   the field \code{position} can be \code{"topleft"}, \code{"topright"},
#'   \code{"bottomleft"} or \code{"bottomright"}, the field \code{hjust}
#'   defines the horizontal adjustment, and the field \code{vjust} defines
#'   the vertical adjustment
#' @template buttonTemplate
#' @param cursor option to add a cursor on the chart; \code{FALSE} for no
#'   cursor, \code{TRUE} for a cursor for both axes with default settings
#'   for the axes tooltips,
#'   otherwise a named list with four possible fields: a field
#'   \code{axes} to specify the axes for which the cursor is requested, can be
#'   \code{"x"}, \code{"y"}, or \code{"xy"},
#'   a field \code{tooltip} to set the style of the axes tooltips, this
#'   must be a list of settings created with \code{\link{amTooltip}},
#'   a field \code{extraTooltipPrecision}, a named list of the form
#'   \code{list(x = i, y = j)} where \code{i} and \code{j} are the desired
#'   numbers of additional decimals for the tooltips on the x-axis and
#'   on the y-axis respectively, and a field \code{modifier}, a list with two
#'   possible fields, \code{x} and \code{y}, which defines modifiers for the
#'   values displayed in the tooltips; a modifier is some JavaScript code
#'   given a string, which performs a modification of a string named
#'   \code{text}, e.g. \code{"text = '[font-style:italic]' + text + '[/]';"};
#'   see the first example for an example of \code{modifier}
#' @param width the width of the chart, e.g. \code{"600px"} or \code{"80\%"};
#'   ignored if the chart is displayed in Shiny, in which case the width is
#'   given in \code{\link{amChart4Output}}
#' @param height the height of the chart, e.g. \code{"400px"};
#'   ignored if the chart is displayed in Shiny, in which case the height is
#'   given in \code{\link{amChart4Output}}
#' @param export logical, whether to enable the export menu
#' @param chartId a HTML id for the chart
#' @param elementId a HTML id for the container of the chart; ignored if the
#'   chart is displayed in Shiny, in which case the id is given by the Shiny id
#'
#' @import htmlwidgets minpack.lm
#' @importFrom shiny validateCssUnit
#' @importFrom lubridate is.Date is.POSIXt
#' @export
#'
#' @examples # a line chart with a numeric x-axis ####
#'
#' set.seed(666)
#' dat <- data.frame(
#'   x = 1:10,
#'   y1 = rnorm(10),
#'   y2 = rnorm(10)
#' )
#'
#' amLineChart(
#'   data = dat,
#'   width = "700px",
#'   xValue = "x",
#'   yValues = c("y1", "y2"),
#'   yValueNames = list(y1 = "Sample 1", y2 = "Sample 2"),
#'   trend = list(
#'     y1 = list(
#'       method = "lm.js",
#'       order = 3,
#'       style = amLine(color = "lightyellow", dash = "3,2")
#'     ),
#'     y2 = list(
#'       method = "loess",
#'       style = amLine(color = "palevioletred", dash = "3,2")
#'     )
#'   ),
#'   draggable = list(y1 = TRUE, y2 = FALSE),
#'   backgroundColor = "#30303d",
#'   tooltip = amTooltip(
#'     text = "[bold]({valueX},{valueY})[/]",
#'     textColor = "white",
#'     backgroundColor = "#101010",
#'     borderColor = "whitesmoke"
#'   ),
#'   bullets = list(
#'     y1 = amCircle(color = "yellow", strokeColor = "olive"),
#'     y2 = amCircle(color = "orangered", strokeColor = "darkred")
#'   ),
#'   alwaysShowBullets = TRUE,
#'   cursor = list(
#'     extraTooltipPrecision = list(x = 0, y = 2),
#'     modifier = list(
#'       y = c(
#'         "var value = parseFloat(text);",
#'         "var style = value > 0 ? '[#0000ff]' : '[#ff0000]';",
#'         "text = style + text + '[/]';"
#'       )
#'     )
#'   ),
#'   lineStyle = list(
#'     y1 = amLine(color = "yellow", width = 4),
#'     y2 = amLine(color = "orangered", width = 4)
#'   ),
#'   chartTitle = amText(
#'     text = "Gaussian samples",
#'     color = "whitesmoke",
#'     fontWeight = "bold"
#'   ),
#'   xAxis = list(title = amText(text = "Observation",
#'                              fontSize = 21,
#'                              color = "silver",
#'                              fontWeight = "bold"),
#'                labels = amAxisLabels(fontSize = 17),
#'                breaks = amAxisBreaks(
#'                  values = 1:10,
#'                  labels = sprintf("[bold %s]%d[/]", rainbow(10), 1:10))),
#'   yAxis = list(title = amText(text = "Value",
#'                              fontSize = 21,
#'                              color = "silver",
#'                              fontWeight = "bold"),
#'                labels = amAxisLabels(color = "whitesmoke",
#'                                      fontSize = 14),
#'                gridLines = amLine(color = "whitesmoke",
#'                                   opacity = 0.4,
#'                                   width = 1)),
#'   yLimits = c(-3, 3),
#'   Yformatter = "#.00",
#'   caption = amText(text = "[font-style:italic]try to drag the yellow line![/]",
#'                    color = "yellow"),
#'   theme = "dark")
#'
#'
#' # line chart with a date x-axis ####
#'
#' library(lubridate)
#'
#' set.seed(666)
#' dat <- data.frame(
#'   date = ymd(180101) + days(0:60),
#'   visits = rpois(61, 20)
#' )
#'
#' amLineChart(
#'   data = dat,
#'   width = "750px",
#'   xValue = "date",
#'   yValues = "visits",
#'   draggable = TRUE,
#'   chartTitle = "Number of visits",
#'   xAxis = list(
#'     title = "Date",
#'     labels = amAxisLabels(
#'       formatter = amDateAxisFormatter(
#'         day = c("dt", "[bold]MMM[/] dt"),
#'         week = c("dt", "[bold]MMM[/] dt")
#'       )
#'     ),
#'     breaks = amAxisBreaks(timeInterval = "7 days")
#'   ),
#'   yAxis = "Visits",
#'   xLimits = range(dat$date) + c(0,7),
#'   yLimits = c(0, 35),
#'   backgroundColor = "whitesmoke",
#'   tooltip = paste0(
#'     "[bold][font-style:italic]{dateX.value.formatDate('yyyy/MM/dd')}[/]",
#'     "\nvisits: {valueY}[/]"
#'   ),
#'   caption = amText(text = "Year 2018"),
#'   theme = "material")
#'
#'
#' # smoothed lines ####
#'
#' x <- seq(-4, 4, length.out = 100)
#' dat <- data.frame(
#'   x = x,
#'   Gauss = dnorm(x),
#'   Cauchy = dcauchy(x)
#' )
#'
#' amLineChart(
#'   data = dat,
#'   width = "700px",
#'   xValue = "x",
#'   yValues = c("Gauss", "Cauchy"),
#'   yValueNames = list(
#'     Gauss = "Standard normal distribution",
#'     Cauchy = "Cauchy distribution"
#'   ),
#'   draggable = FALSE,
#'   tooltip = FALSE,
#'   lineStyle = amLine(
#'     width = 4,
#'     tensionX = 0.8,
#'     tensionY = 0.8
#'   ),
#'   xAxis = list(title = amText(text = "x",
#'                              fontSize = 21,
#'                              color = "navyblue"),
#'                labels = amAxisLabels(
#'                  color = "midnightblue",
#'                  fontSize = 17)),
#'   yAxis = list(title = amText(text = "density",
#'                               fontSize = 21,
#'                               color = "navyblue"),
#'                labels = FALSE),
#'   theme = "dataviz")
amLineChart <- function(
  data,
  data2 = NULL,
  xValue,
  yValues,
  yValueNames = NULL, # default
  hline = NULL,
  vline = NULL,
  xLimits = NULL,
  yLimits = NULL,
  expandX = 0,
  expandY = 5,
  Xformatter = ifelse(isDate, "yyyy-MM-dd", "#."),
  Yformatter = "#.",
  trend = FALSE,
  chartTitle = NULL,
  theme = NULL,
  draggable = FALSE,
  tooltip = NULL, # default
  bullets = NULL, # default
  alwaysShowBullets = FALSE,
  lineStyle = NULL, # default
  backgroundColor = NULL,
  xAxis = NULL, # default
  yAxis = NULL, # default
  scrollbarX = FALSE,
  scrollbarY = FALSE,
  legend = NULL, # default
  caption = NULL,
  image = NULL,
  button = NULL, # default
  cursor = FALSE,
  width = NULL,
  height = NULL,
  export = FALSE,
  chartId = NULL,
  elementId = NULL
) {

  if(!xValue %in% names(data)){
    stop("Invalid `xValue` argument.", call. = TRUE)
  }
  if(!all(yValues %in% names(data))){
    stop("Invalid `yValues` argument.", call. = TRUE)
  }

  data_x <- data[[xValue]]
  if(lubridate::is.Date(data_x) || lubridate::is.POSIXt(data_x)){
    if(is.null(xLimits))
      xLimits <- format(range(pretty(data_x)), "%Y-%m-%d")
    else
      xLimits <- format(xLimits, "%Y-%m-%d")
    data[[xValue]] <- format(data_x, "%Y-%m-%d")
    isDate <- TRUE
  }else{
    isDate <- FALSE
  }

  if(is.null(xLimits)){
    xLimits <- range(pretty(data[[xValue]]))
    pad <- diff(xLimits) * expandX/100
    xLimits <- xLimits + c(-pad, pad)
  }
  allY <- do.call(c, data[yValues])

  if(is.null(yValueNames)){
    yValueNames <- setNames(as.list(yValues), yValues)
  }else if(is.list(yValueNames) || is.character(yValueNames)){
    if(is.null(names(yValueNames)) && length(yValueNames) == length(yValues)){
      warning(sprintf(
        "The `yValueNames` %s you provided is unnamed - setting automatic names",
        ifelse(is.list(yValueNames), "list", "vector")
      ))
      yValueNames <- setNames(as.list(yValueNames), yValues)
    }else if(!all(yValues %in% names(yValueNames))){
      stop(
        paste0(
          "Invalid `yValueNames` argument. ",
          "It must be a named list associating a name to every column ",
          "given in the `yValues` argument."
        ),
        call. = TRUE
      )
    }
  }else{
    stop(
      paste0(
        "Invalid `yValueNames` argument. ",
        "It must be a named list associating a name to every column ",
        "given in the `yValues` argument."
      ),
      call. = TRUE
    )
  }

  if(!is.null(data2) &&
     (!is.data.frame(data2) ||
      nrow(data2) != nrow(data) || # XXXX
      !all(c(xValue,yValues) %in% names(data2)))){
    stop("Invalid `data2` argument.", call. = TRUE)
  }

  if(!isFALSE(trend)){
    if("_all" %in% names(trend)){
      trend <- setNames(rep(list(trend[["_all"]]), length(yValues)), yValues)
    }
    trendData <- setNames(vector("list", length(trend)), names(trend))
    trendJS <- setNames(vector("list", length(trend)), names(trend))
    trendStyle <-
      sapply(trend, "[[", "style", USE.NAMES = TRUE, simplify = FALSE)
    trendIntervals <-
      sapply(trend, "[[", "interval", USE.NAMES = TRUE, simplify = FALSE)
    ribbonStyle <- sapply(sapply(
      trendIntervals,
      function(y)
        Filter(Negate(is.null), y[c("color","opacity","tensionX","tensionY")]),
      USE.NAMES = TRUE, simplify = FALSE
    ), function(y){
      y$color <- validateColor(y$color)
      return(y)
    }, USE.NAMES = TRUE, simplify = FALSE)
    for(yValue in names(trend)){
      if(isDate){
        if(trend[[yValue]][["method"]] != "lm"){
          stop(
            sprintf(
              paste0(
                "Error in trend calculation for \"%s\":  ",
                "method \"%s\" does not handle dates."
              ),
              yValue, trend[[yValue]][["method"]]
            ),
            call. = TRUE
          )
        }else{
        }
      }
      trendJS[[yValue]] <-
        ifelse(
          trend[[yValue]][["method"]] == "lm.js",
          trend[[yValue]][["order"]],
          FALSE
        )
      data_y <- data[[yValue]]
      dat <- data.frame(
        x = data_x[!is.na(data_y)],
        y = na.omit(data_y)
      )
      if(trend[[yValue]][["method"]] %in% c("loess", "nls", "nlsLM")){
        method.args <- if(is.null(trend[[yValue]][["method.args"]]))
          list()
        else
          trend[[yValue]][["method.args"]]
      }else if(trend[[yValue]][["method"]] == "lm.js"){
        trend[[yValue]][["formula"]] <-
          as.formula(
            sprintf(
              "y ~ poly(x, degree = %d, raw = TRUE)",
              trend[[yValue]][["order"]]
            )
          )
      }
      if(trend[[yValue]][["method"]] != "loess"){
        . <-
          tryCatch(
            model.frame(trend[[yValue]][["formula"]], data = dat),
            error = function(e){
              stop(
                sprintf(
                  "%s (in trend calculation for \"%s\").",
                  e$message, yValue
                ),
                call. = TRUE
              )
            }
          )
      }
      fit <- switch(
        trend[[yValue]][["method"]],
        lm = lm(trend[[yValue]][["formula"]], data = dat),
        lm.js = lm(trend[[yValue]][["formula"]], data = dat),
        loess = do.call(
          function(...){ loess(y ~ x, data = dat, ...) },
          method.args
        ),
        nls = do.call(
          function(...){ nls(trend[[yValue]][["formula"]], data = dat, ...) },
          method.args
        ),
        nlsLM = do.call(
          function(...){ nlsLM(trend[[yValue]][["formula"]], data = dat, ...) },
          method.args
        )
      )
      simpleRegression <-
        trend[[yValue]][["method"]] %in% c("lm", "lm.js") &&
        identical(attr(terms(trend[[yValue]][["formula"]]), "term.labels"), "x")
      X <- na.omit(dat$x)
      x <-
        if(simpleRegression)
          range(X)
      else
        unique(seq(min(X), max(X), length.out = 100)) # unique in case of dates
      if(trend[[yValue]][["method"]] %in% c("lm", "lm.js") &&
         "interval" %in% names(trend[[yValue]])){
        interval <- trend[[yValue]][["interval"]]
        itype <- interval[["type"]] %||% "confidence"
        ilevel <- interval[["level"]] %||% 0.95
        if(simpleRegression)
          x <- unique(seq(min(X), max(X), length.out = 100))
        predictions <- predict(
          fit,
          newdata = data.frame(x = x),
          interval = itype,
          level = ilevel,
          se.fit = trend[[yValue]][["method"]] == "lm.js"
        )
        if(trend[[yValue]][["method"]] == "lm"){
          trendData[[yValue]] <- data.frame(
            x = if(isDate) format(x, "%Y-%m-%d") else x,
            y = predictions[,"fit"],
            lwr = predictions[,"lwr"],
            upr = predictions[,"upr"]
          )
          allY <- c(allY, predictions[, c("lwr","upr")])
        }else{ # method lm.js
          seFactor <- predictions[["se.fit"]]/predictions[["residual.scale"]]
          if(itype == "prediction"){
            seFactor <- sqrt(1 + seFactor^2)
          }
          seFactor <- seFactor * qt(ilevel+(1-ilevel)/2, predictions[["df"]])
          trendData[[yValue]] <- data.frame(
            x = x,
            y = predictions[["fit"]][,"fit"],
            lwr = predictions[["fit"]][,"lwr"],
            upr = predictions[["fit"]][,"upr"],
            seFactor = seFactor
          )
          allY <- c(allY, predictions[["fit"]][, c("lwr","upr")])
        }
      }else{
        y <- predict(fit, newdata = data.frame(x = x))
        trendData[[yValue]] <- data.frame(
          x = if(isDate) format(x, "%Y-%m-%d") else x,
          y = y
        )
      }
    }
  }else{
    trendData <- trendStyle <- trendJS <- ribbonStyle <- NULL
  }

  if(is.null(yLimits)){
    yLimits <- range(pretty(allY))
    pad <- diff(yLimits) * expandY/100
    yLimits <- yLimits + c(-pad, pad)
  }

  if(is.character(chartTitle)){
    chartTitle <- list(
      text = amText(
        text = chartTitle, color = NULL, fontSize = 22,
        fontWeight = "bold", fontFamily = "Tahoma"
      ),
      align = "left"
    )
  }else if("text" %in% class(chartTitle)){
    chartTitle <- list(text = chartTitle, align = "left")
  }

  if(is.character(caption)){
    caption <- list(text = amText(caption), align = "right")
  }else if("text" %in% class(caption)){
    caption <- list(text = caption, align = "right")
  }

  if(is.atomic(draggable)){
    if(length(draggable) != 1L || !is.logical(draggable)){
      stop(
        paste0(
          "Invalid `draggable` argument. ",
          "It must be a named list associating `TRUE` or `FALSE` ",
          "for every column given in the `yValues` argument, ",
          "or just `TRUE` or `FALSE`."
        ),
        call. = TRUE
      )
    }
    draggable <- setNames(rep(list(draggable), length(yValues)), yValues)
  }else if(is.list(draggable)){
    if(!all(yValues %in% names(draggable)) ||
       !all(draggable %in% c(FALSE,TRUE))){
      stop(
        paste0(
          "Invalid `draggable` list. ",
          "It must be a named list associating `TRUE` or `FALSE` ",
          "for every column given in the `yValues` argument, ",
          "or just `TRUE` or `FALSE`."
        ),
        call. = TRUE
      )
    }
  }else{
    stop(
      paste0(
        "Invalid `draggable` argument. ",
        "It must be a named list associating `TRUE` or `FALSE` ",
        "for every column given in the `yValues` argument, ",
        "or just `TRUE` or `FALSE`."
      ),
      call. = TRUE
    )
  }

  # if(!isFALSE(tooltip)){
  #   if(is.list(tooltip)){
  #     tooltip$labelColor <- validateColor(tooltip$labelColor)
  #     tooltip$backgroundColor <- validateColor(tooltip$backgroundColor)
  #     tooltip[["auto"]] <- FALSE
  #   }else if(is.null(tooltip)){
  #     tooltip <- list(
  #       text =
  #         ifelse(isDate,
  #                "[bold][font-style:italic]{dateX}:[/] {valueY}[/]",
  #                "[bold]({valueX},{valueY})[/]"
  #         ),
  #       labelColor = "#ffffff",
  #       backgroundColor = "#101010",
  #       backgroundOpacity = 1,
  #       scale = 1,
  #       auto = FALSE
  #     )
  #   }else if(is.character(tooltip)){
  #     tooltip <- list(text = tooltip, auto = TRUE)
  #   }
  # }

  if(!isFALSE(tooltip)){
    tooltipText <- sprintf(ifelse(
      isDate,
      paste0(
        "[bold][font-style:italic]{dateX.value.formatDate('%s')}:[/] ",
        "{valueY.value.formatNumber('%s')}[/]"
      ),
      paste0(
        "[bold]({valueX.value.formatNumber('%s')}, ",
        "{valueY.value.formatNumber('%s')})[/]"
      )
    ), Xformatter, Yformatter)
    if(is.null(tooltip)){
      tooltip <-
        setNames(
          rep(list(amTooltip(text = tooltipText, auto = FALSE)), length(yValues)),
          yValues
        )
    }else if("tooltip" %in% class(tooltip)){
      tooltip <- setNames(rep(list(tooltip), length(yValues)), yValues)
    }else if(is.list(tooltip)){
      if(any(!yValues %in% names(tooltip))){
        stop("Invalid `tooltip` list.", call. = TRUE)
      }
    }else if(is.character(tooltip)){
      tooltip <-
        setNames(
          rep(list(amTooltip(text = tooltip, auto = FALSE)), length(yValues)),
          yValues
        )
    }else{
      stop("Invalid `tooltip` argument.", call. = TRUE)
    }
  }

  if(is.null(bullets)){
    bullets <- setNames(rep(list(amCircle()), length(yValues)), yValues)
  }else if("bullet" %in% class(bullets)){
    bullets <- setNames(rep(list(bullets), length(yValues)), yValues)
  }else if(is.list(bullets)){
    if(any(!yValues %in% names(bullets))){
      stop("Invalid `bullets` list.", call. = TRUE)
    }
  }else{
    stop("Invalid `bullets` argument.", call. = TRUE)
  }

  # if(is.null(lineStyle)){
  #   lineStyle <- list(
  #     width = setNames(rep(list(3), length(yValues)), yValues)
  #   )
  # }else{
  #   if(is.character(lineStyle[["color"]])){
  #     lineStyle[["color"]] <-
  #       setNames(
  #         rep(list(validateColor(lineStyle[["color"]])), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(lineStyle[["color"]])){
  #     if(!all(yValues %in% names(lineStyle[["color"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `color` field of `lineStyle`. ",
  #           "It must be a named list associating a color for every column ",
  #           "given in the `yValues` argument, or just a color that will be ",
  #           "applied to each line."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #     lineStyle[["color"]] <-
  #       sapply(lineStyle[["color"]], validateColor, simplify = FALSE, USE.NAMES = TRUE)
  #   }
  #   if(is.numeric(lineStyle[["width"]])){
  #     lineStyle[["width"]] <-
  #       setNames(
  #         rep(list(lineStyle[["width"]]), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(lineStyle[["width"]])){
  #     if(!all(yValues %in% names(lineStyle[["width"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `width` field of `lineStyle`. ",
  #           "It must be a named list associating a width for every column ",
  #           "given in the `yValues` argument, or just a width that will be ",
  #           "applied to each line."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #   }
  #   if(is.numeric(lineStyle[["tensionX"]])){
  #     stopifnot(lineStyle[["tensionX"]] >= 0 && lineStyle[["tensionX"]] <= 1)
  #     lineStyle[["tensionX"]] <-
  #       setNames(
  #         rep(list(lineStyle[["tensionX"]]), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(lineStyle[["tensionX"]])){
  #     if(!all(yValues %in% names(lineStyle[["tensionX"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `tensionX` field of `lineStyle`. ",
  #           "It must be a named list associating a number to every column ",
  #           "given in the `yValues` argument, or just a number that will be ",
  #           "applied to each line."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #     tensions <- unlist(lineStyle[["tensionX"]])
  #     if(any(tensions < 0 | tensions > 1)){
  #       stop(
  #         paste0(
  #           "Invalid `tensionX` field of `lineStyle`. ",
  #           "The value of `tensionX` must be a number between 0 and 1."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #   }
  #   if(is.numeric(lineStyle[["tensionY"]])){
  #     stopifnot(lineStyle[["tensionY"]] >= 0 && lineStyle[["tensionY"]] <= 1)
  #     lineStyle[["tensionY"]] <-
  #       setNames(
  #         rep(list(lineStyle[["tensionY"]]), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(lineStyle[["tensionY"]])){
  #     if(!all(yValues %in% names(lineStyle[["tensionY"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `tensionY` field of `lineStyle`. ",
  #           "It must be a named list associating a number to every column ",
  #           "given in the `yValues` argument, or just a number that will be ",
  #           "applied to each line."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #     tensions <- unlist(lineStyle[["tensionY"]])
  #     if(any(tensions < 0 | tensions > 1)){
  #       stop(
  #         paste0(
  #           "Invalid `tensionY` field of `lineStyle`. ",
  #           "The value of `tensionY` must be a number between 0 and 1."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #   }
  # }

  if(is.null(lineStyle)){
    lineStyle <-
      setNames(
        rep(list(amLine()), length(yValues)),
        yValues
      )
  }else if("lineStyle" %in% class(lineStyle)){
    lineStyle <- setNames(rep(list(lineStyle), length(yValues)), yValues)
  }else if(is.list(lineStyle)){
    if(any(!yValues %in% names(lineStyle))){
      stop("Invalid `lineStyle` list.", call. = TRUE)
    }
  }else{
    stop("Invalid `lineStyle` argument.", call. = TRUE)
  }

  if(is.null(xAxis)){
    xAxis <- list(
      title = amText(
        text = xValue,
        fontSize = 20,
        color = NULL,
        fontWeight = "bold"
      ),
      labels = amAxisLabels(
        color = NULL,
        fontSize = 18,
        rotation = 0,
        formatter = if(isDate){
          amDateAxisFormatter()
        }else{
          Xformatter
        }
      ),
      gridLines = amLine(opacity = 0.2, width = 1)
    )
  }else if(is.character(xAxis)){
    xAxis <- list(
      title = amText(
        text = xAxis,
        fontSize = 20,
        color = NULL,
        fontWeight = "bold"
      ),
      labels = amAxisLabels(
        color = NULL,
        fontSize = 18,
        rotation = 0,
        formatter = if(isDate){
          amDateAxisFormatter()
        }else{
          Xformatter
        }
      ),
      gridLines = amLine(opacity = 0.2, width = 1)
    )
  }
  if(is.character(xAxis[["title"]])){
    xAxis[["title"]] <- amText(
      text = xAxis[["title"]],
      fontSize = 20,
      color = NULL,
      fontWeight = "bold"
    )
  }
  if(is.null(xAxis[["labels"]])){
    xAxis[["labels"]] <- amAxisLabels(
      color = NULL,
      fontSize = 18,
      rotation = 0,
      formatter = if(isDate){
        amDateAxisFormatter()
      }else{
        Xformatter
      }
    )
  }

  if(is.null(yAxis)){
    yAxis <- list(
      title = if(length(yValues) == 1L) {
        amText(
          text = yValues,
          fontSize = 20,
          color = NULL,
          fontWeight = "bold"
        )
      },
      labels = amAxisLabels(
        color = NULL,
        fontSize = 18,
        rotation = 0,
        formatter = Yformatter
      ),
      gridLines = amLine(opacity = 0.2, width = 1)
    )
  }else if(is.character(yAxis)){
    yAxis <- list(
      title = amText(
        text = yAxis,
        fontSize = 20,
        color = NULL,
        fontWeight = "bold"
      ),
      labels = amAxisLabels(
        color = NULL,
        fontSize = 18,
        rotation = 0,
        formatter = Yformatter
      ),
      gridLines = amLine(opacity = 0.2, width = 1)
    )
  }
  if(is.character(yAxis[["title"]])){
    yAxis[["title"]] <- amText(
      text = yAxis[["title"]],
      fontSize = 20,
      color = NULL,
      fontWeight = "bold"
    )
  }
  if(!isFALSE(yAxis[["labels"]]) && is.null(yAxis[["labels"]])){
    yAxis[["labels"]] <- amAxisLabels(
      color = NULL,
      fontSize = 18,
      rotation = 0,
      formatter = Yformatter
    )
  }

  if(is.null(legend)){
    legend <- length(yValues) > 1L
  }
  if(isTRUE(legend)){
    legend <- amLegend(
      position = "bottom",
      itemsWidth = 30,
      itemsHeight = 20
    )
  }

  if(!(is.null(image) || isFALSE(image))){
    if(!is.list(image)){
      if(!"image" %in% class(image)){
        stop("Invalid `image` argument.", call. = TRUE)
      }else{
        image <- list(image = image)
      }
    }else{
      if(!"image" %in% names(image) || !"image" %in% class(image[["image"]])){
        stop("Invalid `image` argument.", call. = TRUE)
      }
    }
  }

  if(is.null(button)){
    button <- if(!is.null(data2))
      amButton(
        label = "Reset"
      )
  }else if(is.character(button)){
    button <- amButton(
      label = button
    )
  }

  if(is.list(cursor)){
    if("extraTooltipPrecision" %in% names(cursor) &&
       length(cursor[["extraTooltipPrecision"]]) == 1L)
    {
      cursor[["extraTooltipPrecision"]] <- list(
        x = cursor[["extraTooltipPrecision"]][[1L]],
        y = cursor[["extraTooltipPrecision"]][[1L]]
      )
    }
    if("modifier" %in% names(cursor)){
      if(all(!(is.element(c("x","y"), names(cursor[["modifier"]]))))){
        stop(
          "Invalid `modifier` field in the `cursor` argument.", call. = TRUE
        )
      }
      cursor[["renderer"]] <- sapply(cursor[["modifier"]], function(body){
        htmlwidgets::JS(
          "function(text){",
          body,
          "return text;",
          "}"
        )
      }, simplify = FALSE, USE.NAMES = TRUE)
      cursor[["modifier"]] <- NULL
    }
    if(isDate){
      cursor <- append(cursor, list(dateFormat = Xformatter))
    }
  }else if(isTRUE(cursor) && isDate){
    cursor <- list(dateFormat = Xformatter)
  }

  if(is.null(width)){
    width <- "100%"
  }else{
    width <- shiny::validateCssUnit(width)
  }

  height <- shiny::validateCssUnit(height)
  if(is.null(height)){
    if(grepl("^\\d", width) && !grepl("%$", width)){
      height <- sprintf("calc(%s * 9 / 16)", width)
    }else{
      height <- "400px"
    }
  }

  if(is.null(chartId)){
    chartId <- paste0("linechart-", randomString(15))
  }

  if(!is.null(hline)){
    if(any(!is.element(c("value", "line"), names(hline)))){
      stop(
        "Invalid `hline` argument."
      )
    }
  }

  if(!is.null(vline)){
    if(any(!is.element(c("value", "line"), names(vline)))){
      stop(
        "Invalid `vline` argument."
      )
    }
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmLineChart",
    list(
      data = data,
      data2 = data2,
      trendData = trendData,
      trendStyle = trendStyle,
      trendJS = trendJS,
      ribbonStyle = ribbonStyle,
      xValue = xValue,
      isDate = isDate,
      yValues = as.list(yValues),
      yValueNames = as.list(yValueNames),
      minX = xLimits[1L],
      maxX = xLimits[2L],
      minY = yLimits[1L],
      maxY = yLimits[2L],
      hline = hline,
      vline = vline,
      Xformatter = Xformatter,
      Yformatter = Yformatter,
      chartTitle = chartTitle,
      theme = theme,
      draggable = draggable,
      tooltip = tooltip,
      bullets = bullets,
      alwaysShowBullets = alwaysShowBullets,
      lineStyle = lineStyle,
      backgroundColor = validateColor(backgroundColor),
      xAxis = xAxis,
      yAxis = yAxis,
      scrollbarX = scrollbarX,
      scrollbarY = scrollbarY,
      legend = legend,
      caption = caption,
      image = image,
      button = button,
      cursor = cursor,
      width = width,
      height = height,
      export = export,
      chartId = chartId,
      shinyId = elementId
    )
  )
  # create widget
  htmlwidgets::createWidget(
    name = 'amChart4',
    reactR::reactMarkup(component),
    width = "auto",
    height = "auto",
    package = 'rAmCharts4',
    elementId = elementId
  )
}

