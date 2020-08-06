#' Button
#' @description Create a list of settings for a button.
#'
#' @param label label of the button, a character string or a list created with
#'   \code{\link{amText}} for a formatted label
#' @param color button color
#' @param position the vertical position of the button: \code{0} for bottom,
#'   \code{1} for top
#' @param marginRight right margin in pixels
#'
#' @return A list of settings for a button.
#' @export
amButton <- function(
  label,
  color = NULL,
  position = 0.9,
  marginRight = 10
){
  if(is.character(label)){
    label <- amText(text = label)
  }
  settings <- list(
    label = label,
    color = validateColor(color),
    position = position,
    marginRight = marginRight
  )
  class(settings) <- "button"
  settings
}
