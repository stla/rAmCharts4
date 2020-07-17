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
#' @param valueFormatter a number formatter; see
#' \url{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}
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
#' @param pointsStyle settings of the points style; \code{NULL} for default,
#' otherwise a named list of the form
#' \code{list(yvalue1 = settings1, yvalue2 = settings2, ...)} where
#' \code{settings1}, \code{settings2}, ... are lists created with
#' \code{\link{amCircle}}, \code{\link{amTriangle}} or
#' \code{\link{amRectangle}}; this can also be a
#' single list of settings that will be applied to each series
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
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#' @importFrom stringi stri_rand_strings
#' @importFrom lubridate is.Date is.POSIXt
#' @export
#'
#' @examples # iris data: petal widths ####
#' dat <- iris
#' dat$obs <- rep(1:50, 3)
#' dat <- reshape2::dcast(dat, obs ~ Species, value.var = "Petal.Width")
#'
#' amScatterChart(
#'   data = dat,
#'   width = "700px",
#'   xValue = "obs",
#'   yValues = c("setosa", "versicolor", "virginica"),
#'   draggable = FALSE,
#'   backgroundColor = "#30303d",
#'   pointsStyle = list(
#'     color = list(
#'       setosa = "orange", versicolor = "cyan", virginica = "palegreen"
#'      ),
#'     strokeColor = list(
#'       setosa = "red", versicolor = "blue", virginica = "green"
#'      ),
#'     strokeWidth = 2
#'   ),
#'   tooltip = "obs: {valueX}\nvalue: {valueY}",
#'   chartTitle = list(text = "Iris data", color = "whitesmoke"),
#'   xAxis = list(title = list(text = "Observation",
#'                             fontSize = 21,
#'                             color = "silver"),
#'                labels = list(color = "whitesmoke",
#'                              fontSize = 17)),
#'   yAxis = list(title = list(text = "Petal width",
#'                             fontSize = 21,
#'                             color = "silver"),
#'                labels = list(color = "whitesmoke",
#'                              fontSize = 14)),
#'   valueFormatter = "#.#",
#'   caption = list(text = "[font-style:italic]rAmCharts4[/]",
#'                  color = "yellow"),
#'   gridLines = list(color = "whitesmoke",
#'                    opacity = 0.4,
#'                    width = 1),
#'   theme = "dark")
#'
#'
#' # iris data: petal widths vs petal lengths
#'
#' dat <- iris
#' dat$obs <- rep(1:50, 3)
#' dat <-
#'   reshape2::dcast(dat, obs + Petal.Length ~ Species, value.var = "Petal.Width")
#'
#' amScatterChart(
#'   data = dat,
#'   width = "700px",
#'   xValue = "Petal.Length",
#'   yValues = c("setosa", "versicolor", "virginica"),
#'   draggable = FALSE,
#'   backgroundColor = "#30303d",
#'   pointsStyle = list(
#'     setosa = amCircle(color = "orange", strokeColor = "red"),
#'     versicolor = amCircle(color = "cyan", strokeColor = "blue"),
#'     virginica = amCircle(color = "palegreen", strokeColor = "darkgreen")
#'   ),
#'   tooltip = list(
#'     setosa = amTooltip(
#'       text = "length: {valueX}\nwidth: {valueY}",
#'       backgroundColor = "orange",
#'       borderColor = "red",
#'       textColor = "black"
#'     ),
#'     versicolor = amTooltip(
#'       text = "length: {valueX}\nwidth: {valueY}",
#'       backgroundColor = "cyan",
#'       borderColor = "blue",
#'       textColor = "black"
#'     ),
#'     virginica = amTooltip(
#'       text = "length: {valueX}\nwidth: {valueY}",
#'       backgroundColor = "palegreen",
#'       borderColor = "darkgreen",
#'       textColor = "black"
#'     )
#'   ),
#'   chartTitle = list(text = "Iris data", color = "silver"),
#'   xAxis = list(title = list(text = "Petal length",
#'                             fontSize = 19,
#'                             color = "gold"),
#'                labels = list(color = "whitesmoke",
#'                              fontSize = 17)),
#'   yAxis = list(title = list(text = "Petal width",
#'                             fontSize = 19,
#'                             color = "gold"),
#'                labels = list(color = "whitesmoke",
#'                              fontSize = 17)),
#'   valueFormatter = "#.#",
#'   caption = list(text = "[font-style:italic]rAmCharts4[/]",
#'                  color = "yellow"),
#'   gridLines = list(color = "whitesmoke",
#'                    opacity = 0.4,
#'                    width = 1),
#'   theme = "dark")
amScatterChart <- function(
  data,
  data2 = NULL,
  xValue,
  yValues,
  yValueNames = NULL, # default
  xLimits = NULL,
  yLimits = NULL,
  valueFormatter = "#.",
  chartTitle = NULL,
  theme = NULL,
  draggable = FALSE,
  tooltip = NULL, # default
  pointsStyle = NULL, # default
  backgroundColor = NULL,
  xAxis = NULL, # default
  yAxis = NULL, # default
  scrollbarX = FALSE,
  scrollbarY = FALSE,
  gridLines = NULL,
  legend = NULL, # default
  caption = NULL,
  button = NULL, # default
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
    data[[xValue]] <- format(data[[xValue]], "%Y-%m-%d")
    isDate <- TRUE
  }else{
    isDate <- FALSE
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

  if(!is.null(data2) &&
     (!is.data.frame(data2) ||
      nrow(data2) != nrow(data) || # XXXX
      !all(yValues %in% names(data2)))){
    stop("Invalid `data2` argument.", call. = TRUE)
  }

  if(is.null(xLimits)){
    xLimits <- range(pretty(data[[xValue]]))
    if(!isDate){
      pad <- diff(xLimits) * 0.05
      xLimits <- xLimits + c(-pad, pad)
    }
  }

  if(is.null(yLimits)){
    yLimits <- range(pretty(do.call(c, data[yValues])))
    pad <- diff(yLimits) * 0.05
    yLimits <- yLimits + c(-pad, pad)
  }

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
          rep(list(amTooltip(text = text, auto = TRUE)), length(yValues)),
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
          rep(list(amTooltip(text = tooltip, auto = TRUE)), length(yValues)),
          yValues
        )
    }else{
      stop("Invalid `tooltip` argument.", call. = TRUE)
    }
  }

  # if(is.null(pointsStyle)){
  #   pointsStyle <- list("_" = NULL)
  # }else{
  #   if(is.character(pointsStyle[["color"]])){
  #     pointsStyle[["color"]] <-
  #       setNames(
  #         rep(list(validateColor(pointsStyle[["color"]])), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(pointsStyle[["color"]])){
  #     if(!all(yValues %in% names(pointsStyle[["color"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `color` field of `pointsStyle`. ",
  #           "It must be a named list associating a color for every column ",
  #           "given in the `yValues` argument, or just a color that will be ",
  #           "applied to every series."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #     pointsStyle[["color"]] <-
  #       sapply(pointsStyle[["color"]], validateColor, simplify = FALSE, USE.NAMES = TRUE)
  #   }
  #   if(is.numeric(pointsStyle[["strokeWidth"]])){
  #     pointsStyle[["strokeWidth"]] <-
  #       setNames(
  #         rep(list(pointsStyle[["strokeWidth"]]), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(pointsStyle[["strokeWidth"]])){
  #     if(!all(yValues %in% names(pointsStyle[["strokeWidth"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `strokeWidth` field of `pointsStyle`. ",
  #           "It must be a named list associating a width for every column ",
  #           "given in the `yValues` argument, or just a width that will be ",
  #           "applied to every series."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #   }
  #   if(is.numeric(pointsStyle[["width"]])){
  #     pointsStyle[["width"]] <-
  #       setNames(
  #         rep(list(pointsStyle[["width"]]), length(yValues)),
  #         yValues
  #       )
  #   }else if(is.list(pointsStyle[["width"]])){
  #     if(!all(yValues %in% names(pointsStyle[["width"]]))){
  #       stop(
  #         paste0(
  #           "Invalid `width` field of `pointsStyle`. ",
  #           "It must be a named list associating a width for every column ",
  #           "given in the `yValues` argument, or just a width that will be ",
  #           "applied to every series."
  #         ),
  #         call. = TRUE
  #       )
  #     }
  #   }
  # }

  if(is.null(pointsStyle)){
    pointsStyle <- setNames(rep(list(amTriangle()), length(yValues)), yValues)
  }else if("bullet" %in% class(pointsStyle)){
    pointsStyle <- setNames(rep(list(pointsStyle), length(yValues)), yValues)
  }else if(is.list(pointsStyle)){
    if(any(!yValues %in% names(pointsStyle))){
      stop("Invalid `pointsStyle` list.", call. = TRUE)
    }
  }else{
    stop("Invalid `pointsStyle` argument.", call. = TRUE)
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
    yAxis[["labels"]][["color"]] <- validateColor(yAxis[["labels"]][["color"]])
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

  if(is.null(yAxis[["labels"]])){
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

  if(is.null(button)){
    button <- if(!is.null(data2))
      list(
        text = "Reset",
        color = NULL,
        fill = NULL,
        position = 0.8
      )
  }else if(is.character(button)){
    button <- list(
      text = button,
      color = NULL,
      fill = NULL,
      position = 0.8
    )
  }else if(is.list(button)){
    button[["color"]] <- validateColor(button[["color"]])
    button[["fill"]] <- validateColor(button[["fill"]])
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
    chartId <- paste0("scatterchart-", stringi::stri_rand_strings(1, 15))
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmScatterChart",
    list(
      data = data,
      data2 = data2,
      xValue = xValue,
      isDate = isDate,
      yValues = as.list(yValues),
      yValueNames = yValueNames,
      minX = xLimits[1L],
      maxX = xLimits[2L],
      minY = yLimits[1L],
      maxY = yLimits[2L],
      valueFormatter = valueFormatter,
      chartTitle = chartTitle,
      theme = theme,
      draggable = draggable,
      tooltip = tooltip,
      pointsStyle = pointsStyle,
      backgroundColor = validateColor(backgroundColor),
      xAxis = xAxis,
      yAxis = yAxis,
      scrollbarX = scrollbarX,
      scrollbarY = scrollbarY,
      gridLines = gridLines,
      legend = legend,
      caption = caption,
      button = button,
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

