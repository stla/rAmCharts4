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
#'   \code{\link{amBarChart}}, \code{\link{amHorizontalBarChart}},
#'   \code{\link{amLineChart}}, \code{\link{amScatterChart}},
#'   \code{\link{amRangeAreaChart}}, \code{\link{amRadialBarChart}},
#'   \code{\link{amDumbbellChart}}, or \code{\link{amHorizontalDumbbellChart}}
#' @param env the environment in which to evaluate \code{expr}
#' @param quoted whether \code{expr} is a quoted expression
#'
#' @name rAmCharts4-shiny
#'
#' @import htmlwidgets
#' @export
#'
#' @examples library(rAmCharts4)
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
#'       tags$fieldset(
#'         tags$legend("Chart data"),
#'         verbatimTextOutput("chartData"),
#'       ),
#'       tags$fieldset(
#'         tags$legend("Change"),
#'         verbatimTextOutput("chartChange")
#'       )
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
#'       chartTitle = amText(
#'         text = "Number of visits",
#'         color = "crimson",
#'         fontWeight = "bold",
#'         fontFamily = "cursive"
#'       ),
#'       xAxis = list(
#'         title = "Date",
#'         labels = amAxisLabels(rotation = -45),
#'         breaks = amAxisBreaks(timeInterval = "1 month")
#'       ),
#'       yAxis = "Visits",
#'       yLimits = c(0, 35),
#'       backgroundColor = "whitesmoke",
#'       tooltip = "[bold][font-style:italic]{dateX}[/]\nvisits: {valueY}[/]",
#'       Yformatter = "#",
#'       caption = amText(
#'         text = "[bold font-size:22]Year 2018[/]",
#'         color = "fuchsia"
#'       ),
#'       button = amButton(
#'         label = amText("Reset data", color = "black"),
#'         color = "seashell",
#'         position = 0.95
#'       ),
#'       theme = "dataviz")
#'   })
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
#' if(interactive()) {
#'   shinyApp(ui, server)
#' }
amChart4Output <- function(outputId, width = "100%", height = "400px"){
  htmlwidgets::shinyWidgetOutput(
    outputId, 'amChart4', width, height, package = 'rAmCharts4')
}

#' @rdname rAmCharts4-shiny
#' @export
renderAmChart4 <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, amChart4Output, env, quoted = TRUE)
}

