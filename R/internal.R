#' Called by HTMLWidgets to produce the widget's root element.
#' @noRd
amChart4_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}


randomString <- function(size){
  paste0(
    sample(c(letters,LETTERS,0:9), size, replace = TRUE),
    collapse = ""
  )
}


regex_255 <- "\\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\\s*"

regex_rgb <- paste0("^rgb\\(",
                    "(", regex_255, "),",
                    "(", regex_255, "),",
                    "(", regex_255, ")\\)$")

regex_360 <- "\\s*([012]?[0-9]?[0-9]|3[0-5][0-9]|360)\\s*"

regex_hsl <- paste0("^hsl\\(",
                    "(", regex_360, "),",
                    "(", regex_255, "),",
                    "(", regex_255, ")\\)$")

cssColors <- c("transparent", "aqua", "crimson", "fuchsia", "indigo", "lime",
               "olive", "rebeccapurple", "silver", "teal")

#' @importFrom grDevices col2rgb rgb
#' @noRd
validateColor <- function(color){
  if(is.null(color)) return(NULL)
  if(grepl(regex_rgb, color) || grepl(regex_hsl, color) || color %in% cssColors){
    return(color)
  }
  RGB <- col2rgb(color)[,1]
  rgb(RGB["red"], RGB["green"], RGB["blue"], maxColorValue = 255)
}

`%||%` <- function(x, y){
  if(is.null(x)) y else x
}
