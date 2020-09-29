#' Font
#' @description Create a list of settings for a font.
#'
#' @param fontSize font size, must be given as a character string like
#'   \code{"10px"} or \code{"2em"}, or a numeric value, the font size in pixels
#' @param fontWeight font weight, it can be \code{"normal"},
#'   \code{"bold"}, \code{"bolder"}, \code{"lighter"}, or a number in
#'   \code{seq(100, 900, by = 100)}
#' @param fontFamily font family
#'
#' @return A list of settings for a font.
#' @importFrom htmltools validateCssUnit
#' @export
#'
#' @note There is no option for the font style.
amFont <- function(
  fontSize = NULL,
  fontWeight = "normal",
  fontFamily = NULL
){
  font <- list(
    fontSize = validateCssUnit(fontSize),
    fontWeight = match.arg(
      as.character(fontWeight),
      c("normal", "bold", "bolder", "lighter", seq(100L, 900L, by = 100L))
    ),
    fontFamily = fontFamily
  )
  class(font) <- "font"
  font
}
