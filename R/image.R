#' @importFrom tools file_ext
NULL

#' Image
#' @description Create a list of settings for an image.
#'
#' @param href a link to an image file or a base64 string representing an
#'   image; you can get such a string with \code{\link{tinyIcon}}, or
#'   you can create it from a file with \code{base64enc::dataURI}; this option
#'   can also be a string of the form \code{"inData:DATAFIELD"} where
#'   \code{DATAFIELD} is the name of a column of the data - this is useful to
#'   have different images in the bullets
#' @param width,height dimensions of the image
#' @param opacity opacity of the image, a number between 0 and 1
#'
#' @return A list of settings for an image.
#' @export
amImage <- function(
  href,
  width,
  height,
  opacity = 1
){
  isURL <- grepl("^http", href) &&
    grepl("(\\.svg|\\.gif|\\.png|\\.bmp|\\.gif|\\.jpe?g|\\.tiff?)$", href,
          ignore.case = TRUE)
  isBASE64 <- grepl("^data:image", href)
  inData <- grepl("^inData", href)
  if(!(isURL || isBASE64 || inData)){
    stop("Invalid `href` value.", call. = TRUE)
  }
  image <- list(
    href = href,
    width = width,
    height = height,
    opacity = opacity
  )
  class(image) <- "image"
  image
}
