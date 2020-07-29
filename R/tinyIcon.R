#' Icons
#' @description Icons for usage in \code{\link{amImage}}.
#'
#' @param icon name of an icon; \code{tinyIcons()} returns the list of
#'   available icons, and \code{shinyAppTinyIcons()} runs a Shiny app which
#'   displays the available icons
#' @param backgroundColor background color of the icon
#'   (possibly \code{"transparent"})
#'
#' @return A base64 string that can be used in the \code{href} argument of
#'   \code{\link{amImage}}.
#'
#' @note A color can be given by the name of a R color, the name of a CSS
#'   color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}.
#'
#' @importFrom base64enc dataURI
#' @importFrom tools file_path_sans_ext
#' @import shiny xml2
#' @export
#' @name tinyIcon
tinyIcon <- function(icon, backgroundColor = NULL){
  svg <- system.file("super-tiny-icons", "images", "svg", paste0(icon, ".svg"),
                     package = "rAmCharts4", mustWork = TRUE)
  if(is.null(backgroundColor)){
    base64enc::dataURI(file = svg, mime = "image/svg+xml")
  }else{
    backgroundColor <- validateColor(backgroundColor)
    XML <- read_xml(svg)
    xml_set_attr(xml_child(XML), "fill", backgroundColor)
    base64enc::dataURI(data = charToRaw(as.character(XML)),
                       mime = "image/svg+xml")
  }
}

#' @rdname tinyIcon
#' @export
tinyIcons <- function(){
  svgFolder <- system.file("super-tiny-icons", "images", "svg",
                           package = "rAmCharts4", mustWork = TRUE)
  tools::file_path_sans_ext(list.files(svgFolder))
}

#' @rdname tinyIcon
#' @export
shinyAppTinyIcons <- function(){
  shinyApp(
    ui = fluidPage(
      br(),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "icon", "Select an icon", choices = tinyIcons()
          )
        ),
        mainPanel(
          htmlOutput("icon")
        )
      )
    ),
    server = function(input, output){
      output[["icon"]] <- renderUI({
        tags$img(
          src = tinyIcon(input[["icon"]]),
          width = 200, height = 200
        )
      })
    }
  )
}
