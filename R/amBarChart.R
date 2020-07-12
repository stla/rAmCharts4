#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
amBarChart <- function(width = NULL, height = NULL, elementId = NULL) {

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmBarChart",
    list(x = 10)
  )
  # create widget
  htmlwidgets::prependContent(
    htmlwidgets::createWidget(
      name = 'amChart4',
      reactR::reactMarkup(component),
      width = width,
      height = height,
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
  htmlwidgets::shinyWidgetOutput(outputId, 'amBarChart', width, height, package = 'rAmCharts4')
}

#' @rdname amBarChart-shiny
#' @export
renderAmBarChart <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, amBarChartOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname amBarChart-shiny
amBarChart_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
