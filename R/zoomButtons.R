#' @title Zoom buttons
#' @description Zoom buttons.
#'
#' @param halign \code{"left"} or \code{"right"}
#' @param valign \code{"top"} or \code{"bottom"}
#' @param marginH horizontal margin
#' @param marginV vertical margin
#' @param zoomFactor zoom factor
#'
#' @return A list of parameters for zoom buttons, for usage in
#'   \code{\link{amLineChart}} or \code{\link{amScatterChart}}
#' @export
amZoomButtons <- function(
  halign = "left", valign = "top",
  marginH = 5, marginV = 5, zoomFactor = 0.2
){
  out <- list(
    halign = halign,
    valign = valign,
    marginH = marginH,
    marginV = marginV,
    zoomFactor = zoomFactor
  )
  class(out) <- "zoomButtons"
  out
}
