#' Icons
#' @description Icons for usage in \code{\link{amImage}}.
#'
#' @param icon name of an icon; \code{tinyIcons()} returns the list of
#'   available icons, and \code{shinyAppTinyIcons()} runs a Shiny app which
#'   displays the available icons
#'
#' @return A base64 string that can be used in the \code{href} argument of
#'   \code{\link{amImage}}.
#'
#' @importFrom base64enc dataURI
#' @importFrom tools file_path_sans_ext
#' @import shiny
#' @export
#' @name tinyIcon
tinyIcon <- function(icon){
  svg <- system.file("super-tiny-icons", "images", "svg", paste0(icon, ".svg"),
                     package = "rAmCharts4", mustWork = TRUE)
  base64enc::dataURI(file = svg, mime = "image/svg+xml")
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
