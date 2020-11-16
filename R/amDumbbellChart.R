#' HTML widget displaying a Dumbbell chart
#' @description Create a HTML widget displaying a Dumbbell chart.
#'
#' @param data a dataframe
#' @param data2 \code{NULL} or a dataframe used to update the data with the
#'   button; its column names must include the column names of \code{data}
#'   given in \code{values}, it must have the same number of rows as
#'   \code{data} and its rows must be in the same order as those of \code{data}
#' @param category name of the column of \code{data} to be used for the
#'   category axis
#' @param values a character matrix with two columns; each row corresponds to
#'   a series and provides the names of two columns of \code{data} to be
#'   used as the limits of the segments
#' @param seriesNames a character vector providing the names of the series
#'   to appear in the legend; its length must equal the number of rows of the
#'   \code{values} matrix: the n-th component corresponds to the n-th row of
#'   the \code{values} matrix
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
#' @param draggable \code{TRUE}/\code{FALSE} to enable/disable dragging of
#'   all bullets, otherwise a named list of the form
#'   \code{list(value1 = TRUE, value2 = FALSE, ...)}
#' @param tooltip settings of the tooltips; \code{NULL} for default,
#'   \code{FALSE} for no tooltip, otherwise a named list of the form
#'   \code{list(value1 = settings1, value2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amTooltip}}; this can also be a
#'   single list of settings that will be applied to each series,
#'   or a just a string for the text to display in the tooltip
#' @param segmentsStyle settings of the segments; \code{NULL} for default,
#'   otherwise a named list of the form
#'   \code{list(series1 = settings1, series2 = settings2, ...)} where
#'   \code{series1}, \code{series2}, ... are the names of the series
#'   provided in \code{seriesNames} and
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amSegment}}; this can also be a
#'   single list of settings that will be applied to each series
#' @param bullets settings of the bullets; \code{NULL} for default,
#'   otherwise a named list of the form
#'   \code{list(value1 = settings1, value2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amCircle}}, \code{\link{amTriangle}} or
#'   \code{\link{amRectangle}}; this can also be a
#'   single list of settings that will be applied to each series
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
#' @export
#'
#' @examples dat <- data.frame(
#'   x = c("T0", "T1", "T2"),
#'   y1 = c(7, 15, 10),
#'   y2 = c(20, 25, 23),
#'   z1 = c(5, 10, 5),
#'   z2 = c(25, 20, 15)
#' )
#'
#' amDumbbellChart(
#'   width = "500px",
#'   data = dat,
#'   draggable = TRUE,
#'   category = "x",
#'   values = rbind(c("y1","y2"), c("z1","z2")),
#'   seriesNames = c("Control", "Treatment"),
#'   yLimits = c(0, 30),
#'   segmentsStyle = list(
#'     "Control" = amSegment(width = 2),
#'     "Treatment" = amSegment(width = 2)
#'   ),
#'   bullets = list(
#'     y1 = amTriangle(strokeWidth = 0),
#'     y2 = amTriangle(rotation = 180, strokeWidth = 0),
#'     z1 = amTriangle(strokeWidth = 0),
#'     z2 = amTriangle(rotation = 180, strokeWidth = 0)
#'   ),
#'   tooltip = amTooltip("upper: {openValueY}\nlower: {valueY}", scale = 0.75),
#'   xAxis = list(
#'     title = amText(
#'       "timepoint",
#'       fontSize = 17, fontWeight = "bold", fontFamily = "Helvetica"
#'     )
#'   ),
#'   yAxis = list(
#'     title = amText(
#'       "response",
#'       fontSize = 17, fontWeight = "bold", fontFamily = "Helvetica"
#'     ),
#'     gridLines = amLine("silver", width = 1, opacity = 0.4)
#'   ),
#'   legend = amLegend(position = "right", itemsWidth = 15, itemsHeight = 15),
#'   backgroundColor = "lightyellow",
#'   theme = "dataviz"
#' )
amDumbbellChart <- function(
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
  draggable = FALSE,
  tooltip = NULL, # default
  segmentsStyle = NULL, # default
  bullets = NULL, # default
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

  if(!category %in% names(data)){
    stop("Invalid `category` argument: not found in `data`.", call. = TRUE)
  }

  if(!is.matrix(values)){
    values <- rbind(values)
  }
  if(ncol(values) != 2L || !all(values %in% names(data))){
    stop("Invalid `values` argument.", call. = TRUE)
  }

  valueNames <- setNames(as.list(values), values)

  if(is.null(seriesNames)){
    seriesNames <- apply(values, 1L, function(row) paste0(row, collapse = "-"))
  }else if(length(seriesNames) != nrow(values)){
    stop("Invalid `seriesNames` argument.", call. = TRUE)
  }

  if(!is.null(data2) &&
     (!is.data.frame(data2) ||
      nrow(data2) != nrow(data) ||
      !all(values %in% names(data2)))){
    stop("Invalid `data2` argument.", call. = TRUE)
  }

  if(is.null(yLimits)){
    yLimits <- range(pretty(do.call(c, data[c(values)])))
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

  if(!isFALSE(tooltip)){
    tooltipText1 <- sprintf(
      "[bold]{openValueY.value.formatNumber('%s')}[/]",
      valueFormatter
    )
    tooltipText2 <- sprintf(
      "[bold]{valueY.value.formatNumber('%s')}[/]",
      valueFormatter
    )
    if(is.null(tooltip)){
      tooltip <- c(
        setNames(
          rep(list(
            amTooltip(
              text = tooltipText1,
              auto = FALSE
            )
          ), nrow(values)),
          values[,1L]
        ),
        setNames(
          rep(list(
            amTooltip(
              text = tooltipText2,
              auto = FALSE
            )
          ), nrow(values)),
          values[,2L]
        )
      )
    }else if("tooltip" %in% class(tooltip)){
      if(tooltip[["text"]] == "_missing")
        tooltip[["text"]] <- paste0(tooltipText1, " - ", tooltipText2)
      tooltip <- setNames(rep(list(tooltip), length(values)), values)
    }else if(is.list(tooltip)){
      if(any(!values %in% names(tooltip))){
        stop("Invalid `tooltip` list.", call. = TRUE)
      }
      tooltip <- lapply(tooltip, function(settings){
        if(settings[["text"]] == "_missing")
          settings[["text"]] <- paste0(tooltipText1, " - ", tooltipText2)
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

  if(is.null(segmentsStyle)){
    segmentsStyle <-
      setNames(rep(list(amSegment()), length(seriesNames)), seriesNames)
  }else if("segment" %in% class(segmentsStyle)){
    segmentsStyle <-
      setNames(rep(list(segmentsStyle), length(seriesNames)), seriesNames)
  }else if(is.list(segmentsStyle)){
    if(any(!seriesNames %in% names(segmentsStyle))){
      stop("Invalid `segmentsStyle` list.", call. = TRUE)
    }
  }else{
    stop("Invalid `segmentsStyle` argument.", call. = TRUE)
  }

  if(is.null(bullets)){
    bullets <-
      setNames(rep(list(amCircle()), length(values)), values)
  }else if("bullet" %in% class(bullets)){
    bullets <- setNames(rep(list(bullets), length(values)), values)
  }else if(is.list(bullets)){
    if(any(!values %in% names(bullets))){
      stop("Invalid `bullets` list.", call. = TRUE)
    }
  }else{
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
      rotation = 0
    )
  }

  if(is.null(yAxis)){
    yAxis <- list(
      title = if(length(seriesNames) == 1L) {
        amText(
          text = seriesNames,
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
    legend <- nrow(values) > 1L
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
    chartId <- paste0("dumbbellchart-", randomString(15))
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
    "AmDumbbellChart",
    list(
      data = data,
      data2 = data2,
      category = category,
      values = apply(values, 1L, as.list),
      valueNames = valueNames,
      seriesNames = as.list(seriesNames),
      minValue = yLimits[1L],
      maxValue = yLimits[2L],
      hline = hline,
      valueFormatter = valueFormatter,
      chartTitle = chartTitle,
      theme = theme,
      draggable = draggable,
      tooltip = tooltip,
      segmentsStyle = segmentsStyle,
      bullets = bullets,
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

