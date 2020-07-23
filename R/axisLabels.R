#' Axis labels
#' @description Create a list of settings for the labels of an axis.
#'
#' @param color color of the labels
#' @param fontSize font size of the labels
#' @param rotation rotation angle
#' @param formatter a formatting string for the labels; see
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{Formatting Numbers}
#'   and
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-date-time/}{Formatting Date and Time}
#'
#' @return A list of settings for the labels of an axis.
#' @export
amAxisLabels <- function(
  color = NULL,
  fontSize = 18,
  rotation = 0,
  formatter = NULL
){
  labels <- list(
    color = validateColor(color),
    fontSize = fontSize,
    rotation = rotation,
    formatter = formatter
  )
  class(labels) <- "axisLabels"
  labels
}
