#' Create a HTML widget displaying a line chart
#' @description Create a HTML widget displaying a line chart.
#'
#' @param data a dataframe
#' @param data2 \code{NULL} or a dataframe used to update the data with the
#' button; its column names must include the column names of \code{data}
#' given in \code{values} and it must have the same number of rows as
#' \code{data}
#' @param xValue name of the column of \code{data} to be used on the
#' x-axis
#' @param yValues name(s) of the column(s) of \code{data} to be used on the
#' y-axis
#' @param yValueNames names of the variables on the y-axis,
#' to appear in the legend;
#' \code{NULL} to use \code{yValues} as names, otherwise a named list of the
#' form \code{list(yvalue1 = "ValueName1", yvalue2 = "ValueName2", ...)} where
#' \code{yvalue1}, \code{yvalue2}, ... are the column names given in
#' \code{yValues} and \code{"ValueName1"}, \code{"ValueName2"}, ... are the
#' desired names to appear in the legend
#' @param xLimits range of the x-axis, a vector of two values specifying
#' the left and the right limits of the x-axis; \code{NULL} for default values
#' @param yLimits range of the y-axis, a vector of two values specifying
#' the lower and the upper limits of the y-axis; \code{NULL} for default values
#' @param expandX if \code{xLimits = NULL}, a percentage of the range of the
#'   x-axis used to expand this range
#' @param expandY if \code{yLimits = NULL}, a percentage of the range of the
#'   y-axis used to expand this range
#' @param valueFormatter a number formatter for XXXX; see
#' \url{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}
#' @param trend option to request trend lines and to set their settings;
#'   \code{FALSE} for no trend line, otherwise a named list of the form
#'   \code{list(yvalue1 = trend1, yvalue2 = trend2, ...)} where
#'   \code{trend1}, \code{trend2}, ... are lists with the following fields:
#'   \describe{
#'     \item{\code{method}}{
#'       the modelling method, can be \code{"lm"}, \code{"lm.js"}, \code{nls},
#'       \code{nlsLM}, or \code{"loess"}; \code{"lm.js"} performs a polynomial
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
#' @param chartTitle chart title, \code{NULL}, character, or list of settings
#' @param theme theme, \code{NULL} or one of \code{"dataviz"},
#' \code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
#' \code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
#' \code{"microchart"}
#' @param draggable \code{TRUE}/\code{FALSE} to enable/disable dragging of
#' all lines, otherwise a named list of the form
#' \code{list(yvalue1 = TRUE, yvalue2 = FALSE, ...)} to enable/disable the
#' dragging for each bar corresponding to a column given in \code{yValues}
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
#' @param backgroundColor a color for the chart background
#' @param xAxis settings of the x-axis given as a list, or just a string
#' for the axis title
#' @param yAxis settings of the y-axis given as a list, or just a string
#' for the axis title
#' @param scrollbarX logical, whether to add a scrollbar for the category axis
#' @param scrollbarY logical, whether to add a scrollbar for the value axis
#' @param gridLines settings of the grid lines
#' @param legend logical, whether to display the legend
#' @param caption settings of the caption, or \code{NULL} for no caption
#' @param button \code{NULL} for the default, \code{FALSE} for no button,
#' a single character string giving the button label,
#' or settings of the button given as
#' a list with these fields: \code{text} for the button label, \code{color} for
#' the label color, \code{fill} for the button color, and \code{position}
#' for the button position as a percentage (\code{0} for bottom,
#' \code{1} for top); this button is used to replace the current data
#' with \code{data2}
#' @param width the width of the chart, e.g. \code{"600px"} or \code{"80\%"};
#' ignored if the chart is displayed in Shiny, in which case the width is
#' given in \code{\link{amChart4Output}}
#' @param height the height of the chart, e.g. \code{"400px"};
#' ignored if the chart is displayed in Shiny, in which case the width is
#' given in \code{\link{amChart4Output}}
#' @param chartId a HTML id for the chart
#' @param elementId a HTML id for the container of the chart; ignored if the
#' chart is displayed in Shiny, in which case the id is given by the Shiny id
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#' color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
#' \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#' like \code{"hsl(360,11,255)"}.
#'
#' @import htmlwidgets minpack.lm
#' @importFrom shiny validateCssUnit
#' @importFrom stringi stri_rand_strings
#' @importFrom lubridate is.Date is.POSIXt
#' @export
#'
#' @examples # a line chart with numeric x-axis ####
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
#'   lineStyle = list(
#'     y1 = amLine(color = "yellow", width = 4),
#'     y2 = amLine(color = "orangered", width = 4)
#'   ),
#'   chartTitle = list(text = "Gaussian samples", color = "whitesmoke"),
#'   xAxis = list(title = list(text = "Observation",
#'                             fontSize = 21,
#'                             color = "silver"),
#'                labels = list(color = "whitesmoke",
#'                              fontSize = 17)),
#'   yAxis = list(title = list(text = "Value",
#'                             fontSize = 21,
#'                             color = "silver"),
#'                labels = list(color = "whitesmoke",
#'                              fontSize = 14)),
#'   yLimits = c(-3, 3),
#'   valueFormatter = "#.##",
#'   caption = list(text = "[font-style:italic]try to drag the yellow line![/]",
#'                  color = "yellow"),
#'   gridLines = list(color = "whitesmoke",
#'                    opacity = 0.4,
#'                    width = 1),
#'   theme = "dark")
#'
#'
#' # line chart with date x-axis ####
#'
#' library(lubridate)
#'
#' set.seed(666)
#' dat <- data.frame(
#'   date = ymd(180101) + months(0:11),
#'   visits = rpois(12, 20)
#' )
#'
#' amLineChart(
#'   data = dat,
#'   width = "700px",
#'   xValue = "date",
#'   yValues = "visits",
#'   draggable = TRUE,
#'   chartTitle = "Number of visits",
#'   xAxis = "Date",
#'   yAxis = "Visits",
#'   yLimits = c(0, 35),
#'   backgroundColor = "whitesmoke",
#'   tooltip = "[bold][font-style:italic]{dateX}[/]\nvisits: {valueY}[/]",
#'   valueFormatter = "#",
#'   caption = list(text = "Year 2018"),
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
#'   xAxis = list(title = list(text = "x",
#'                             fontSize = 21,
#'                             color = "navyblue"),
#'                labels = list(color = "midnightblue",
#'                              fontSize = 17)),
#'   yAxis = list(title = list(text = "density",
#'                             fontSize = 21,
#'                             color = "navyblue"),
#'                labels = FALSE),
#'   theme = "dataviz")
amRangeAreaChart <- function(
  data,
  xValue,
  yValues,
  yValueNames = NULL, # default
  xLimits = NULL,
  yLimits = NULL,
  expandX = 0,
  expandY = 5,
  valueFormatter = "#.",
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
  gridLines = NULL,
  legend = NULL, # default
  caption = NULL,
  width = NULL,
  height = NULL,
  chartId = NULL,
  elementId = NULL
) {

  if(!xValue %in% names(data)){
    stop("Invalid `xValue` argument.", call. = TRUE)
  }
  if(!all(yValues %in% names(data))){
    stop("Invalid `yValues` argument.", call. = TRUE)
  }

  if(lubridate::is.Date(data[[xValue]]) || lubridate::is.POSIXt(data[[xValue]])){
    if(is.null(xLimits))
      xLimits <- format(range(pretty(data[[xValue]])), "%Y-%m-%d")
    data[[xValue]] <- format(data[[xValue]], "%Y-%m-%d")
    isDate <- TRUE
  }else{
    isDate <- FALSE
  }

  if(is.null(xLimits)){
    xLimits <- range(pretty(data[[xValue]]))
    pad <- diff(xLimits) * expandX/100
    xLimits <- xLimits + c(-pad, pad)
  }

  if(is.null(yLimits)){
    yLimits <- range(pretty(do.call(c, data[c(yValues)])))
    pad <- diff(yLimits) * expandY/100
    yLimits <- yLimits + c(-pad, pad)
  }

  if(is.null(yValueNames)){
    yValueNames <- setNames(as.list(yValues), yValues)
  }else if(is.list(yValueNames)){
    if(!all(yValues %in% names(yValueNames))){
      stop(
        paste0(
          "Invalid `yValueNames` list. ",
          "It must be a named list giving a name for every column ",
          "given in the `yValues` argument."
        ),
        call. = TRUE
      )
    }
  }else{
    stop(
      paste0(
        "Invalid `yValueNames` argument. ",
        "It must be a named list giving a name for every column ",
        "given in the `yValues` argument."
      ),
      call. = TRUE
    )
  }

  # if(!is.null(data2) &&
  #    (!is.data.frame(data2) ||
  #     nrow(data2) != nrow(data) || # XXXX
  #     !all(c(xValue,yValues) %in% names(data2)))){
  #   stop("Invalid `data2` argument.", call. = TRUE)
  # }

  if(is.character(chartTitle)){
    chartTitle <- list(text = chartTitle, fontSize = 22, color = NULL)
  }
  if(!is.null(chartTitle$color)){
    chartTitle$color <- validateColor(chartTitle$color)
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

  if(!isFALSE(tooltip)){
    if(is.null(tooltip)){
      text <- ifelse(isDate,
                     "[bold][font-style:italic]{dateX}:[/] {valueY}[/]",
                     "[bold]({valueX},{valueY})[/]"
      )
      tooltip <-
        setNames(
          rep(list(amTooltip(text = text, auto = FALSE)), length(yValues)),
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

  if(is.list(xAxis)){
    if(is.list(xAxis[["title"]])){
      xAxis[["title"]][["color"]] <- validateColor(xAxis[["title"]][["color"]])
    }
    xAxis[["labels"]][["color"]] <- validateColor(xAxis[["labels"]][["color"]])
  }
  if(is.null(xAxis)){
    xAxis <- list(
      title = list(
        text = xValue,
        fontSize = 20,
        color = NULL
      ),
      labels = list(
        color = NULL,
        fontSize = 18,
        rotation = 0
      )
    )
  }else if(is.character(xAxis)){
    xAxis <- list(title = list(text = xAxis))
  }else if(is.character(xAxis[["title"]])){
    xAxis[["title"]] <- list(text = xAxis[["title"]])
  }

  if(is.null(xAxis[["labels"]])){
    xAxis[["labels"]] <- list(
      color = NULL,
      fontSize = 18,
      rotation = 0
    )
  }

  if(is.list(yAxis)){
    if(is.list(yAxis[["title"]])){
      yAxis[["title"]][["color"]] <- validateColor(yAxis[["title"]][["color"]])
    }
    if(!isFALSE(yAxis[["labels"]])){
      yAxis[["labels"]][["color"]] <- validateColor(yAxis[["labels"]][["color"]])
    }
  }
  if(is.null(yAxis)){
    yAxis <- list(
      title = if(length(yValues) == 1L) {
        list(
          text = yValues,
          fontSize = 20,
          color = NULL
        )
      },
      labels = list(
        color = NULL,
        fontSize = 18,
        rotation = 0
      )
    )
  }else if(is.character(yAxis)){
    yAxis <- list(title = list(text = yAxis))
  }else if(is.character(yAxis[["title"]])){
    yAxis[["title"]] <- list(text = yAxis[["title"]])
  }

  if(!isFALSE(yAxis[["labels"]]) && is.null(yAxis[["labels"]])){
    yAxis[["labels"]] <- list(
      color = NULL,
      fontSize = 18,
      rotation = 0
    )
  }

  if(is.null(gridLines)){
    gridLines <- list(
      color = NULL,
      opacity = NULL,
      width = NULL
    )
  }else{
    gridLines[["color"]] <- validateColor(gridLines[["color"]])
  }

  if(is.null(legend)){
    legend <- length(yValues) > 1L
  }

  if(is.character(caption)){
    caption <- list(text = caption)
  }else if(!is.null(caption)){
    caption[["color"]] <- validateColor(caption[["color"]])
  }

  # if(is.null(button)){
  #   button <- if(!is.null(data2))
  #     list(
  #       text = "Reset",
  #       color = NULL,
  #       fill = NULL,
  #       position = 0.8
  #     )
  # }else if(is.character(button)){
  #   button <- list(
  #     text = button,
  #     color = NULL,
  #     fill = NULL,
  #     position = 0.8
  #   )
  # }else if(is.list(button)){
  #   button[["color"]] <- validateColor(button[["color"]])
  #   button[["fill"]] <- validateColor(button[["fill"]])
  # }

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
    chartId <- paste0("rangeareachart-", stringi::stri_rand_strings(1, 15))
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmRangeAreaChart",
    list(
      data = data,
      xValue = xValue,
      isDate = isDate,
      yValues = apply(yValues, 1L, as.list),
      yValueNames = yValueNames,
      minX = xLimits[1L], # l'ai-je mis dans le jsx ?
      maxX = xLimits[2L],
      minY = yLimits[1L],
      maxY = yLimits[2L],
      valueFormatter = valueFormatter,
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
      gridLines = gridLines,
      legend = legend,
      caption = caption,
      width = width,
      height = height,
      chartId = chartId,
      shinyId = elementId
    )
  )
  # create widget
  htmlwidgets::prependContent(
    htmlwidgets::createWidget(
      name = 'amChart4',
      reactR::reactMarkup(component),
      width = "auto",
      height = "auto",
      package = 'rAmCharts4',
      elementId = elementId
    ),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools()
  )
}

