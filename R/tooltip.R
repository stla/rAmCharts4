#' Tooltip
#' @description Create list of settings for a tooltip.
#'
#' @param text text to display in the tooltip; this should be a
#'   \href{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-strings/}{formatting string}
#' @param textColor text color
#' @param textAlign alignement of the text, can be \code{"start"},
#'   \code{"middle"}, or \code{"end"}
#' @param backgroundColor background color of the tooltip
#' @param backgroundOpacity background opacity
#' @param borderColor color of the border of the tooltip
#' @param borderWidth width of the border of the tooltip
#' @param pointerLength length of the pointer
#' @param scale scale factor
#' @param auto logical, whether to use automatic background color and text color
#'
#' @return A list of settings for a tooltip.
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
#'
#' @export
amTooltip <- function(
  text,
  textColor = NULL,
  textAlign = "middle",
  backgroundColor = NULL,
  backgroundOpacity = 0.6,
  borderColor = NULL,
  borderWidth = 2,
  pointerLength = 10,
  scale = 1,
  auto = FALSE
){
  settings <- list(
    text = ifelse(missing(text), "_missing", text),
    textColor = validateColor(textColor),
    textAlign = match.arg(textAlign, c("start", "middle", "end")),
    backgroundColor = validateColor(backgroundColor),
    backgroundOpacity = backgroundOpacity,
    borderColor = validateColor(borderColor),
    borderWidth = borderWidth,
    pointerLength = pointerLength,
    scale = scale,
    auto = auto
  )
  class(settings) <- "tooltip"
  settings
}
