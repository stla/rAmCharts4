#' Legend
#' @description Create a list of settings for a legend.
#'
#' @param position legend position
#' @param itemsWidth width of the legend items
#' @param itemsHeight height of the legend items
#'
#' @return A list of settings for a legend.
#' @export
amLegend <- function(
  position = "bottom",
  itemsWidth = 20,
  itemsHeight = 20
){
  legend <- list(
    position = match.arg(position, c("top","right","bottom","left")),
    itemsWidth = itemsWidth,
    itemsHeight = itemsHeight
  )
  class(legend) <- "legend"
  legend
}
