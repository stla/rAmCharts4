#' Tooltip
#' @description Create list of settings for a tooltip.
#'
#' @param text text to display in the tooltip; this can be a formatted string:
#' \url{https://www.amcharts.com/docs/v4/concepts/formatters/formatting-strings/}
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
