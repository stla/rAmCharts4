#' Segment style
#' @description Create a list of settings for a segment.
#'
#' @param color color of the segment; this can be a
#'   \link[rAmCharts4:amColorAdapterFromVector]{color adapter}
#' @param width width of the segment
#'
#' @return A list of settings for a segment.
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"lime"} or \code{"indigo"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
#'
#' @export
amSegment <- function(color = NULL, width = 1){
  colorAdapter <- class(color) == "JS_EVAL"
  segment <- list(
    color = if(!colorAdapter) validateColor(color),
    colorAdapter = if(colorAdapter) color,
    width = width
  )
  class(segment) <- "segment"
  segment
}
