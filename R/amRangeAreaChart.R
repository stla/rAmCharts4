#' HTML widget displaying a range area chart
#' @description Create a HTML widget displaying a range area chart.
#'
#' @param data a dataframe
#' @param data2 \code{NULL} or a dataframe used to update the data with the
#'   button; its column names must include the column names of \code{data}
#'   given in \code{yValues}, it must have the same number of rows as
#'   \code{data} and its rows must be in the same order as those of \code{data}
#' @param xValue name of the column of \code{data} to be used on the x-axis
#' @param yValues a character matrix with two columns; each row corresponds to
#'   a range area and provides the names of two columns of \code{data} to be
#'   used as the limits of the range area
#' @param areas an unnamed list of list of settings for the range areas; the
#'   n-th inner list of settings corresponds to the n-th row of the
#'   \code{yValues} matrix; each list of settings has three possible fields:
#'   \code{name} for the legend label, \code{color} for the color of the range
#'   area, and \code{opacity} for the opacity of the range area, a number
#'   between 0 and 1
#' @param hline an optional horizontal line to add to the chart; it must be a
#'   named list of the form \code{list(value = h, line = settings)} where
#'   \code{h} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param vline an optional vertical line to add to the chart; it must be a
#'   named list of the form \code{list(value = v, line = settings)} where
#'   \code{v} is the "intercept" and \code{settings} is a list of settings
#'   created with \code{\link{amLine}}
#' @param xLimits range of the x-axis, a vector of two values specifying
#'   the left and right limits of the x-axis; \code{NULL} for default values
#' @param yLimits range of the y-axis, a vector of two values specifying
#'   the lower and upper limits of the y-axis; \code{NULL} for default values
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
#' @param backgroundColor a color for the chart background
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
#'   given as a string, which performs a modification of a string named
#'   \code{text}, e.g. \code{"text = '[font-style:italic]' + text + '[/]';"};
#'   see the example for an example of \code{modifier}
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
#' @note A color can be given by the name of a R color, the name of a CSS
#' color, e.g. \code{"crimson"} or \code{"silver"}, an HEX code like
#' \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#' like \code{"hsl(360,11,255)"}.
#'
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#' @importFrom lubridate is.Date is.POSIXt
#' @export
#'
#' @examples set.seed(666)
#' x <- 1:20
#' dat <- data.frame(
#'   x = x,
#'   y1 = rnorm(20, sd = 1.5),
#'   y2 = rnorm(20, 10, sd = 1.5),
#'   z1 = rnorm(20, x+5, sd = 1.5),
#'   z2 = rnorm(20, x+15, sd = 1.5)
#' )
#'
#' amRangeAreaChart(
#'   data = dat,
#'   width = "700px",
#'   xValue = "x",
#'   yValues = rbind(c("y1", "y2"), c("z1", "z2")),
#'   xLimits = c(1, 20),
#'   draggable = TRUE,
#'   backgroundColor = "#30303d",
#'   tooltip = list(
#'     y1 = amTooltip(
#'       text = "[bold]upper: {openValueY}\nlower: {valueY}[/]",
#'       textColor = "yellow",
#'       backgroundColor = "darkmagenta",
#'       backgroundOpacity = 0.8,
#'       borderColor = "rebeccapurple",
#'       scale = 0.9
#'     ),
#'     y2 = amTooltip(
#'       text = "[bold]upper: {valueY}\nlower: {openValueY}[/]",
#'       textColor = "yellow",
#'       backgroundColor = "darkmagenta",
#'       backgroundOpacity = 0.8,
#'       borderColor = "rebeccapurple",
#'       scale = 0.9
#'     ),
#'     z1 = amTooltip(
#'       text = "[bold]upper: {openValueY}\nlower: {valueY}[/]",
#'       textColor = "white",
#'       backgroundColor = "darkred",
#'       backgroundOpacity = 0.8,
#'       borderColor = "crimson",
#'       scale = 0.9
#'     ),
#'     z2 = amTooltip(
#'       text = "[bold]upper: {valueY}\nlower: {openValueY}[/]",
#'       textColor = "white",
#'       backgroundColor = "darkred",
#'       backgroundOpacity = 0.8,
#'       borderColor = "crimson",
#'       scale = 0.9
#'     )
#'   ),
#'   bullets = list(
#'     y1 = amCircle(color = "yellow", strokeColor = "olive"),
#'     y2 = amCircle(color = "yellow", strokeColor = "olive"),
#'     z1 = amCircle(color = "orangered", strokeColor = "darkred"),
#'     z2 = amCircle(color = "orangered", strokeColor = "darkred")
#'   ),
#'   alwaysShowBullets = FALSE,
#'   lineStyle = list(
#'     y1 = amLine(color = "yellow", width = 3, tensionX = 0.8, tensionY = 0.8),
#'     y2 = amLine(color = "yellow", width = 3, tensionX = 0.8, tensionY = 0.8),
#'     z1 = amLine(color = "orangered", width = 3, tensionX = 0.8, tensionY = 0.8),
#'     z2 = amLine(color = "orangered", width = 3, tensionX = 0.8, tensionY = 0.8)
#'   ),
#'   areas = list(
#'     list(name = "y1-y2", color = "blue", opacity = 0.2),
#'     list(name = "z1-z2", color = "red", opacity = 0.2)
#'   ),
#'   cursor = list(
#'     tooltip = amTooltip(
#'       backgroundColor = "silver"
#'     ),
#'     extraTooltipPrecision = list(x = 0, y = 2),
#'     modifier = list(y = "text = parseFloat(text).toFixed(2);")
#'   ),
#'   chartTitle = amText(text = "Range area chart",
#'                       color = "whitesmoke",
#'                       fontWeight = "bold"),
#'   xAxis = list(title = amText(text = "Observation",
#'                               fontSize = 20,
#'                               color = "silver"),
#'                labels = amAxisLabels(color = "whitesmoke",
#'                                      fontSize = 17),
#'                adjust = 5),
#'   yAxis = list(title = amText(text = "Value",
#'                               fontSize = 20,
#'                               color = "silver"),
#'                labels = amAxisLabels(color = "whitesmoke",
#'                                      fontSize = 17),
#'                gridLines = amLine(color = "antiquewhite",
#'                                   opacity = 0.4, width = 1)),
#'   Xformatter = "#",
#'   Yformatter = "#.00",
#'   image = list(
#'     image = amImage(
#'       href = tinyIcon("react", backgroundColor = "transparent"),
#'       width = 40, height = 40
#'     ),
#'     position = "bottomleft", hjust = 2, vjust = -2
#'   ),
#'   theme = "dark")
amRangeAreaChart <- function(
  data,
  data2 = NULL,
  xValue,
  yValues,
  areas = NULL, # default
  hline = NULL,
  vline = NULL,
  xLimits = NULL,
  yLimits = NULL,
  expandX = 0,
  expandY = 5,
  Xformatter = ifelse(isDate, "yyyy-MM-dd", "#."),
  Yformatter = "#.",
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
  button = NULL,
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

  if(!is.matrix(yValues)){
    yValues <- rbind(yValues)
  }
  if(ncol(yValues) != 2L || !all(yValues %in% names(data))){
    stop("Invalid `yValues` argument.", call. = TRUE)
  }

  if(length(names(areas))){
    areas <- list(areas)
  }else if(is.null(areas)){
    areas <- rep(list(list()), nrow(yValues))
  }
  areas <- lapply(seq_along(areas), function(i){
    settings <- areas[[i]]
    if(!"name" %in% names(settings)){
      settings[["name"]] <- paste0(yValues[i,], collapse = "-")
    }
    settings[["color"]] <- validateColor(settings[["color"]])
    settings
  })

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

  if(is.null(yLimits)){
    yLimits <- range(pretty(do.call(c, data[c(yValues)])))
    pad <- diff(yLimits) * expandY/100
    yLimits <- yLimits + c(-pad, pad)
  }

  yValueNames <- setNames(as.list(yValues), yValues)

  if(!is.null(data2) &&
     (!is.data.frame(data2) ||
      nrow(data2) != nrow(data) || # XXXX
      !all(c(yValues) %in% names(data2)))){
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

  if(is.atomic(draggable)){
    if(length(draggable) != 1L || !is.logical(draggable)){
      stop(
        paste0(
          "Invalid `draggable` argument. ",
          "It must be a named list associating `TRUE` or `FALSE` ",
          "to every column given in the `yValues` argument, ",
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
          "to every column given in the `yValues` argument, ",
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
        "to every column given in the `yValues` argument, ",
        "or just `TRUE` or `FALSE`."
      ),
      call. = TRUE
    )
  }

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
      title = if(nrow(yValues) == 1L) {
        amText(
          text = areas[[1L]][["name"]],
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
    legend <- nrow(yValues) > 1L
  }
  if(isTRUE(legend)){
    legend <- amLegend(
      position = "bottom",
      itemsWidth = 35,
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
    chartId <- paste0("rangeareachart-", randomString(15))
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
    "AmRangeAreaChart",
    list(
      data = data,
      data2 = data2,
      xValue = xValue,
      isDate = isDate,
      yValues = apply(yValues, 1L, as.list),
      yValueNames = yValueNames,
      minX = xLimits[1L],
      maxX = xLimits[2L],
      minY = yLimits[1L],
      maxY = yLimits[2L],
      hline = hline,
      vline = vline,
      chartTitle = chartTitle,
      theme = theme,
      draggable = draggable,
      tooltip = tooltip,
      bullets = bullets,
      alwaysShowBullets = alwaysShowBullets,
      lineStyle = lineStyle,
      areas = areas,
      backgroundColor = validateColor(backgroundColor),
      xAxis = xAxis,
      yAxis = yAxis,
      scrollbarX = scrollbarX,
      scrollbarY = scrollbarY,
      legend = legend,
      caption = caption,
      button = button,
      cursor = cursor,
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

