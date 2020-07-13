#' @importFrom shiny registerInputHandler
#' @importFrom jsonlite fromJSON toJSON
#' @noRd
.onLoad <- function(...){
  shiny::registerInputHandler("rAmCharts4.dataframe", function(data, ...) {
    jsonlite::fromJSON(jsonlite::toJSON(data, auto_unbox = TRUE))
  }, force = TRUE)
}
