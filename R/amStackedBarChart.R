#' HTML widget displaying a stacked bar chart
#' @description Create a HTML widget displaying a stacked bar chart.
#'
#' @param data a dataframe
#' @param data2 \code{NULL} or a dataframe used to update the data with the
#'   button; its column names must include the column names of \code{data}
#'   given in \code{series}, it must have the same number of rows as
#'   \code{data} and its rows must be in the same order as those of \code{data}
#' @param category name of the column of \code{data} to be used on the
#'   category axis
#' @param stacks a list of stacks; a stack is a character vector of the form
#'   \code{c("series3", "series1", "series2")}, and the first element of a
#'   stack corresponds to the bottom of the column
#' @param seriesNames names of the series variables (the variables which appear
#'   in the stacks), to appear in the legend; \code{NULL} to use the variables
#'   given in \code{stacks} as names, otherwise a named list of the
#'   form \code{list(series1 = "SeriesName1", series2 = "SeriesName2", ...)}
#'   where \code{series1}, \code{series2}, ... are the column names given in
#'   \code{stacks} and \code{"SeriesName1"}, \code{"SeriesName2"}, ... are the
#'   desired names to appear in the legend; these names can also appear in
#'   the tooltips: they are substituted to the string \code{{name}} in
#'   the formatting string passed on to the tooltip
#' @param colors colors of the bars; \code{NULL} for automatic colors based on
#'   the theme, otherwise a named list of the form
#'   \code{list(series1 = Color1, series2 = Color2, ...)} where \code{series1},
#'   \code{series2}, ... are the column names given in \code{stacks}
#' @param hline an optional horizontal line to add to the chart; it must be a
#'   named list of the form \code{list(value = h, line = settings)} where
#'   \code{h} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param yLimits range of the y-axis, a vector of two values specifying
#'   the lower and the upper limits of the y-axis; \code{NULL} for default
#'   values
#' @param expandY if \code{yLimits = NULL}, a percentage of the range of the
#'   y-axis used to expand this range
#' @param valueFormatter a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string};
#'   it is used to format the values displayed in the cursor tooltips if
#'   \code{cursor = TRUE}, the labels of the y-axis unless you specify
#'   your own formatter in the \code{labels} field of the list passed on to
#'   the \code{yAxis} option, and the values displayed in the tooltips unless
#'   you specify your own tooltip text
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @template themeTemplate
#' @param tooltip settings of the tooltips; \code{NULL} for default,
#'   \code{FALSE} for no tooltip, otherwise a named list of the form
#'   \code{list(series1 = settings1, series2 = settings2, ...)} where
#'   \code{settings1}, \code{settings2}, ... are lists created with
#'   \code{\link{amTooltip}}; this can also be a
#'   single list of settings that will be applied to each series,
#'   or a just a string for the text to display in the tooltip
#' @param threeD logical, whether to render the columns in 3D
#' @param backgroundColor a color for the chart background; a color can be
#'   given by the name of a R color, the name of a CSS color, e.g.
#'   \code{"rebeccapurple"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @param cellWidth cell width in percent; for a simple bar chart, this is the
#'   width of the columns; for a grouped bar chart, this is the width of the
#'   clusters of columns; \code{NULL} for the default value
#' @param columnWidth column width, a percentage of the cell width; set to 100
#'   for a simple bar chart and use \code{cellWidth} to control the width of the
#'   columns; for a grouped bar chart, this controls the spacing between the
#'   columns within a cluster of columns; \code{NULL} for the default value
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
#'
#' @examples library(rAmCharts4)
#'
#' dat <- data.frame(
#'   year     = c("2004", "2005", "2006"),
#'   europe   = c(10, 15, 20),
#'   asia     = c( 9, 10, 13),
#'   africa   = c( 5,  6,  8),
#'   meast    = c( 7,  8, 12),
#'   namerica = c(12, 15, 19),
#'   samerica = c(10, 16, 14)
#' )
#'
#' dat2 <- data.frame(
#'   year     = c("2004", "2005", "2006"),
#'   europe   = c( 7, 12, 16),
#'   asia     = c( 8, 13, 10),
#'   africa   = c( 7,  7, 10),
#'   meast    = c( 8,  6, 14),
#'   namerica = c(10, 17, 17),
#'   samerica = c(12, 18, 17)
#' )
#'
#' stacks <- list(
#'   c("europe", "namerica"),
#'   c("asia", "africa", "meast", "samerica")
#' )
#'
#' seriesNames <- list(
#'   europe = "Europe",
#'   namerica = "North America",
#'   asia = "Asia",
#'   africa = "Africa",
#'   meast = "Middle East",
#'   samerica = "South America"
#' )
#'
#' amStackedBarChart(
#'   dat,
#'   data2 = dat2,
#'   category = "year",
#'   stacks = stacks,
#'   seriesNames = seriesNames,
#'   yLimits = c(0, 60),
#'   chartTitle = amText(
#'     "Stacked bar chart",
#'     fontFamily = "Trebuchet MS",
#'     fontSize = 30,
#'     fontWeight = "bold"
#'   ),
#'   xAxis = "Year",
#'   yAxis = "A quantity...",
#'   theme = "kelly",
#'   button = amButton("Update", position = 1),
#'   height = 450
#' )
amStackedBarChart <- function(
  data,
  data2 = NULL,
  category,
  stacks,
  seriesNames = NULL, # default
  colors = NULL,
  hline = NULL,
  yLimits = NULL,
  expandY = 5,
  valueFormatter = "#.",
  chartTitle = NULL,
  theme = NULL,
  animated = TRUE,
  tooltip = NULL, # default
  threeD = FALSE,
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

  series <- do.call(c, stacks)

  if(!is.null(colors)){
    if(!all(series %in% names(colors))){
      stop("Invalid `colors` argument.", call. = TRUE)
    }
    colors <- lapply(colors, validateColor)
  }

  if(is.null(yLimits)){
    dats <- lapply(stacks, function(stack){
      as.matrix(data[stack])
    })
    sums <- do.call(c, lapply(dats, function(dat){
      apply(dat, 1L, sum)
    }))
    yLimits <- c(0, max(pretty(sums)))
    pad <- diff(yLimits) * expandY/100
    yLimits <- yLimits + c(0, pad)
  }

  stacks <- setNames(as.list(
    t(do.call(c, lapply(lengths(stacks), function(stacklength){
      out <- rep(TRUE, stacklength)
      out[1L] <- FALSE
      out
    })))
  ), series)

  if(!all(series %in% names(data))){
    stop("Invalid `stacks` argument.", call. = TRUE)
  }

  if(!(category %in% names(data))){
    stop("Invalid `category` argument: not found in data.", call. = TRUE)
  }

  if(is.null(seriesNames)){
    seriesNames <- setNames(as.list(series), series)
  }else if(is.list(seriesNames) || is.character(seriesNames)){
    if(is.null(names(seriesNames)) && length(seriesNames) == length(series)){
      warning(sprintf(
        "The `seriesNames` %s you provided is unnamed - setting automatic names",
        ifelse(is.list(seriesNames), "list", "vector")
      ))
      seriesNames <- setNames(as.list(seriesNames), series)
    }else if(!all(series %in% names(seriesNames))){
      stop(
        paste0(
          "Invalid `seriesNames` argument. ",
          "It must be a named list associating a name to every column ",
          "given in the `stacks` argument."
        ),
        call. = TRUE
      )
    }
  }else{
    stop(
      paste0(
        "Invalid `seriesNames` argument. ",
        "It must be a named list giving a name for every column ",
        "given in the `stacks` argument."
      ),
      call. = TRUE
    )
  }

  if(!is.null(data2) &&
     (!is.data.frame(data2) ||
      nrow(data2) != nrow(data) ||
      !all(series %in% names(data2)))){
    stop("Invalid `data2` argument.", call. = TRUE)
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
      "[bold]{name}:\n{valueY.value.formatNumber('%s')}[/]",
      valueFormatter
    )
    if(is.null(tooltip)){
      tooltip <-
        setNames(
          rep(list(
            amTooltip(
              #              text = "[bold]{name}:\n{valueY}[/]",
              text = tooltipText,
              auto = !is.null(colors)
            )
          ), length(series)),
          series
        )
    }else if("tooltip" %in% class(tooltip)){
      if(tooltip[["text"]] == "_missing")
        tooltip[["text"]] <- tooltipText
      tooltip <- setNames(rep(list(tooltip), length(series)), series)
    }else if(is.list(tooltip)){
      if(any(!series %in% names(tooltip))){
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
          rep(list(amTooltip(text = tooltip, auto = FALSE)), length(series)),
          series
        )
    }else{
      stop("Invalid `tooltip` argument.", call. = TRUE)
    }
  }

  if(is.null(cellWidth)){
    cellWidth <- 90
  }else{
    cellWidth <- max(50, min(cellWidth, 100))
  }

  if(is.null(columnWidth)){
    columnWidth <- ifelse(length(series) == 1L, 100, 90)
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

  if(is.null(yAxis)){
    yAxis <- list(
      title = if(length(series) == 1L) {
        amText(
          text = series,
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
    legend <- TRUE
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
    chartId <- paste0("stackedbarchart-", randomString(15))
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
    "AmStackedBarChart",
    list(
      data = data,
      data2 = data2,
      category = category,
      seriesNames = as.list(seriesNames),
      colors = colors,
      stacks = stacks,
      minValue = yLimits[1L],
      maxValue = yLimits[2L],
      hline = hline,
      valueFormatter = valueFormatter,
      chartTitle = chartTitle,
      theme = theme,
      animated = animated,
      tooltip = tooltip,
      threeD = threeD,
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
    name = "amChart4",
    reactR::reactMarkup(component),
    width = "auto",
    height = "auto",
    package = "rAmCharts4",
    elementId = elementId
  )
}

