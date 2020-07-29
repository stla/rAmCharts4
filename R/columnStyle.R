#' Columns style
#' @description Create a list of settings for the columns of a bar chart.
#'
#' @param color color of the columns; this can be a
#'   \link[rAmCharts4:amColorAdapterFromVector]{color adapter}
#' @param opacity opacity of the columns, a number between 0 and 1
#' @param strokeColor color of the border of the columns; this can be a
#'   \link[rAmCharts4:amColorAdapterFromVector]{color adapter}
#' @param strokeWidth width of the border of the columns
#' @param cornerRadius radius of the corners of the columns
#'
#' @return A list of settings for usage in \code{\link{amBarChart}}
#'   or \code{\link{amHorizontalBarChart}}
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
#'
#' @export
amColumn <- function(
  color = NULL,
  opacity = NULL,
  strokeColor = NULL,
  strokeWidth = 4,
  cornerRadius = 8
){
  colorAdapter <- class(color) == "JS_EVAL"
  strokeColorAdapter <- class(strokeColor) == "JS_EVAL"
  settings <- list(
    color = if(!colorAdapter) validateColor(color),
    colorAdapter = if(colorAdapter) color,
    opacity = opacity,
    strokeColor = if(!strokeColorAdapter) validateColor(strokeColor),
    strokeColorAdapter = if(strokeColorAdapter) strokeColor,
    strokeWidth = strokeWidth,
    cornerRadius = cornerRadius
  )
  class(settings) <- "column"
  settings
}
