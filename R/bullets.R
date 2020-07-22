#' Bullets
#' @description Create a list of settings for bullets,
#' their shape and their style.
#'
#' @param color bullet color
#' @param opacity bullet opacity, a number between 0 and 1
#' @param width bullet width
#' @param height bullet height
#' @param image option to include an image in the bullet, a list created
#'   with \code{\link{amImage}}
#' @param radius circle radius
#' @param strokeColor stroke color of the bullet
#' @param strokeOpacity stroke opacity of the bullet, a number between 0 and 1
#' @param strokeWidth stroke width of the bullet
#' @param direction triangle direction
#' @param rotation rotation angle
#' @param cornerRadius radius of the rectangle corners
#'
#' @return A list of settings for the bullets.
#' @export
#'
#' @name rAmCharts4-shapes
amTriangle <- function(
  color = NULL,
  opacity = 1,
  width = 10,
  height = 10,
  strokeColor = NULL,
  strokeOpacity = 1,
  strokeWidth = 2,
  direction = "top",
  rotation = 0,
  image = NULL
){
  if(!is.null(image) && !"image" %in% class(image)){
    stop("Invalid `image` argument.", call. = TRUE)
  }
  bullet <- list(
    shape = "triangle",
    color = validateColor(color),
    opacity = opacity,
    width = width,
    height = height,
    strokeColor = validateColor(strokeColor),
    strokeOpacity = strokeOpacity,
    strokeWidth = strokeWidth,
    direction = match.arg(direction, c("top", "bottom", "left", "right")),
    rotation = rotation,
    image = image
  )
  class(bullet) <- "bullet"
  bullet
}

#' @rdname rAmCharts4-shapes
#' @export
amCircle <- function(
  color = NULL,
  opacity = 1,
  radius = 6,
  strokeColor = NULL,
  strokeOpacity = 1,
  strokeWidth = 2,
  image = NULL
){
  if(!is.null(image) && !"image" %in% class(image)){
    stop("Invalid `image` argument.", call. = TRUE)
  }
  bullet <- list(
    shape = "circle",
    color = validateColor(color),
    opacity = opacity,
    radius = radius,
    strokeColor = validateColor(strokeColor),
    strokeOpacity = strokeOpacity,
    strokeWidth = strokeWidth,
    image = image
  )
  class(bullet) <- "bullet"
  bullet
}

#' @rdname rAmCharts4-shapes
#' @export
amRectangle <- function(
  color = NULL,
  opacity = 1,
  width = 10,
  height = 10,
  strokeColor = NULL,
  strokeOpacity = 1,
  strokeWidth = 2,
  rotation = 0,
  cornerRadius = 3,
  image = NULL
){
  if(!is.null(image) && !"image" %in% class(image)){
    stop("Invalid `image` argument.", call. = TRUE)
  }
  bullet <- list(
    shape = "rectangle",
    color = validateColor(color),
    opacity = opacity,
    width = width,
    height = height,
    strokeColor = validateColor(strokeColor),
    strokeOpacity = strokeOpacity,
    strokeWidth = strokeWidth,
    rotation = rotation,
    cornerRadius = cornerRadius,
    image = image
  )
  class(bullet) <- "bullet"
  bullet
}
