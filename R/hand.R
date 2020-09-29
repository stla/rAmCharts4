#' Gauge hand
#' @description Create a list of settings for the hand of a gauge chart.
#'
#' @param innerRadius inner radius of the hand, given as a percentage
#' @param width width of the base of the hand in pixels, a positive number
#' @param color color of the hand
#' @param strokeColor stroke color of the hand
#'
#' @return A list of settings for the hand of a gauge chart.
#' @export
amHand <- function(innerRadius, width, color, strokeColor){
  stopifnot(is.numeric(width) && length(width) == 1L && width > 0)
  hand <- list(
    innerRadius = max(min(innerRadius, 100), 0),
    width = width,
    color = validateColor(color),
    strokeColor = validateColor(strokeColor)
  )
  class(hand) <- "hand"
  hand
}
