#' Columns style
#' @description Create a list of settings for the columns of a bar chart.
#'
#' @param color color of the columns; this can be an
#'   \link[rAmCharts4:amAdapterFromVector]{adapter}
#' @param opacity opacity of the columns, a number between 0 and 1
#' @param strokeColor color of the border of the columns; this can be an
#'   \link[rAmCharts4:amAdapterFromVector]{adapter}
#' @param strokeWidth width of the border of the the columns
#' @param cornerRadius radius of the corners of the columns
#'
#' @return A list of settings for usage in \code{\link{amBarChart}}
#'   or \code{\link{amHorizontalBarChart}}
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
    strokeColorAdapter = if(strokeColorAdapter) strokeColorAdapter,
    strokeWidth = strokeWidth,
    cornerRadius = cornerRadius
  )
  class(settings) <- "column"
  settings
}
