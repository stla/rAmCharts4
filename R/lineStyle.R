#' Line style
#' @description Create a list of settings for a line.
#'
#' @param color line color
#' @param opacity line opacity, a number between 0 and 1
#' @param width line width
#' @param dash string defining a dashed/dotted line; see
#'   \href{https://www.amcharts.com/docs/v4/tutorials/dotted-and-dashed-lines/#Dasharray_values}{Dotted and dashed lines}
#' @param tensionX,tensionY parameters for the smoothing; see
#'   \href{https://www.amcharts.com/docs/v4/chart-types/xy-chart/#Smoothed_lines}{Smoothed lines}
#'   for the meaning of these parameters
#'
#' @return A list of settings for a line.
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
#'
#' @export
amLine <- function(
  color = NULL,
  opacity = 1,
  width = 3,
  dash = NULL,
  tensionX = NULL,
  tensionY = NULL
){
  if(!is.null(tensionX)){
    stopifnot(tensionX >= 0 && tensionX <= 1)
  }
  if(!is.null(tensionY)){
    stopifnot(tensionY >= 0 && tensionY <= 1)
  }
  settings <- list(
    color = validateColor(color),
    opacity = opacity,
    width = width,
    dash = dash,
    tensionX = tensionX,
    tensionY = tensionY
  )
  class(settings) <- "lineStyle"
  settings
}
