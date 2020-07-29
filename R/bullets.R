#' Bullets
#' @description Create a list of settings for bullets,
#' their shape and their style.
#'
#' @param color bullet color; this can be a
#'   \link[rAmCharts4:amColorAdapterFromVector]{color adapter}
#' @param opacity bullet opacity, a number between 0 and 1
#' @param width bullet width
#' @param height bullet height
#' @param image option to include an image in the bullet, a list created
#'   with \code{\link{amImage}}
#' @param radius circle radius
#' @param strokeColor stroke color of the bullet; this can be a
#'   \link[rAmCharts4:amColorAdapterFromVector]{color adapter}
#' @param strokeOpacity stroke opacity of the bullet, a number between 0 and 1
#' @param strokeWidth stroke width of the bullet
#' @param direction triangle direction
#' @param rotation rotation angle
#' @param cornerRadius radius of the rectangle corners
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
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
  colorAdapter <- class(color) == "JS_EVAL"
  strokeColorAdapter <- class(strokeColor) == "JS_EVAL"
  bullet <- list(
    shape = "triangle",
    color = if(!colorAdapter) validateColor(color),
    colorAdapter = if(colorAdapter) color,
    opacity = opacity,
    width = width,
    height = height,
    strokeColor = if(!strokeColorAdapter) validateColor(strokeColor),
    strokeColorAdapter = if(strokeColorAdapter) strokeColor,
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
  colorAdapter <- class(color) == "JS_EVAL"
  strokeColorAdapter <- class(strokeColor) == "JS_EVAL"
  bullet <- list(
    shape = "circle",
    color = if(!colorAdapter) validateColor(color),
    colorAdapter = if(colorAdapter) color,
    opacity = opacity,
    radius = radius,
    strokeColor = if(!strokeColorAdapter) validateColor(strokeColor),
    strokeColorAdapter = if(strokeColorAdapter) strokeColor,
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
  colorAdapter <- class(color) == "JS_EVAL"
  strokeColorAdapter <- class(strokeColor) == "JS_EVAL"
  bullet <- list(
    shape = "rectangle",
    color = if(!colorAdapter) validateColor(color),
    colorAdapter = if(colorAdapter) color,
    opacity = opacity,
    width = width,
    height = height,
    strokeColor = if(!strokeColorAdapter) validateColor(strokeColor),
    strokeColorAdapter = if(strokeColorAdapter) strokeColor,
    strokeOpacity = strokeOpacity,
    strokeWidth = strokeWidth,
    rotation = rotation,
    cornerRadius = cornerRadius,
    image = image
  )
  class(bullet) <- "bullet"
  bullet
}
