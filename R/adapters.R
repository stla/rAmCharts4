#' Adapters
#' @description Adapters allow to have finer control of settings such as
#'   the colors of the columns of a bar chart or the colors of the points
#'   of a scatter chart.
#'
#' @param colors a vector of colors
#' @param cuts a vector of cut points (sorted increasingly)
#' @param value a mathematical expression of the variables \code{X} and
#'   \code{Y} given as JavaScript code; the simplest examples are \code{"X"}
#'   and \code{"Y"}, a more elaborate example is
#'   \code{"Math.sqrt(X**2+Y**2)"} (don't forget that the power in JavaScript
#'   is '\code{**}', not '\code{^}'!);
#'   see the examples
#'
#' @export
#' @name rAmCharts4-adapters
#'
#' @examples # bar chart with individual colors ####
#'
#' dat <- data.frame(
#'   country = c("USA", "China", "Japan", "Germany", "UK", "France"),
#'   visits = c(3025, 1882, 1809, 1322, 1122, 1114)
#' )
#'
#' amBarChart(
#'   data = dat,
#'   width = "600px",
#'   category = "country", values = "visits",
#'   showValues = FALSE,
#'   tooltip = FALSE,
#'   columnStyle = amColumn(
#'     color = amColorAdapterFromVector(hcl.colors(6, "Viridis")),
#'     opacity = 0.7,
#'     strokeColor = amColorAdapterFromVector(hcl.colors(6, "Cividis")),
#'     strokeWidth = 4
#'   ),
#'   bullets = amCircle(
#'     color = amColorAdapterFromVector(hcl.colors(6, "Viridis")),
#'     opacity = 1,
#'     strokeColor = amColorAdapterFromVector(hcl.colors(6, "Cividis")),
#'     strokeWidth = 4,
#'     radius = 12
#'   ),
#'   alwaysShowBullets = TRUE,
#'   chartTitle =
#'     amText(text = "Visits per country", fontSize = 22, color = "orangered"),
#'   backgroundColor = "rgb(164,167,174)",
#'   xAxis = list(title = amText(text = "Country", color = "maroon")),
#'   yAxis = list(
#'     title = amText(text = "Visits", color = "maroon"),
#'     gridLines = amLine(color = "white", width = 1, dash = "3,3")
#'   ),
#'   yLimits = c(0, 4000),
#'   valueFormatter = "#,###.",
#'   caption = amText(text = "Year 2018", color = "red")
#' )
#'
#'
#' # usage example of amColorAdapterFromCuts ####
#'
#' set.seed(314159)
#' dat <- data.frame(
#'   x = rnorm(200),
#'   y = rnorm(200)
#' )
#'
#' amScatterChart(
#'   data = dat,
#'   width = "500px", height = "500px",
#'   xValue = "x", yValues = "y",
#'   xLimits = c(-3,3), yLimits = c(-3,3),
#'   draggable = FALSE,
#'   backgroundColor = "#30303d",
#'   pointsStyle = amCircle(
#'     color = amColorAdapterFromCuts(
#'       cuts = c(-2, -1, 1, 2),
#'       colors = c("red", "green", "blue", "green", "red"),
#'       value = "Y"
#'     ),
#'     opacity = 0.5,
#'     strokeColor = amColorAdapterFromCuts(
#'       cuts = c(-2, -1, 1, 2),
#'       colors = c("darkred", "darkgreen", "darkblue", "darkgreen", "darkred"),
#'       value = "Y"
#'     )
#'   ),
#'   xAxis = list(
#'     breaks = amAxisBreaks(seq(-3, 3, by=1)),
#'     gridLines = amLine(opacity = 0.3, width = 1)
#'   ),
#'   yAxis = list(
#'     breaks = amAxisBreaks(seq(-3, 3, by=1)),
#'     gridLines = amLine(opacity = 0.3, width = 1)
#'   ),
#'   tooltip = FALSE,
#'   caption = amText(text = "[font-style:italic]rAmCharts4[/]",
#'                    color = "yellow"),
#'   theme = "dark")
#'
#'
#' # other usage example of amColorAdapterFromCuts: linear gradient ####
#'
#' set.seed(314159)
#' dat <- data.frame(
#'   x = rnorm(500),
#'   y = rnorm(500)
#' )
#'
#' amScatterChart(
#'   data = dat,
#'   width = "500px", height = "500px",
#'   xValue = "x", yValues = "y",
#'   xLimits = c(-3,3), yLimits = c(-3,3),
#'   draggable = FALSE,
#'   backgroundColor = "#30303d",
#'   pointsStyle = amCircle(
#'     radius = 4,
#'     strokeWidth = 1,
#'     color = amColorAdapterFromCuts(
#'       cuts = seq(-3, 3, length.out = 121),
#'       colors = colorRampPalette(
#'         c("red","orangered","blue","white","blue","orangered","red")
#'       )(122),
#'       value = "X"
#'     ),
#'     opacity = 0.75,
#'     strokeColor = amColorAdapterFromCuts(
#'       cuts = seq(-3, 3, length.out = 121),
#'       colors = colorRampPalette(
#'         c("red","orangered","blue","white","blue","orangered","red")
#'       )(122),
#'       value = "X"
#'     )
#'   ),
#'   xAxis = list(
#'     breaks = amAxisBreaks(seq(-3, 3, by=1)),
#'     gridLines = amLine(opacity = 0.3, width = 1)
#'   ),
#'   yAxis = list(
#'     breaks = amAxisBreaks(seq(-3, 3, by=1)),
#'     gridLines = amLine(opacity = 0.3, width = 1)
#'   ),
#'   tooltip = FALSE,
#'   caption = amText(text = "[font-style:italic]rAmCharts4[/]",
#'                    color = "yellow"),
#'   theme = "dark")
#'
#'
#' # yet another usage example of amColorAdapterFromCuts: radial gradient
#'
#' set.seed(314159)
#' dat <- data.frame(
#'   x = rnorm(1000),
#'   y = rnorm(1000)
#' )
#'
#' amScatterChart(
#'   data = dat,
#'   width = "500px", height = "500px",
#'   xValue = "x", yValues = "y",
#'   xLimits = c(-3,3), yLimits = c(-3,3),
#'   draggable = FALSE,
#'   backgroundColor = "#30303d",
#'   pointsStyle = amCircle(
#'     radius = 4,
#'     strokeWidth = 1,
#'     color = amColorAdapterFromCuts(
#'       cuts = seq(0, 3, length.out = 121),
#'       colors = colorRampPalette(
#'         c("white","blue","orangered","red")
#'       )(122),
#'       value = "Math.sqrt(X**2+Y**2)"
#'     ),
#'     opacity = 0.75,
#'     strokeColor = amColorAdapterFromCuts(
#'       cuts = seq(0, 3, length.out = 121),
#'       colors = colorRampPalette(
#'         c("white","blue","orangered","red")
#'       )(122),
#'       value = "Math.sqrt(X**2+Y**2)"
#'     )
#'   ),
#'   xAxis = list(
#'     breaks = amAxisBreaks(seq(-3, 3, by=1)),
#'     gridLines = amLine(opacity = 0.3, width = 1)
#'   ),
#'   yAxis = list(
#'     breaks = amAxisBreaks(seq(-3, 3, by=1)),
#'     gridLines = amLine(opacity = 0.3, width = 1)
#'   ),
#'   tooltip = FALSE,
#'   caption = amText(text = "[font-style:italic]rAmCharts4[/]",
#'                    color = "yellow"),
#'   theme = "dark")
amColorAdapterFromVector <- function(colors){
  colors <- sapply(colors, validateColor)
  js <- c(
    "function(x, target) {",
    "  if(!target.dataItem) return x;",
    sprintf("  let values = [%s];", toString(paste0("'", colors, "'"))),
    "  return values[target.dataItem.index];",
    "}"
  )
  out <- htmlwidgets::JS(js)
  attr(out, "nvalues") <- length(colors)
  out
}

