#' HTML widget displaying a 100\% stacked bar chart
#' @description Create a HTML widget displaying a 100\% stacked bar chart.
#'
#' @param data a dataframe
#' @param category name of the column of \code{data} to be used on the
#'   category axis
#' @param values names of the columns of \code{data} to be used on the
#'   value axis
#' @param valueNames names of the values variables, to appear in the legend;
#'   \code{NULL} to use \code{values} as names, otherwise a named list of the
#'   form \code{list(value1 = "ValueName1", value2 = "ValueName2", ...)} where
#'   \code{value1}, \code{value2}, ... are the column names given in
#'   \code{values} and \code{"ValueName1"}, \code{"ValueName2"}, ... are the
#'   desired names to appear in the legend; these names also appear in
#'   the tooltips.
#' @param hline an optional horizontal line to add to the chart; it must be a
#'   named list of the form \code{list(value = h, line = settings)} where
#'   \code{h} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @template themeTemplate
#' @param backgroundColor a color for the chart background; a color can be
#'   given by the name of a R color, the name of a CSS color, e.g.
#'   \code{"rebeccapurple"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @param xAxis settings of the category axis given as a list, or just a string
#'   for the axis title; the list of settings has three possible fields:
#'   a field \code{title}, a list of settings for the axis title created
#'   with \code{\link{amText}},
#'   a field \code{labels}, a list of settings for the axis labels created
#'   with \code{\link{amAxisLabels}},
#'   and a field \code{adjust}, a number defining the vertical adjustment of
#'   the axis (in pixels)
#' @param yAxis settings of the value axis given as a list, or just a string
#'   for the axis title; the list of settings has five possible fields:
#'   a field \code{title}, a list of settings for the axis title created
#'   with \code{\link{amText}},
#'   a field \code{labels}, a list of settings for the axis labels created
#'   with \code{\link{amAxisLabels}},
#'   a field \code{adjust}, a number defining the horizontal adjustment of
#'   the axis (in pixels), a field \code{gridLines}, a list of settings for
#'   the grid lines created with \code{\link{amLine}} and a field
#'   \code{breaks} to control the axis breaks, an R object created with
#'   \code{\link{amAxisBreaks}}
#' @param scrollbarX logical, whether to add a scrollbar for the category axis
#' @param scrollbarY logical, whether to add a scrollbar for the value axis
#' @param legend either a logical value, whether to display the legend, or
#'   a list of settings for the legend created with \code{\link{amLegend}}
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
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#' @importFrom reactR component reactMarkup
#' @importFrom stats setNames
#' @export
#' @examples library(rAmCharts4)
#'
#' dat <- data.frame(
#'   category = c("A", "B", "C"),
#'   v1 = c(1, 2, 3),
#'   v2 = c(9, 5, 7)
#' )
#'
#' amPercentageBarChart(
#'   dat,
#'   category = "category",
#'   values = c("v1", "v2"),
#'   valueNames = c("Value1", "Value2"),
#'   yAxis = "Percentage",
#'   theme = "dataviz",
#'   legend = amLegend(position = "right")
#' )
amPercentageBarChart <- function(
  data,
  category,
  values,
  valueNames = NULL, # default
  hline = NULL,
  chartTitle = NULL,
  theme = NULL,
  animated = TRUE,
  backgroundColor = NULL,
  xAxis = NULL, # default
  yAxis = NULL, # default
  scrollbarX = FALSE,
  scrollbarY = FALSE,
  legend = TRUE,
  caption = NULL,
  image = NULL,
  width = NULL,
  height = NULL,
  export = FALSE,
  chartId = NULL,
  elementId = NULL
) {

  if(!category %in% names(data)){
    stop("Invalid `category` argument.", call. = TRUE)
  }

  if(!all(values %in% names(data))){
    stop("Invalid `values` argument.", call. = TRUE)
  }

  for(val in values){
    if(!is.numeric(data[[val]])){
      stop(
        sprintf(
          "Column `%s` is not numeric.", val
        ), call. = TRUE
      )
    }
  }

  if(is.null(valueNames)){
    valueNames <- setNames(as.list(values), values)
  }else if(is.list(valueNames) || is.character(valueNames)){
    if(is.null(names(valueNames)) && length(valueNames) == length(values)){
      warning(sprintf(
        "The `valueNames` %s you provided is unnamed - setting automatic names",
        ifelse(is.list(valueNames), "list", "vector")
      ))
      valueNames <- setNames(as.list(valueNames), values)
    }else if(!all(values %in% names(valueNames))){
      stop(
        paste0(
          "Invalid `valueNames` argument. ",
          "It must be a named list associating a name to every column ",
          "given in the `values` argument."
        ),
        call. = TRUE
      )
    }
  }else{
    stop(
      paste0(
        "Invalid `valueNames` argument. ",
        "It must be a named list giving a name for every column ",
        "given in the `values` argument."
      ),
      call. = TRUE
    )
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
        rotation = 0
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
        rotation = 0
      )
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
      rotation = 0
    )
  }

  valueFormatter <- "#"
  if(is.null(yAxis)){
    yAxis <- list(
      title = NULL,
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

  if(isTRUE(legend)){
    legend <- amLegend(
      position = "bottom",
      itemsWidth = 20,
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
    chartId <- paste0("barpercentagechart-", randomString(15))
  }

  if(!is.null(hline)){
    if(any(!is.element(c("value", "line"), names(hline)))){
      stop(
        "Invalid `hline` argument.", call. = TRUE
      )
    }
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmPercentageBarChart",
    list(
      data = data,
      category = category,
      values = as.list(values),
      valueNames = as.list(valueNames),
      hline = hline,
      chartTitle = chartTitle,
      theme = theme,
      animated = animated,
      backgroundColor = validateColor(backgroundColor),
      xAxis = xAxis,
      yAxis = yAxis,
      scrollbarX = scrollbarX,
      scrollbarY = scrollbarY,
      legend = legend,
      caption = caption,
      image = image,
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
