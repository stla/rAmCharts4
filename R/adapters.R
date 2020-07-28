#' Adapters
#'
#' @param values vector of values
#'
#' @export
#' @name rAmCharts4-adapters
amAdapterFromVector <- function(values){
  js <- c(
    "function(x, target) {",
    sprintf("  let values = [%s];", toString(paste0("'", values, "'"))),
    "  return values[target.dataItem.index];",
    "}"
  )
  out <- htmlwidgets::JS(js)
  attr(out, "nvalues") <- length(values)
  out
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
