#' Shiny bindings for using \code{rAmCharts4} in Shiny
#'
#' @description Output and render functions for using the \code{rAmCharts4}
#'   widgets within Shiny applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height must be a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended
#' @param expr an expression that generates a chart with
#'   \code{\link{amBarChart}}, \code{\link{amHorizontalBarChart}},
#'   \code{\link{amLineChart}}, \code{\link{amScatterChart}},
#'   \code{\link{amRangeAreaChart}}, \code{\link{amRadialBarChart}},
#'   \code{\link{amDumbbellChart}}, \code{\link{amHorizontalDumbbellChart}},
#'   \code{\link{amGaugeChart}}, \code{\link{amPieChart}}, or
#'   \code{\link{amPercentageBarChart}}
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


#' Update the data of a bar chart
#' @description Update the data of a bar chart in a Shiny app (vertical,
#'   horizontal, radial, or stacked bar chart).
#'
#' @param session the Shiny \code{session} object
#' @param outputId the output id passed on to \code{\link{amChart4Output}}
#' @param data new data; if it is not valid, then nothing will happen (in order
#'   to be valid it must have the same structure as the data passed on to
#'   \code{\link{amBarChart}} / \code{\link{amHorizontalBarChart}} /
#'   \code{\link{amRadialBarChart}} / \code{\link{amStackedBarChart}}); in this
#'   case check the JavaScript console, it will report the encountered issue
#'
#' @export
#'
#' @examples library(rAmCharts4)
#' library(shiny)
#'
#' ui <- fluidPage(
#'   br(),
#'   actionButton("update", "Update", class = "btn-primary"),
#'   br(), br(),
#'   amChart4Output("barchart", width = "650px", height = "470px")
#' )
#'
#' server <- function(input, output, session){
#'
#'   set.seed(666)
#'   dat <- data.frame(
#'     country = c("USA", "China", "Japan", "Germany", "UK", "France"),
#'     visits = c(3025, 1882, 1809, 1322, 1122, 1114),
#'     income = rpois(6, 25),
#'     expenses = rpois(6, 20)
#'   )
#'   newdat <- data.frame(
#'     country = c("USA", "China", "Japan", "Germany", "UK", "France"),
#'     income = rpois(6, 25),
#'     expenses = rpois(6, 20)
#'   )
#'
#'   output[["barchart"]] <- renderAmChart4({
#'     amBarChart(
#'       data = dat,
#'       category = "country",
#'       values = c("income", "expenses"),
#'       valueNames = list(income = "Income", expenses = "Expenses"),
#'       draggable = TRUE,
#'       backgroundColor = "#30303d",
#'       columnStyle = list(
#'         income = amColumn(
#'           color = "darkmagenta", strokeColor = "#cccccc", strokeWidth = 2
#'         ),
#'         expenses = amColumn(
#'           color = "darkred", strokeColor = "#cccccc", strokeWidth = 2
#'         )
#'       ),
#'       chartTitle = list(text = "Income and expenses per country"),
#'       xAxis = "Country",
#'       yAxis = "Income and expenses",
#'       yLimits = c(0, 41),
#'       valueFormatter = "#.#",
#'       caption = "Year 2018",
#'       theme = "dark")
#'   })
#'
#'   observeEvent(input[["update"]], {
#'     updateAmBarChart(session, "barchart", newdat)
#'   })
#'
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
#'
#'
#' # Survival probabilities ####
#' library(shiny)
#' library(rAmCharts4)
#'
#' probs <- c(control = 30, treatment = 75) # initial probabilities
#'
#' ui <- fluidPage(
#'   br(),
#'   sidebarLayout(
#'     sidebarPanel(
#'       wellPanel(
#'         tags$fieldset(
#'           tags$legend("Survival probability"),
#'           sliderInput(
#'             "control",
#'             "Control group",
#'             min = 0, max = 100, value = probs[["control"]], step = 1
#'           ),
#'           sliderInput(
#'             "treatment",
#'             "Treatment group",
#'             min = 0, max = 100, value = probs[["treatment"]], step = 1
#'           )
#'         )
#'       )
#'     ),
#'     mainPanel(
#'       amChart4Output("barchart", width = "500px", height = "400px")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session){
#'
#'   dat <- data.frame(
#'     group = c("Control", "Treatment"),
#'     alive = c(probs[["control"]], probs[["treatment"]]),
#'     dead  = 100 - c(probs[["control"]], probs[["treatment"]])
#'   )
#'   stacks <- list(
#'     c("alive", "dead")
#'   )
#'   seriesNames <- list(
#'     alive = "Alive",
#'     dead  = "Dead"
#'   )
#'
#'   output[["barchart"]] <- renderAmChart4({
#'     amStackedBarChart(
#'       dat,
#'       category = "group",
#'       stacks = stacks,
#'       seriesNames = seriesNames,
#'       yLimits = c(0, 100),
#'       chartTitle = amText(
#'         "Survival probabilities",
#'         fontFamily = "Trebuchet MS",
#'         fontSize = 30,
#'         fontWeight = "bold"
#'       ),
#'       xAxis = "Group",
#'       yAxis = "Probability",
#'       theme = "dataviz"
#'     )
#'   })
#'
#'   observeEvent(list(input[["control"]], input[["treatment"]]), {
#'     newdat <- data.frame(
#'       group = c("Control", "Treatment"),
#'       alive = c(input[["control"]], input[["treatment"]]),
#'       dead  = 100 - c(input[["control"]], input[["treatment"]])
#'     )
#'     updateAmBarChart(session, "barchart", newdat)
#'   })
#'
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
updateAmBarChart <- function(session, outputId, data){
  stopifnot(is.data.frame(data))
  session$sendCustomMessage(paste0(outputId, "bar"), data)
}


