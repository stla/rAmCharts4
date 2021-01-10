#' HTML widget displaying a boxplot chart
#' @description Create a HTML widget displaying a boxplot chart.
#'
#' @param data a dataframe
#' @param category name of the column of \code{data} to be used for the
#'   category axis; this can be a date column
#' @param value name of the column of \code{data} to be used for the
#'   value axis
#' @param color the color of the boxplots; it can be given by the name of a R
#'   color, the name of a CSS color, e.g. \code{"crimson"} or \code{"fuchsia"},
#'   a HEX code like \code{"#FF009A"}, a RGB code like
#'   \code{"rgb(255,100,39)"}, or a HSL code like \code{"hsl(360,11,255)"}
#' @param hline an optional horizontal line to add to the chart; it must be a
#'   named list of the form \code{list(value = h, line = settings)} where
#'   \code{h} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param yLimits range of the y-axis, a vector of two values specifying
#' the lower and the upper limits of the y-axis; \code{NULL} for default values
#' @param expandY if \code{yLimits = NULL}, a percentage of the range of the
#'   y-axis used to expand this range
#' @param valueFormatter a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string};
#'   it is used to format the values displayed in the cursor tooltips,
#'   the labels of the y-axis unless you specify
#'   your own formatter in the \code{labels} field of the list passed on to
#'   the \code{yAxis} option, and the values displayed in the tooltips unless
#'   you specify your own tooltip text (see the first example of
#'   \code{\link{amBarChart}} for the way to set
#'   a number formatter in the tooltip text)
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @param theme theme, \code{NULL} or one of \code{"dataviz"},
#' \code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
#' \code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
#' \code{"microchart"}
#' @param tooltip \code{TRUE} for the default tooltips,
#'   \code{FALSE} for no tooltip, otherwise a string for the text to
#'   display in the tooltip
#' @param bullets settings of the bullets representing the outliers;
#'   \code{NULL} for default, otherwise a list created with
#'   \code{\link{amCircle}}, \code{\link{amTriangle}} or
#'   \code{\link{amRectangle}}
#' @param backgroundColor a color for the chart background; it can be
#'   given by the name of a R color, the name of a CSS color, e.g.
#'   \code{"lime"} or \code{"olive"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @param xAxis settings of the category axis given as a list, or just a string
#'   for the axis title; the list of settings has four possible fields:
#'   a field \code{title}, a list of settings for the axis title created
#'   with \code{\link{amText}},
#'   a field \code{labels}, a list of settings for the axis labels created
#'   with \code{\link{amAxisLabels}},
#'   a field \code{adjust}, a number defining the vertical adjustment of
#'   the axis (in pixels), and
#'   a field \code{gridLines}, a list of settings for
#'   the grid lines created with \code{\link{amLine}}
#' @param yAxis settings of the value axis given as a list, or just a string
#'   for the axis title; the list of settings has five possible fields:
#'   a field \code{title}, a list of settings for the axis title created
#'   with \code{\link{amText}},
#'   a field \code{labels}, a list of settings for the axis labels created
#'   with \code{\link{amAxisLabels}},
#'   a field \code{adjust}, a number defining the horizontal adjustment of
#'   the axis (in pixels),
#'   a field \code{gridLines}, a list of settings for
#'   the grid lines created with \code{\link{amLine}} and
#'   a field \code{breaks} to control the axis breaks, an R object created with
#'   \code{\link{amAxisBreaks}}
#' @param scrollbarX logical, whether to add a scrollbar for the category axis
#' @param scrollbarY logical, whether to add a scrollbar for the value axis
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
#' @param cursor option to add a cursor on the chart; \code{FALSE} for no
#'   cursor, \code{TRUE} for a cursor with default settings for the tooltips,
#'   or a list of settings created with \code{\link{amTooltip}} to
#'   set the style of the tooltips, or a list with three possible fields:
#'   a field \code{tooltip}, a list of tooltip settings created with
#'   \code{\link{amTooltip}}, a field
#'   \code{extraTooltipPrecision}, an integer, the number of additional
#'   decimals to display in the tooltips, and a field \code{modifier},
#'   which defines a modifier for the
#'   values displayed in the tooltips; a modifier is some JavaScript code
#'   given as a string, which performs a modification of a string named
#'   \code{text}, e.g. \code{modifier = "text = '>>>' + text;"}
#' @param width the width of the chart, e.g. \code{"600px"} or \code{"80\%"};
#' ignored if the chart is displayed in Shiny, in which case the width is
#' given in \code{\link{amChart4Output}}
#' @param height the height of the chart, e.g. \code{"400px"};
#' ignored if the chart is displayed in Shiny, in which case the height is
#' given in \code{\link{amChart4Output}}
#' @param export logical, whether to enable the export menu
#' @param chartId a HTML id for the chart
#' @param elementId a HTML id for the container of the chart; ignored if the
#' chart is displayed in Shiny, in which case the id is given by the Shiny id
#'
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#' @importFrom reactR component reactMarkup
#' @importFrom lubridate is.Date is.POSIXt
#' @export
#'
#' @examples library(rAmCharts4)
#' set.seed(666)
#' dat <- data.frame(
#'   group = gl(4, 50, labels = c("A", "B", "C", "D")),
#'   y     = rt(200, df = 3)
#' )
#' amBoxplotChart(
#'   dat,
#'   category = "group",
#'   value = "y",
#'   color = "maroon",
#'   valueFormatter = "#.#",
#'   theme = "moonrisekingdom"
#' )
amBoxplotChart <- function(
  data,
  category,
  value,
  color = NULL,
  hline = NULL,
  yLimits = NULL,
  expandY = 5,
  valueFormatter = "#.",
  chartTitle = NULL,
  theme = NULL,
  tooltip = TRUE, # default
  bullets = NULL, # default
  backgroundColor = NULL,
  xAxis = NULL, # default
  yAxis = NULL, # default
  scrollbarX = FALSE,
  scrollbarY = FALSE,
  caption = NULL,
  image = NULL,
  cursor = FALSE,
  width = NULL,
  height = NULL,
  export = FALSE,
  chartId = NULL,
  elementId = NULL
) {

  if(!category %in% names(data)){
    stop("Invalid `category` argument: not found in `data`.", call. = TRUE)
  }

  if(!value %in% names(data)){
    stop("Invalid `value` argument: not found in `data`.", call. = TRUE)
  }

  data_x <- data[[category]]
  if(lubridate::is.Date(data_x) || lubridate::is.POSIXt(data_x)){
    xLimits <- format(c(min(data_x), max(data_x)+1), "%Y-%m-%d")
    data[[category]] <- format(data_x, "%Y-%m-%d")
    isDate <- TRUE
  }else{
    isDate <- FALSE
  }

  if(is.null(yLimits)){
    yLimits <- range(pretty(data[[value]]))
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

  if(!isFALSE(tooltip)){
    tooltipText <- sprintf(
      paste0(
        c(
          "High whisker: {highValueY.value.formatNumber('%s')}",
          "High hinge: {valueY.value.formatNumber('%s')}",
          "Median: {median.formatNumber('%s')}",
          "Low hinge: {openValueY.value.formatNumber('%s')}",
          "Low whisker: {lowValueY.value.formatNumber('%s')}"
        ),
        collapse = "\n"
      ),
      valueFormatter,
      valueFormatter,
      valueFormatter,
      valueFormatter,
      valueFormatter
    )
    if(isTRUE(tooltip)){
      tooltip <- amTooltip(
        text = tooltipText,
        auto = TRUE
      )
    }else if("tooltip" %in% class(tooltip)){
      if(tooltip[["text"]] == "_missing") tooltip[["text"]] <- tooltipText
    }else if(is.character(tooltip)){
      tooltip <- amTooltip(text = tooltip, auto = TRUE)
    }else{
      stop("Invalid `tooltip` argument.", call. = TRUE)
    }
  }

  if(is.null(bullets)){
    bullets <- if(is.null(color)) amCircle(radius = 4)
    else amCircle(color = color, radius = 4)
  }else if(!("bullet" %in% class(bullets))){
    stop("Invalid `bullets` argument.", call. = TRUE)
  }

  if(is.null(xAxis)){
    xAxis <- list(
      title = amText(
        text = category,
        fontSize = 20,
        color = NULL,
        fontWeight = "bold"
      ),
      labels = amAxisLabels(
        color = NULL,
        fontSize = 18,
        rotation = 0,
        formatter = if(isDate) amDateAxisFormatter()
      )
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
        formatter = if(isDate) amDateAxisFormatter()
      )
    )
  }else if(is.character(xAxis[["title"]])){
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
      formatter = if(isDate) amDateAxisFormatter()
    )
  }

  if(is.null(yAxis)){
    yAxis <- list(
      title = amText(
        text = value,
        fontSize = 20,
        color = NULL,
        fontWeight = "bold"
      ),
      labels = amAxisLabels(
        color = NULL,
        fontSize = 18,
        rotation = 0,
        formatter = valueFormatter
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
        formatter = valueFormatter
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
  if(is.null(yAxis[["labels"]])){
    yAxis[["labels"]] <- amAxisLabels(
      color = NULL,
      fontSize = 18,
      rotation = 0,
      formatter = valueFormatter
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

  if("tooltip" %in% class(cursor)){
    cursor <- list(tooltip = cursor)
  }else if(is.list(cursor)){
    if("modifier" %in% names(cursor)){
      cursor[["renderer"]] <- list(y = htmlwidgets::JS(
        "function(text){",
        cursor[["modifier"]],
        "return text;",
        "}"
      ))
      cursor[["modifier"]] <- NULL
    }
    if("extraTooltipPrecision" %in% names(cursor)){
      cursor[["extraTooltipPrecision"]] <-
        list(y = cursor[["extraTooltipPrecision"]])
    }
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
    chartId <- paste0("boxplotchart-", randomString(15))
  }

  if(!is.null(hline)){
    if(any(!is.element(c("value", "line"), names(hline)))){
      stop(
        "Invalid `hline` argument."
      )
    }
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmBoxplotChart",
    list(
      data = boxplotsData(data, category, value),
      category = category,
      isDate = isDate,
      minDate = if(isDate) xLimits[1L],
      maxDate = if(isDate) xLimits[2L],
      minValue = yLimits[1L],
      maxValue = yLimits[2L],
      color = validateColor(color),
      hline = hline,
      valueFormatter = valueFormatter,
      chartTitle = chartTitle,
      theme = theme,
      tooltip = tooltip,
      bullets = bullets,
      backgroundColor = validateColor(backgroundColor),
      xAxis = xAxis,
      yAxis = yAxis,
      scrollbarX = scrollbarX,
      scrollbarY = scrollbarY,
      caption = caption,
      image = image,
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