#' @rdname rAmCharts4-adapters
#' @export
amColorAdapterFromCuts <- function(cuts, colors, value){
  #axis <- match.arg(axis, c("X", "Y"))
  colors <- sapply(colors, validateColor)
  #itemValue <- ifelse(axis == "X", "valueX", "valueY")
  n <- length(cuts)
  if(n != length(colors) - 1L)
    stop("`length(cuts)` must be equal to `length(colors)-1`", call. = TRUE)
  if(n == 0L){
    returnValue <- colors
  }else{
    if(!all(cuts == sort(cuts)))
      stop("`cuts` must be sorted increasingly")
    returnValue <- ""
    for(i in 1L:n){
      returnValue <-
        paste0(returnValue, sprintf("value <= %s ? '%s' : ", cuts[i], colors[i]))
    }
    returnValue <- paste0(returnValue, paste0("'", colors[n+1L], "'"))
  }
  js <- c(
    "function(x, target) {",
    "  if(!target.dataItem) return x;",
    "  let X = target.dataItem.valueX, Y = target.dataItem.valueY;",
    sprintf("  let value = %s;", value),
    # sprintf("  let value = target.dataItem.%s;", itemValue),
    sprintf("  return %s;", returnValue),
    "}"
  )
  htmlwidgets::JS(js)
}
# // columnTemplate.adapter.add("fill", (x, target) => {
#   //   let item = target.dataItem;
#   //   let value = item.valueY;
#   //   //
#     //   let colors = ["red", "green", "blue", "yellow", "crimson", "fuchsia"];
#     //   let color = colors[index];
#     //   //
#       //   return color;
#     // });