#' Update the data of a 100\% stacked bar chart
#' @description Update the data of a 100\% staced bar chart in a Shiny app
#'   (\code{\link{amPercentageBarChart}}).
#'
#' @param session the Shiny \code{session} object
#' @param outputId the output id passed on to \code{\link{amChart4Output}}
#' @param data new data; if it is not valid, then nothing will happen (in order
#'   to be valid it must have the same structure as the data passed on to
#'   \code{\link{amPercentageBarChart}}); in this
#'   case check the JavaScript console, it will report the encountered issue
#'
#' @export
#'
#' @examples library(rAmCharts4)
#' library(shiny)
#'
#' dat <- data.frame(
#'   country = c("Australia", "Canada", "France", "Germany"),
#'   "35-44" = c(2, 2, 3, 3),
#'   "45-54" = c(9, 5, 7, 6),
#'   "55+"   = c(8, 4, 6, 5),
#'   check.names = FALSE
#' )
#'
#' newdat <- data.frame(
#'   country = c("Australia", "Canada", "France", "Germany"),
#'   "35-44" = c(3, 2, 3, 4),
#'   "45-54" = c(7, 3, 5, 5),
#'   "55+"   = c(7, 4, 5, 3),
#'   check.names = FALSE
#' )
#'
#'
#' ui <- fluidPage(
#'   br(),
#'   actionButton("update", "Update", class = "btn-primary"),
#'   br(), br(),
#'   amChart4Output("pbarchart", width = "650px", height = "470px")
#' )
#'
#' server <- function(input, output, session){
#'
#'   output[["pbarchart"]] <- renderAmChart4({
#'     amPercentageBarChart(
#'       dat,
#'       category = "country",
#'       values = c("35-44", "45-54", "55+"),
#'       chartTitle = "Profit by country and age breakdowns",
#'       xAxis = "Country",
#'       yAxis = "Profit",
#'       theme = "moonrisekingdom",
#'       legend = amLegend(position = "right")
#'     )
#'   })
#'
#'   observeEvent(input[["update"]], {
#'     updateAmPercentageBarChart(session, "pbarchart", newdat)
#'   })
#'
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
updateAmPercentageBarChart <- function(session, outputId, data){
  stopifnot(is.data.frame(data))
  session$sendCustomMessage(paste0(outputId, "percentage"), data)
}


#' Update the score of a gauge chart
#' @description Update the score of a gauge chart in a Shiny app
#'
#' @param session the Shiny \code{session} object
#' @param outputId the output id passed on to \code{\link{amChart4Output}}
#' @param score new value of the score
#'
#' @export
#'
#' @examples library(rAmCharts4)
#' library(shiny)
#'
#' gradingData <- data.frame(
#'   label = c("Slow", "Moderate", "Fast"),
#'   lowScore = c(0, 100/3, 200/3),
#'   highScore = c(100/3, 200/3, 100)
#' )
#'
#'
#' ui <- fluidPage(
#'   sidebarLayout(
#'     sidebarPanel(
#'       sliderInput(
#'         "slider", "Score", min = 0, max = 100, value = 30
#'       )
#'     ),
#'     mainPanel(
#'       amChart4Output("gauge", height = "500px")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session){
#'
#'   output[["gauge"]] <- renderAmChart4({
#'     amGaugeChart(
#'       score = isolate(input[["slider"]]),
#'       minScore = 0, maxScore = 100, gradingData = gradingData,
#'       theme = "dataviz"
#'     )
#'   })
#'
#'   observeEvent(input[["slider"]], {
#'     updateAmGaugeChart(session, "gauge", score = input[["slider"]])
#'   })
#'
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
updateAmGaugeChart <- function(session, outputId, score){
  stopifnot(is.numeric(score) && length(score) == 1L)
  session$sendCustomMessage(paste0(outputId, "gauge"), score)
}



#' Update the data of a pie chart
#' @description Update the data of a pie chart in a Shiny app.
#'
#' @param session the Shiny \code{session} object
#' @param outputId the output id passed on to \code{\link{amChart4Output}}
#' @param data new data; if it is not valid, then nothing will happen (in order
#'   to be valid it must have the same structure as the data passed on to
#'   \code{\link{amPieChart}}); in this case check the JavaScript console, it
#'   will report the encountered issue
#'
#' @export
updateAmPieChart <- function(session, outputId, data){
  stopifnot(is.data.frame(data))
  session$sendCustomMessage(paste0(outputId, "pie"), data)
}
