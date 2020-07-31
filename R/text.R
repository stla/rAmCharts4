#' Text
#' @description Create a list of settings for a text.
#'
#' @param text the text to display, a character string
#' @param color color of the text; it can be given by the name of a R color,
#'   the name of a CSS color, e.g. \code{"crimson"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @param fontSize size of the text
#' @param fontWeight font weight of the text, it can be \code{"normal"},
#'   \code{"bold"}, \code{"bolder"}, \code{"lighter"}, or a number in
#'   \code{seq(100, 900, by = 100)}
#' @param fontFamily font family
#'
#' @return A list of settings for a text.
#' @export
#'
#' @note There is no option for the font style; you can get an italicized
#'   text by entering \code{text = "[font-style:italic]Your text[/]"}.
amText <- function(
  text,
  color = NULL,
  fontSize = NULL,
  fontWeight = "normal",
  fontFamily = NULL
){
  txt <- list(
    text = text,
    color = validateColor(color),
    fontSize = fontSize,
    fontWeight = match.arg(
      as.character(fontWeight),
      c("normal", "bold", "bolder", "lighter", seq(100L, 900L, by = 100L))
    ),
    fontFamily = fontFamily
  )
  class(txt) <- "text"
  txt
}
