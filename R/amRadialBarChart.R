#' HTML widget displaying a radial bar chart
#' @description Create a HTML widget displaying a radial bar chart.
#'
#' @param data a dataframe
#' @param data2 \code{NULL} or a dataframe used to update the data with the
#'   button; its column names must include the column names of \code{data}
#'   given in \code{values}, it must have the same number of rows as
#'   \code{data} and its rows must be in the same order as those of \code{data}
#' @param category name of the column of \code{data} to be used on the
#'   category axis
#' @param values name(s) of the column(s) of \code{data} to be used on the
#'   value axis
#' @param valueNames names of the values variables, to appear in the legend;
#'   \code{NULL} to use \code{values} as names, otherwise a named list of the
#'   form \code{list(value1 = "ValueName1", value2 = "ValueName2", ...)} where
#'   \code{value1}, \code{value2}, ... are the column names given in
#'   \code{values} and \code{"ValueName1"}, \code{"ValueName2"}, ... are the
#'   desired names to appear in the legend; these names can also appear in
#'   the tooltips: they are substituted to the string \code{{name}} in
#'   the formatting string passed on to the tooltip (see the second example of
#'   \code{\link{amBarChart}})
#' @param showValues logical, whether to display the values on the chart
#' @param innerRadius inner radius of the chart, a percentage (between 0 and
#'   100 theoretically, but in practice it should be between 30 and 70)
#' @param yLimits range of the y-axis, a vector of two values specifying
#' the lower and the upper limits of the y-axis; \code{NULL} for default values
#' @param expandY if \code{yLimits = NULL}, a percentage of the range of the
#'   y-axis used to expand this range
#' @param valueFormatter a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string};
#'   it is used to format the values displayed on the chart if
#'   \code{showValues = TRUE}, the values displayed in the cursor tooltips if
#'   \code{cursor = TRUE}, the labels of the y-axis unless you specify
#'   your own formatter in the \code{labels} field of the list passed on to
#'   the \code{yAxis} option, and the values displayed in the tooltips unless
#'   you specify your own tooltip text (see the first example for the way to set
#'   a number formatter in the tooltip text)
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @template themeTemplate
#' @param draggable \code{TRUE}/\code{FALSE} to enable/disable dragging of
#' all bars, otherwise a named list of the form
#' \code{list(value1 = TRUE, value2 = FALSE, ...)} to enable/disable the
#' dragging for each bar corresponding to a column given in \code{values}
#' @param tooltip settings of the tooltips; \code{NULL} for default,
#'   \code{FALSE} for no tooltip, otherwise a named list of the form
#'   \code{list(value1 = settings1, value2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amTooltip}}; this can also be a
#'   single list of settings that will be applied to each series,
#'   or a just a string for the text to display in the tooltip
#' @param columnStyle settings of the columns; \code{NULL} for default,
#'   otherwise a named list of the form
#'   \code{list(value1 = settings1, value2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amColumn}}; this can also be a
#'   single list of settings that will be applied to each column
#' @param bullets settings of the bullets; \code{NULL} for default,
#'   otherwise a named list of the form
#'   \code{list(value1 = settings1, value2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amCircle}}, \code{\link{amTriangle}} or
#'   \code{\link{amRectangle}}; this can also be a
#'   single list of settings that will be applied to each series
#' @param alwaysShowBullets logical, whether to always show the bullets;
#'   if \code{FALSE}, the bullets are shown only on hovering a column
#' @param backgroundColor a color for the chart background; a color can be
#'   given by the name of a R color, the name of a CSS color, e.g.
#'   \code{"lime"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @param cellWidth cell width in percent; for a simple bar chart, this is the
#' width of the columns; for a grouped bar chart, this is the width of the
#' clusters of columns; \code{NULL} for the default value
#' @param columnWidth column width, a percentage of the cell width; set to 100
#' for a simple bar chart and use \code{cellWidth} to control the width of the
#' columns; for a grouped bar chart, this controls the spacing between the
#' columns within a cluster of columns; \code{NULL} for the default value
#' @param xAxis settings of the category axis given as a list, or just a string
#'   for the axis title; the list of settings has three possible fields:
#'   a field \code{title}, a list of settings for the axis title created
#'   with \code{\link{amText}},
#'   a field \code{labels}, a list of settings for the axis labels created
#'   with \code{\link{amAxisLabelsCircular}},
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
#' @template buttonTemplate
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
#'   given a string, which performs a modification of a string named
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
#' @export
#'
#' @examples # a grouped radial bar chart ####
#'
#' set.seed(666)
#' dat <- data.frame(
#'   country = c("USA", "China", "Japan", "Germany", "UK", "France"),
#'   visits = c(3025, 1882, 1809, 1322, 1122, 1114),
#'   income = rpois(6, 25),
#'   expenses = rpois(6, 20)
#' )
#'
#' amRadialBarChart(
#'   data = dat, data2 = dat,
#'   width = "600px", height = "600px",
#'   category = "country",
#'   values = c("income", "expenses"),
#'   valueNames = list(income = "Income", expenses = "Expenses"),
#'   showValues = FALSE,
#'   tooltip = amTooltip(
#'     textColor = "white",
#'     backgroundColor = "#101010",
#'     borderColor = "silver"
#'   ),
#'   draggable = TRUE,
#'   backgroundColor = "#30303d",
#'   columnStyle = list(
#'     income = amColumn(
#'       color = "darkmagenta",
#'       strokeColor = "#cccccc",
#'       strokeWidth = 2
#'     ),
#'     expenses = amColumn(
#'       color = "darkred",
#'       strokeColor = "#cccccc",
#'       strokeWidth = 2
#'     )
#'   ),
#'   chartTitle = "Income and expenses per country",
#'   xAxis = list(
#'     labels = amAxisLabelsCircular(
#'       radius = -82, relativeRotation = 90
#'     )
#'   ),
#'   yAxis = list(
#'     labels = amAxisLabels(color = "orange"),
#'     gridLines = amLine(color = "whitesmoke", width = 1, opacity = 0.4),
#'     breaks = amAxisBreaks(values = seq(0, 40, by = 10))
#'   ),
#'   yLimits = c(0, 40),
#'   valueFormatter = "#.#",
#'   caption = amText(
#'     text = "Year 2018",
#'     fontFamily = "Impact",
#'     fontSize = 18
#'   ),
#'   theme = "dark")
#'
#'
#' # just for fun ####
#'
#' dat <- data.frame(
#'   cluster = letters[1:6],
#'   y1 = rep(10, 6),
#'   y2 = rep(8, 6),
#'   y3 = rep(6, 6),
#'   y4 = rep(4, 6),
#'   y5 = rep(2, 6),
#'   y6 = rep(4, 6),
#'   y7 = rep(6, 6),
#'   y8 = rep(8, 6),
#'   y9 = rep(10, 6)
#' )
#'
#' amRadialBarChart(
#'   data = dat,
#'   width = "500px", height = "500px",
#'   innerRadius = 10,
#'   category = "cluster", values = paste0("y", 1:9),
#'   showValues = FALSE,
#'   tooltip = FALSE, draggable = FALSE,
#'   backgroundColor = "black",
#'   columnStyle = amColumn(strokeWidth = 1, strokeColor = "white"),
#'   cellWidth = 96,
#'   xAxis = list(labels = FALSE),
#'   yAxis = list(labels = FALSE, gridLines = FALSE),
#'   yLimits = c(0, 10),
#'   legend = FALSE,
#'   theme = "kelly")
amRadialBarChart <- function(
  data,
  data2 = NULL,
  category,
  values,
  valueNames = NULL, # default
  showValues = TRUE,
  innerRadius = 50,
  yLimits = NULL,
  expandY = 5,
  valueFormatter = "#.",
  chartTitle = NULL,
  theme = NULL,
  animated = TRUE,
  draggable = FALSE,
  tooltip = NULL, # default
  columnStyle = NULL, # default
  bullets = NULL, #default
  alwaysShowBullets = FALSE,
  backgroundColor = NULL,
  cellWidth = NULL, # default
  columnWidth = NULL, # default
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

  if(!all(values %in% names(data))){
    stop("Invalid `values` argument.", call. = TRUE)
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

  if(!is.null(data2) &&
     (!is.data.frame(data2) ||
      nrow(data2) != nrow(data) ||
      !all(values %in% names(data2)))){
    stop("Invalid `data2` argument.", call. = TRUE)
  }

  if(is.null(yLimits)){
    yLimits <- range(pretty(do.call(c, data[values])))
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
          "It must be a named list defining `TRUE` or `FALSE` ",
          "for every column given in the `values` argument, ",
          "or just `TRUE` or `FALSE`."
        ),
        call. = TRUE
      )
    }
    draggable <- setNames(rep(list(draggable), length(values)), values)
  }else if(is.list(draggable)){
    if(!all(values %in% names(draggable)) ||
       !all(draggable %in% c(FALSE,TRUE))){
      stop(
        paste0(
          "Invalid `draggable` list. ",
          "It must be a named list defining `TRUE` or `FALSE` ",
          "for every column given in the `values` argument, ",
          "or just `TRUE` or `FALSE`."
        ),
        call. = TRUE
      )
    }
  }else{
    stop(
      paste0(
        "Invalid `draggable` argument. ",
        "It must be a named list defining `TRUE` or `FALSE` ",
        "for every column given in the `values` argument, ",
        "or just `TRUE` or `FALSE`."
      ),
      call. = TRUE
    )
  }

  # if(!isFALSE(tooltip)){
  #   if(is.list(tooltip)){
  #     tooltip$labelColor <- validateColor(tooltip$labelColor)
  #     tooltip$backgroundColor <- validateColor(tooltip$backgroundColor)
  #   }else if(is.null(tooltip)){
  #     tooltip <- list(
  #       text = "[bold]{name}:\n{valueY}[/]",
  #       labelColor = "#ffffff",
  #       backgroundColor = "#101010",
  #       backgroundOpacity = 1,
  #       scale = 1
  #     )
  #   }else if(is.character(tooltip)){
  #     tooltip <- list(text = tooltip)
  #   }
  # }

  if(!isFALSE(tooltip)){
    tooltipText <- sprintf(
      "[bold]{name}:\n{valueY.value.formatNumber('%s')}[/]",
      valueFormatter
    )
    if(is.null(tooltip)){
      tooltip <-
        setNames(
          rep(list(
            amTooltip(
              text = tooltipText,
              auto = FALSE
            )
          ), length(values)),
          values
        )
    }else if("tooltip" %in% class(tooltip)){
      if(tooltip[["text"]] == "_missing")
        tooltip[["text"]] <- tooltipText
      tooltip <- setNames(rep(list(tooltip), length(values)), values)
    }else if(is.list(tooltip)){
      if(any(!values %in% names(tooltip))){
        stop("Invalid `tooltip` list.", call. = TRUE)
      }
      tooltip <- lapply(tooltip, function(settings){
        if(settings[["text"]] == "_missing")
          settings[["text"]] <- tooltipText
        return(settings)
      })
    }else if(is.character(tooltip)){
      tooltip <-
        setNames(
          rep(list(amTooltip(text = tooltip, auto = FALSE)), length(values)),
          values
        )
    }else{
      stop("Invalid `tooltip` argument.", call. = TRUE)
    }
  }

  # if(!is.null(columnStyle[["stroke"]])){
  #   columnStyle[["stroke"]] <- validateColor(columnStyle[["stroke"]])
  # }
  # if(is.null(columnStyle)){
  #   columnStyle <- list(
  #     fill = setNames(rep(list(NULL), length(values)), values),
  #     stroke = NULL,
  #     cornerRadius = NULL
  #   )
  # }else if(is.character(columnStyle[["fill"]])){
  #   columnStyle[["fill"]] <-
  #     setNames(
  #       rep(list(validateColor(columnStyle[["fill"]])), length(values)),
  #       values
  #     )
  # }else if(is.list(columnStyle[["fill"]])){
  #   if(!all(values %in% names(columnStyle[["fill"]]))){
  #     stop(
  #       paste0(
  #         "Invalid `fill` field of `columnStyle`. ",
  #         "It must be a named list defining a color for every column ",
  #         "given in the `values` argument, or just a color that will be ",
  #         "applied to each column."
  #       ),
  #       call. = TRUE
  #     )
  #   }
  #   columnStyle[["fill"]] <-
  #     sapply(columnStyle[["fill"]], validateColor, simplify = FALSE, USE.NAMES = TRUE)
  # }

  if(is.null(columnStyle)){
    columnStyle <- setNames(rep(list(amColumn()), length(values)), values)
  }else if("column" %in% class(columnStyle)){
    columnStyle <- setNames(rep(list(columnStyle), length(values)), values)
  }else if(is.list(columnStyle)){
    if(any(!values %in% names(columnStyle))){
      stop("Invalid `columnStyle` list.", call. = TRUE)
    }
  }else{
    stop("Invalid `columnStyle` argument.", call. = TRUE)
  }

  if(is.null(bullets)){
    bullets <- setNames(rep(list(amCircle()), length(values)), values)
  }else if("bullet" %in% class(bullets)){
    bullets <- setNames(rep(list(bullets), length(values)), values)
  }else if(is.list(bullets)){
    if(any(!values %in% names(bullets))){
      stop("Invalid `bullets` list.", call. = TRUE)
    }
  }else{
    stop("Invalid `bullets` argument.", call. = TRUE)
  }

  if(is.null(cellWidth)){
    cellWidth <- 90
  }else{
    cellWidth <- max(50, min(cellWidth, 100))
  }

  if(is.null(columnWidth)){
    columnWidth <- ifelse(length(values) == 1L, 100, 90)
  }else{
    columnWidth <- max(10, min(columnWidth, 100))
  }

  if(is.null(xAxis)){
    xAxis <- list(
      title = amText(
        text = category,
        fontSize = 20,
        color = NULL,
        fontWeight = "bold"
      ),
      labels = amAxisLabelsCircular(
        color = NULL,
        fontSize = 14
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
      labels = amAxisLabelsCircular(
        color = NULL,
        fontSize = 14
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
    xAxis[["labels"]] <- amAxisLabelsCircular(
      color = NULL,
      fontSize = 14
    )
  }

  if(is.null(yAxis)){
    yAxis <- list(
      title = if(length(values) == 1L) {
        amText(
          text = values,
          fontSize = 20,
          color = NULL,
          fontWeight = "bold"
        )
      },
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

  if(is.null(legend)){
    legend <- length(values) > 1L
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
    chartId <- paste0("radialbarchart-", randomString(15))
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmRadialBarChart",
    list(
      data = data,
      data2 = data2,
      category = category,
      values = as.list(values),
      valueNames = as.list(valueNames),
      showValues = showValues,
      innerRadius = innerRadius,
      minValue = yLimits[1L],
      maxValue = yLimits[2L],
      valueFormatter = valueFormatter,
      chartTitle = chartTitle,
      theme = theme,
      animated = animated,
      draggable = draggable,
      tooltip = tooltip,
      columnStyle = columnStyle,
      bullets = bullets,
      alwaysShowBullets = alwaysShowBullets,
      backgroundColor = validateColor(backgroundColor),
      cellWidth = cellWidth,
      columnWidth = columnWidth,
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

