#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#'
#' @export
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

  if(is.atomic(draggable)){
    draggable <- setNames(rep(list(draggable), length(values)), values)
  }

  if(is.null(tooltip)){
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

  if(is.null(columnStyle)){
    columnStyle <- list(
      fill = setNames(rep(list(NULL), length(values)), values),
      stroke = NULL,
      cornerRadius = NULL
    )
  }else if(is.character(columnStyle[["fill"]])){
    columnStyle[["fill"]] <-
      setNames(rep(list(columnStyle[["fill"]]), length(values)), values)
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
  }

  if(is.null(legend)){
    legend <- length(values) > 1L
  }

  if(is.character(caption)){
    caption <- list(text = caption)
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
      x = 10,
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
      backgroundColor = backgroundColor,
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

#' Shiny bindings for amBarChart
#'
#' Output and render functions for using amBarChart within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a amBarChart
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name amBarChart-shiny
#'
#' @export
amBarChartOutput <- function(outputId, width = '100%', height = '400px'){
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
#' @rdname amBarChart-shiny
amChart4_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
