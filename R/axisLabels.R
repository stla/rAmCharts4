#' Axis labels
#' @description Create a list of settings for the labels of an axis.
#'
#' @param color color of the labels
#' @param fontSize font size of the labels
#' @param rotation rotation angle
#' @param formatter this option defines the format of the axis labels;
#'   this should be a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string}
#'   for a numeric axis, and a list created with
#'   \code{\link{amDateAxisFormatter}} for a date axis
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

#' Date axis formatter
#' @description Create a list of settings for formatting the labels of a
#'   date axis, to be passed on to the \code{formatter} argument of
#'   \code{\link{amAxisLabels}}.
#'
#' @param day,week,month vectors of length two, the first component is a
#'   formatting string for the dates within a period, and the second one
#'   is a formatting string for the dates at a period change; see
#'   \href{https://www.amcharts.com/docs/v4/concepts/axes/date-axis/#Formatting_date_and_time}{Formatting date and time}
#'
#' @return A list of settings for formatting the labels of a date axis.
#' @export
amDateAxisFormatter <- function(
  day = c("dd", "MMM dd"),
  week = c("dd", "MMM dd"),
  month = c("MMM", "MMM yyyy")
){
  list(
    day = if(length(day) == 2L) as.list(day) else list(day, NULL),
    week = if(length(week) == 2L) as.list(week) else list(week, NULL),
    month = if(length(month) == 2L) as.list(month) else list(month, NULL)
  )
}
