#' Axis labels
#' @description Create a list of settings for the labels of an axis.
#'
#' @param color color of the labels
#' @param fontSize size of the labels
#' @param fontWeight font weight of the labels, it can be \code{"normal"},
#'   \code{"bold"}, \code{"bolder"}, \code{"lighter"}, or a number in
#'   \code{seq(100, 900, by = 100)}
#' @param fontFamily font family of the labels
#' @param rotation rotation angle
#' @param formatter this option defines the format of the axis labels;
#'   this should be a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-numbers/}{number formatting string}
#'   for a numeric axis, and a list created with
#'   \code{\link{amDateAxisFormatter}} for a date axis
#' @param radius radius in percentage
#' @param relativeRotation relative rotation angle
#'
#' @return A list of settings for the labels of an axis.
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"silver"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
#'
#' @export
#' @name amAxisLabels
amAxisLabels <- function(
  color = NULL,
  fontSize = 18,
  fontWeight = "normal",
  fontFamily = NULL,
  rotation = 0,
  formatter = NULL
){
  labels <- list(
    color = validateColor(color),
    fontSize = fontSize,
    fontWeight = match.arg(
      as.character(fontWeight),
      c("normal", "bold", "bolder", "lighter", seq(100L, 900L, by = 100L))
    ),
    fontFamily = fontFamily,
    rotation = rotation,
    formatter = formatter
  )
  class(labels) <- "axisLabels"
  labels
}

#' @rdname amAxisLabels
#' @export
amAxisLabelsCircular <- function(
  color = NULL,
  fontSize = 14,
  fontWeight = "normal",
  fontFamily = NULL,
  radius = NULL,
  relativeRotation = NULL
){
  labels <- list(
    color = validateColor(color),
    fontSize = fontSize,
    fontWeight = match.arg(
      as.character(fontWeight),
      c("normal", "bold", "bolder", "lighter", seq(100L, 900L, by = 100L))
    ),
    fontFamily = fontFamily,
    radius = radius,
    relativeRotation = relativeRotation
  )
  class(labels) <- "axisLabelsCircular"
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


#' Axis breaks
#' @description Create an object defining the breaks on an axis.
#'
#' @param values positions of the breaks, a vector of values; for a date axis,
#'   this must be a vector of dates
#' @param labels if \code{values} is given, the labels of the breaks; if
#'   \code{NULL}, the labels are set to the values
#' @param interval for equally spaced breaks, the number of pixels between two
#'   consecutive breaks; ignored if \code{values} is given
#' @param timeInterval for equally spaced breaks on a date axis, this option
#'   defines the interval between two consecutive breaks; it must be a string
#'   like \code{"1 day"}, \code{"7 days"}, \code{"1 week"}, \code{"2 months"},
#'   ...; ignored if \code{values} or \code{interval} is given
#'
#' @importFrom stringr str_extract
#' @importFrom lubridate is.Date is.POSIXt
#' @export
amAxisBreaks <- function(
  values = NULL,
  labels = NULL,
  interval = NULL,
  timeInterval = NULL
){
  if(!is.null(values)){
    if(lubridate::is.Date(values) || lubridate::is.POSIXt(values)){
      values <- format(values, "%Y-%m-%d") # 1000 * as.integer(as.POSIXct(values)) #
    }
    data.frame(
      value = values,
      label = as.character(labels %||% NA)
    )
  }else if(!is.null(interval)){
    interval
  }else if(!is.null(timeInterval)){
    unit <- stringr::str_extract(timeInterval, "(day|week|month|year)")
    count <- as.integer(stringr::str_extract(timeInterval, "^\\d+"))
    if(is.na(unit) || is.na(count)){
      stop("Invalid `timeInterval` argument.", call. = TRUE)
    }
    list(
      list(timeUnit = unit, count = count)
    )
  }
}
