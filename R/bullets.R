#' Bullets
#' @description Create a list of settings for bullets,
#' their shape and their style.
#'
#' @param color bullet color
#' @param width bullet width
#' @param height bullet height
#' @param radius bullet radius
#' @param strokeColor stroke color of the bullet
#' @param strokeWidth stroke width of the bullet
#' @param direction triangle direction
#' @param rotation triangle rotation
#'
#' @return A list of settings for the bullets.
#' @export
#'
#' @name rAmCharts4-shapes
amTriangle <- function(
  color = NULL,
  width = 10,
  height = 10,
  strokeColor = NULL,
  strokeWidth = 2,
  direction = "top",
  rotation = 0
){
  bullet <- list(
    shape = "triangle",
    color = validateColor(color),
    width = width,
    height = height,
    strokeColor = validateColor(strokeColor),
    strokeWidth = strokeWidth,
    direction = match.arg(direction, c("top", "bottom", "left", "right")),
    rotation = rotation
  )
  class(bullet) <- "bullet"
  bullet
}

#' @rdname rAmCharts4-shapes
#' @export
amCircle <- function(
  color = NULL,
  radius = 6,
  strokeColor = NULL,
  strokeWidth = 2
){
  bullet <- list(
    shape = "circle",
    color = validateColor(color),
    radius = radius,
    strokeColor = validateColor(strokeColor),
    strokeWidth = strokeWidth
  )
  class(bullet) <- bullet
  bullet
}
