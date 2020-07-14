regex_255 <- "\\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\\s*"

regex_rgb <- paste0("^rgb\\(",
                    "(", regex_255, "),",
                    "(", regex_255, "),",
                    "(", regex_255, ")\\)$")

regex_360 <- "\\s*([012]?[0-9]?[0-9]|3[0-5][0-9]|360)\\s*"

regex_hsl <- paste0("^hsl\\(",
                    "(", regex_360, "),",
                    "(", regex_255, "),",
                    "(", regex_255, ")\\)$")

cssColors <- c("transparent", "aqua", "crimson", "fuchsia", "indigo", "lime",
               "olive", "rebeccapurple", "silver", "teal")

validateColor <- function(color){
  if(is.null(color)) return(NULL)
  if(grepl(regex_rgb, color) || grepl(regex_hsl, color) || color %in% cssColors){
    return(color)
  }
  RGB <- col2rgb(color)[,1]
  rgb(RGB["red"], RGB["green"], RGB["blue"], maxColorValue = 255)
}

#' Create a HTML widget displaying a bar chart
#' @description Create a HTML widget displaying a bar chart.
#'
#' @param data a dataframe
#' @param data2 a dataframe used to update the data with the button
#' @param category name of the column of \code{data} to be used on the
#' category axis
#' @param values name(s) of the column(s) of \code{data} to be used on the
#' value axis
#' @param valueNames names of the values variables, to appear in the legend;
#' \code{NULL} to use \code{values} as names, otherwise a named list of the
#' form \code{list(value1 = "ValueName1", value2 = "ValueName2", ...)} where
#' \code{value1}, \code{value2}, ... are the column names given in
#' \code{values} and \code{"ValueName1"}, \code{"ValueName2"}, ... are the
#' desired names to appear in the legend
#' @param minValue minimum value of the y-axis
#' @param maxValue maximum value of the y-axis
#' @param valueFormatter a number formatter; see
#' \url{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}
#' @param chartTitle chart title, \code{NULL}, character, or list of settings
#' @param theme theme, \code{NULL} or one of \code{"dataviz"},
#' \code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
#' \code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
#' \code{"microchart"}
#' @param draggable \code{TRUE}/\code{FALSE} to enable/disable dragging of
#' all bars, otherwise a named list of the form
#' \code{list(value1 = TRUE, value2 = FALSE, ...)} to enable/disable the
#' dragging for each bar corresponding to a column given in \code{values}
#' @param tooltip tooltip settings given as a list, or just a string for the
#' \code{text} field, or \code{NULL} for no tooltip; the \code{text} field is
#' given as a formatted string; see
#' \url{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-strings/}
#' @param columnStyle settings of the columns style; \code{NULL} for default,
#' otherwise a named list with three fields: \code{fill} to set the colors
#' of the columns, given as a single color or a named list of the form
#' \code{list(value1 = "red", value2 = "green", ...)}, \code{stroke} to set
#' the color of the borders of the columns, and \code{cornerRadius} to set
#' the radius of the corners of the columns
#' @param backgroundColor a color for the chart background
#' @param cellWidth cell width in percent; for a simple bar chart, this is the
#' width of the columns; for a grouped bar chart, this is the width of the
#' clusters of columns
#' @param columnWidth column width, a percentage of the cell width; set to 100
#' for a simple bar chart and use \code{cellWidth} to control the width of the
#' columns; for a grouped bar chart, this controls the spacing between the
#' columns within a cluster of columns
#' @param xAxis settings of the category axis given as a list, or just a string
#' for the axis title
#' @param yAxis settings of the value axis given as a list, or just a string
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
#' given in \code{\link{amBarChartOutput}}
#' @param height the height of the chart, e.g. \code{"400px"};
#' ignored if the chart is displayed in Shiny, in which case the width is
#' given in \code{\link{amBarChartOutput}}
#' @param chartId a HTML id for the chart
#' @param elementId a HTML id for the container of the chart; ignored if the
#' chart is displayed in Shiny, in which case the id is given by the Shiny id
#'
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#' @export
#'
#' @examples # a simple bar chart ####
#'
#' dat <- data.frame(
#'   country = c("USA", "China", "Japan", "Germany", "UK", "France"),
#'   visits = c(3025, 1882, 1809, 1322, 1122, 1114)
#' )
#'
#' amBarChart(
#'   data = dat, data2 = dat,
#'   width = "600px",
#'   category = "country", values = "visits",
#'   draggable = TRUE,
#'   tooltip = "[font-style:italic;#ffff00]{valueY}[/]",
#'   chartTitle =
#'     list(text = "Visits per country", fontSize = 22, color = "orangered"),
#'   xAxis = list(title = list(text = "Country", color = "maroon")),
#'   yAxis = list(title = list(text = "Visits", color = "maroon")),
#'   minValue = 0, maxValue = 4000,
#'   valueFormatter = "#.",
#'   caption = list(text = "Year 2018", color = "red"),
#'   theme = "material")
#'
#' # a grouped barchart
#'
#' set.seed(666)
#' dat <- data.frame(
#'   country = c("USA", "China", "Japan", "Germany", "UK", "France"),
#'   visits = c(3025, 1882, 1809, 1322, 1122, 1114),
#'   income = rpois(6, 25),
#'   expenses = rpois(6, 20)
#' )
#'
#' amBarChart(
#'   data = dat,
#'   width = "700px",
#'   category = "country",
#'   values = c("income", "expenses"),
#'   valueNames = list(income = "Income", expenses = "Expenses"),
#'   draggable = list(income = TRUE, expenses = FALSE),
#'   backgroundColor = "#30303d",
#'   columnStyle = list(
#'     fill = list(income = "darkmagenta", expenses = "darkred"),
#'     stroke = "#cccccc"
#'   ),
#'   chartTitle = list(text = "Income and expenses per country"),
#'   xAxis = list(title = list(text = "Country")),
#'   yAxis = list(title = list(text = "Income and expenses")),
#'   minValue = 0, maxValue = 41,
#'   valueFormatter = "#.#",
#'   caption = list(text = "Year 2018"),
#'   theme = "dark")
amBarChart <- function(
  data,
  data2 = NULL,
  category,
  values,
  valueNames = NULL, # default
  minValue,
  maxValue,
  valueFormatter = "#.",
  chartTitle = NULL,
  theme = NULL,
  draggable = FALSE,
  tooltip = NULL, # default
  columnStyle = NULL, # default
  backgroundColor = NULL,
  cellWidth = NULL, # default
  columnWidth = NULL, # default
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

  if(is.null(valueNames)){
    valueNames <- setNames(as.list(values), values)
  }

  if(is.character(chartTitle)){
    chartTitle <- list(text = chartTitle, fontSize = 22, color = NULL)
  }
  if(!is.null(chartTitle$color)){
    chartTitle$color <- validateColor(chartTitle$color)
  }

  if(is.atomic(draggable)){
    draggable <- setNames(rep(list(draggable), length(values)), values)
  }

  if(is.list(tooltip)){
    tooltip$labelColor <- validateColor(tooltip$labelColor)
    tooltip$backgroundColor <- validateColor(tooltip$backgroundColor)
  }else if(is.null(tooltip)){
    tooltip <- list(
      text = "[bold]{name}:\n{valueY}[/]",
      labelColor = "#ffffff",
      backgroundColor = "#101010",
      backgroundOpacity = 1,
      scale = 1
    )
  }else if(is.character(tooltip)){
    tooltip <- list(text = tooltip)
  }

  if(!is.null(columnStyle[["stroke"]])){
    columnStyle[["stroke"]] <- validateColor(columnStyle[["stroke"]])
  }
  if(is.null(columnStyle)){
    columnStyle <- list(
      fill = setNames(rep(list(NULL), length(values)), values),
      stroke = NULL,
      cornerRadius = NULL
    )
  }else if(is.character(columnStyle[["fill"]])){
    columnStyle[["fill"]] <-
      setNames(
        rep(list(validateColor(columnStyle[["fill"]])), length(values)),
        values
      )
  }else if(is.list(columnStyle[["fill"]])){
    columnStyle[["fill"]] <-
      sapply(columnStyle[["fill"]], validateColor, simplify = FALSE, USE.NAMES = TRUE)
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

  if(is.list(xAxis)){
    if(is.list(xAxis[["title"]])){
      xAxis[["title"]][["color"]] <- validateColor(xAxis[["title"]][["color"]])
    }
    xAxis[["labels"]][["color"]] <- validateColor(xAxis[["labels"]][["color"]])
  }
  if(is.null(xAxis)){
    xAxis <- list(
      title = list(
        text = category,
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
      title = if(length(values) == 1L) {
        list(
          text = values,
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
  }else if(is.character(xAxis)){
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
    legend <- length(values) > 1L
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
    chartId <- paste0("barchart-", stringi::stri_rand_strings(1, 15))
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmBarChart",
    list(
      data = data,
      data2 = data2,
      category = category,
      values = as.list(values),
      valueNames = valueNames,
      minValue = minValue,
      maxValue = maxValue,
      valueFormatter = valueFormatter,
      chartTitle = chartTitle,
      theme = theme,
      draggable = draggable,
      tooltip = tooltip,
      columnStyle = columnStyle,
      backgroundColor = validateColor(backgroundColor),
      cellWidth = cellWidth,
      columnWidth = columnWidth,
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

#' Shiny bindings for \code{amBarChart}
#'
#' @description Output and render functions for using \code{\link{amBarChart}}
#' within Shiny applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height must be a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended
#' @param expr an expression that generates a bar chart with
#' \code{\link{amBarChart}}
#' @param env the environment in which to evaluate \code{expr}
#' @param quoted whether \code{expr} is a quoted expression
#'
#' @name amBarChart-shiny
#'
#' @export
amBarChartOutput <- function(outputId, width = "100%", height = "400px"){
  htmlwidgets::shinyWidgetOutput(outputId, 'amChart4', width, height, package = 'rAmCharts4')
}

#' @rdname amBarChart-shiny
#' @export
renderAmBarChart <- function(expr, env = parent.frame(), quoted = FALSE) {
  expr[["prepend"]] <- NULL
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, amBarChartOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @noRd
amChart4_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
