#' @importFrom shiny registerInputHandler
#' @importFrom jsonlite fromJSON toJSON
#' @noRd
.onLoad <- function(...){

  shiny::registerInputHandler("rAmCharts4.dataframe", function(data, ...) {
    jsonlite::fromJSON(jsonlite::toJSON(data, auto_unbox = TRUE))
  }, force = TRUE)

  shiny::registerInputHandler("rAmCharts4.dataframeWithDate", function(data, ...) {
    dat <- jsonlite::fromJSON(jsonlite::toJSON(data[["data"]], auto_unbox = TRUE))
    dat[[data[["date"]]]] <- as.Date(dat[[data[["date"]]]]) + 1
    dat
  }, force = TRUE)

  shiny::registerInputHandler("rAmCharts4.lineChange", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      res <- try(as.Date(data[["x"]]), silent = TRUE)
      if ("try-error" %in% class(res)) {
        warning("Failed to parse date!")
        data
      } else {
        data[["x"]] <- res + 1
        data
      }
    }
  }, force = TRUE)

}
