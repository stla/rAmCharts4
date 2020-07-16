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
#' \code{\link{amBarChart}}, \code{\link{amHorizontalBarChart}} or
#' \code{\link{amLineChart}}
#' @param env the environment in which to evaluate \code{expr}
#' @param quoted whether \code{expr} is a quoted expression
#'
#' @name rAmCharts4-shiny
#'
#' @import htmlwidgets htmltools
#' @export
#'
#' @examples if(interactive()) {
#' library(rAmCharts4)
#' library(shiny)
#' library(lubridate)
#'
#' ui <- fluidPage(
#'   br(),
#'   fluidRow(
#'     column(
#'       width = 8,
#'       amChart4Output("linechart", height = "500px")
#'     ),
#'     column(
#'       width = 4,
#'       verbatimTextOutput("chartData"),
#'       verbatimTextOutput("chartChange")
#'     )
#'   )
#' )
#'
#' server <- function(input, output){
#'
#'   set.seed(666)
#'   dat <- data.frame(
#'     date = ymd(180101) + months(0:11),
#'     visits = rpois(12, 20),
#'     x = 1:12
#'   )
#'
#'   output[["linechart"]] <- renderAmChart4({
#'     amLineChart(
#'       data = dat,
#'       data2 = dat,
#'       xValue = "date",
#'       yValues = "visits",
#'       draggable = TRUE,
#'       chartTitle = list(text = "Number of visits", color = "crimson"),
#'       xAxis = list(title = "Date", labels = list(rotation = -45)),
#'       yAxis = "Visits",
#'       minY = 0, maxY = 35,
#'       backgroundColor = "whitesmoke",
#'       tooltip = "[bold][font-style:italic]{dateX}[/]\nvisits: {valueY}[/]",
#'       valueFormatter = "#",
#'       caption = list(
#'         text = "[bold font-size:22]Year 2018[/]",
#'         color = "fuchsia"
#'       ),
#'       button = list(
#'         text = "Reset data",
#'         color = "black",
#'         fill = "seashell",
#'         position = 0.9
#'       ),
#'       theme = "dataviz")
#'   })
#'
#'
#'   output[["chartData"]] <- renderPrint({
#'     input[["linechart"]]
#'   })
#'
#'   output[["chartChange"]] <- renderPrint({
#'     input[["linechart_change"]]
#'   })
#'
#' }
#'
#' shinyApp(ui, server)
#' }
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
