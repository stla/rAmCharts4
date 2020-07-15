#' Shiny bindings for using \code{rAmCharts4} in Shiny
#'
#' @description Output and render functions for using
#' the \code{rAmCharts4} widgets
#' within Shiny applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height must be a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended
#' @param expr an expression that generates a chart with
#' \code{\link{amBarChart}} or \code{\link{amHorizontalBarChart}}
#' @param env the environment in which to evaluate \code{expr}
#' @param quoted whether \code{expr} is a quoted expression
#'
#' @name rAmCharts4-shiny
#'
#' @import htmlwidgets htmltools
#' @export
amChart4Output <- function(outputId, width = "100%", height = "400px"){
  htmlwidgets::shinyWidgetOutput(outputId, 'amChart4', width, height, package = 'rAmCharts4')
}

#' @rdname rAmCharts4-shiny
#' @export
renderAmChart4 <- function(expr, env = parent.frame(), quoted = FALSE) {
  expr[["prepend"]] <- NULL
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, amChart4Output, env, quoted = TRUE)
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
