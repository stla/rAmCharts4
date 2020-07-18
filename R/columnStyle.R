#' Columns style
#' @description Create a list of settings for the columns of a bar chart.
#'
#' @param color color of the columns
#' @param strokeColor color of the border of the columns
#' @param strokeWidth width of the border of the the columns
#' @param cornerRadius radius of the corners of the columns
#'
#' @return A list of settings for usage in \code{\link{amBarChart}}
#'   or \code{\link{amHorizontalBarChart}}
#' @export
amColumn <- function(
  color = NULL,
  strokeColor = NULL,
  strokeWidth = 4,
  cornerRadius = 8
){
  settings <- list(
    color = validateColor(color),
    strokeColor = validateColor(strokeColor),
    strokeWidth = strokeWidth,
    cornerRadius = cornerRadius
  )
  class(settings) <- "column"
  settings
}
