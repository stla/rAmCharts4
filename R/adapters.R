#' Adapters
#'
#' @param colors vector of colors
#' @param cuts a vector of cut points (sorted increasingly)
#' @param axis \code{"X"} or \code{"Y"}
#'
#' @export
#' @name rAmCharts4-adapters
amColorAdapterFromVector <- function(colors){
  colors <- sapply(colors, validateColor)
  js <- c(
    "function(x, target) {",
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
amColorAdapterFromCuts <- function(cuts, colors, axis){
  axis <- match.arg(axis, c("X", "Y"))
  colors <- sapply(colors, validateColor)
  itemValue <- ifelse(axis == "X", "valueX", "valueY")
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
    returnValue <- paste0(returnValue, colors[n+1L])
  }
  js <- c(
    "function(x, target) {",
    sprintf("  let value = target.dataItem.%s;", itemValue),
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
