#' Legend
#' @description Create a list of settings for a legend.
#'
#' @param position legend position
#' @param maxHeight maximum height for a horizontal legend
#'   (\code{position = "bottom"} or \code{position = "top"})
#' @param scrollable whether a vertical legend should be scrollable
#' @param maxWidth maximum width for a vertical legend
#'   (\code{position = "left"} or \code{position = "right"}); set it to
#'   \code{NULL} for no limit
#' @param itemsWidth width of the legend items
#' @param itemsHeight height of the legend items
#'
#' @return A list of settings for a legend.
#' @export
amLegend <- function(
  position = "bottom",
  maxHeight = NULL,
  scrollable = FALSE,
  maxWidth = 220,
  itemsWidth = 20,
  itemsHeight = 20
){
  legend <- list(
    position = match.arg(position, c("top","right","bottom","left")),
    maxHeight = maxHeight,
    scrollable = scrollable,
    maxWidth = maxWidth,
    itemsWidth = itemsWidth,
    itemsHeight = itemsHeight
  )
  legend <- Filter(Negate(is.null), legend)
  class(legend) <- "legend"
  legend
}
