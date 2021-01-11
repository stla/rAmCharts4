#' HTML widget displaying a pie chart
#' @description Create a HTML widget displaying a pie chart.
#'
#' @param data a dataframe
#' @param category name of the column of \code{data} to be used as the
#'   category
#' @param value name of the column of \code{data} to be used as the value
#' @param innerRadius the inner radius of the pie chart in percent
#' @param threeD whether to render a 3D pie chart
#' @param depth for a 3D chart, this parameter controls the height of the
#'   slices
#' @param colorStep the step in the color palette
#' @param variableRadius whether to render slices with variable radius
#' @param variableDepth for a 3D chart, whether to render slices with
#'   variable depth
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @param theme theme, \code{NULL} or one of \code{"dataviz"},
#' \code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
#' \code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
#' \code{"microchart"}
#' @param backgroundColor a color for the chart background; it can be
#'   given by the name of a R color, the name of a CSS color, e.g.
#'   \code{"lime"} or \code{"olive"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
#' @param legend either a logical value, whether to display the legend, or
#'   a list of settings for the legend created with \code{\link{amLegend}}
#' @param caption \code{NULL} or \code{FALSE} for no caption, a formatted
#'   text created with \code{\link{amText}}, or a list with two fields:
#'   \code{text}, a list created with \code{\link{amText}}, and \code{align},
#'   can be \code{"left"}, \code{"right"} or \code{"center"}
#' @param image option to include an image at a corner of the chart;
#'   \code{NULL} or \code{FALSE} for no image, otherwise a named list with four
#'   possible fields: the field \code{image} (required) is a list created with
#'   \code{\link{amImage}},
#'   the field \code{position} can be \code{"topleft"}, \code{"topright"},
#'   \code{"bottomleft"} or \code{"bottomright"}, the field \code{hjust}
#'   defines the horizontal adjustment, and the field \code{vjust} defines
#'   the vertical adjustment
#' @param width the width of the chart, e.g. \code{"600px"} or \code{"80\%"};
#' ignored if the chart is displayed in Shiny, in which case the width is
#' given in \code{\link{amChart4Output}}
#' @param height the height of the chart, e.g. \code{"400px"};
#' ignored if the chart is displayed in Shiny, in which case the height is
#' given in \code{\link{amChart4Output}}
#' @param export logical, whether to enable the export menu
#' @param chartId a HTML id for the chart
#' @param elementId a HTML id for the container of the chart; ignored if the
#' chart is displayed in Shiny, in which case the id is given by the Shiny id
#'
#' @import htmlwidgets
#' @importFrom shiny validateCssUnit
#' @importFrom reactR component reactMarkup
#' @importFrom lubridate is.Date is.POSIXt
#' @export
#'
#' @examples library(rAmCharts4)
#' dat <- data.frame(
#'   country = c(
#'     "Lithuania", "Czechia", "Ireland", "Germany", "Australia", "Austria"
#'   ),
#'   value = c(260, 230, 200, 165, 139, 128)
#' )
#' amPieChart(
#'   data = dat,
#'   category = "country",
#'   value = "value",
#'   variableRadius = TRUE
#' )
#'
#' # shiny app demonstrating the options ####
#' library(rAmCharts4)
#' library(shiny)
#'
#' dat <- data.frame(
#'   country = c(
#'     "Lithuania", "Czechia", "Ireland", "Germany", "Australia", "Austria"
#'   ),
#'   value = c(260, 230, 200, 165, 139, 128)
#' )
#'
#' ui <- fluidPage(
#'   sidebarLayout(
#'     sidebarPanel(
#'       sliderInput(
#'         "innerRadius", "Inner radius", min = 0, max = 60, value = 0, step = 20
#'       ),
#'       checkboxInput("variableRadius", "Variable radius", TRUE),
#'       checkboxInput("threeD", "3D"),
#'       conditionalPanel(
#'         "input.threeD",
#'         checkboxInput("variableDepth", "Variable depth")
#'       )
#'     ),
#'     mainPanel(
#'       amChart4Output("piechart", height = "500px")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session){
#'
#'   piechart <- reactive({
#'     amPieChart(
#'       data = dat,
#'       category = "country",
#'       value = "value",
#'       innerRadius = input[["innerRadius"]],
#'       threeD = input[["threeD"]],
#'       variableDepth = input[["variableDepth"]],
#'       depth = ifelse(input[["variableDepth"]], 300, 10),
#'       variableRadius = input[["variableRadius"]],
#'       theme = "dark"
#'     )
#'   })
#'
#'   output[["piechart"]] <- renderAmChart4({
#'     piechart()
#'   })
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
amPieChart <- function(
  data,
  category,
  value,
  innerRadius = 0,
  threeD = FALSE,
  depth = ifelse(variableDepth, 100, 10),
  colorStep = 3,
  variableRadius = FALSE,
  variableDepth = FALSE,
  chartTitle = NULL,
  theme = NULL,
  backgroundColor = NULL,
  legend = TRUE,
  caption = NULL,
  image = NULL,
  width = NULL,
  height = NULL,
  export = FALSE,
  chartId = NULL,
  elementId = NULL
) {

  if(!category %in% names(data)){
    stop("Invalid `category` argument: not found in `data`.", call. = TRUE)
  }

  if(!value %in% names(data)){
    stop("Invalid `value` argument: not found in `data`.", call. = TRUE)
  }

  if(is.character(chartTitle)){
    chartTitle <- list(
      text = amText(
        text = chartTitle, color = NULL, fontSize = 22,
        fontWeight = "bold", fontFamily = "Tahoma"
      ),
      align = "left"
    )
  }else if("text" %in% class(chartTitle)){
    chartTitle <- list(text = chartTitle, align = "left")
  }

  if(is.character(caption)){
    caption <- list(text = amText(caption), align = "right")
  }else if("text" %in% class(caption)){
    caption <- list(text = caption, align = "right")
  }

  if(!(is.null(image) || isFALSE(image))){
    if(!is.list(image)){
      if(!"image" %in% class(image)){
        stop("Invalid `image` argument.", call. = TRUE)
      }else{
        image <- list(image = image)
      }
    }else{
      if(!"image" %in% names(image) || !"image" %in% class(image[["image"]])){
        stop("Invalid `image` argument.", call. = TRUE)
      }
    }
  }

  if(is.null(width)){
    width <- "100%"
  }else{
    width <- validateCssUnit(width)
  }

  height <- validateCssUnit(height)
  if(is.null(height)){
    if(grepl("^\\d", width) && !grepl("%$", width)){
      height <- sprintf("calc(%s * 9 / 16)", width)
    }else{
      height <- "400px"
    }
  }

  if(is.null(chartId)){
    chartId <- paste0("piechart-", randomString(15))
  }

  if(is.null(legend)){
    legend <- TRUE
  }
  if(isTRUE(legend)){
    legend <- amLegend(
      position = "bottom",
      itemsWidth = 20,
      itemsHeight = 20
    )
  }

  # describe a React component to send to the browser for rendering.
  component <- reactR::component(
    "AmPieChart",
    list(
      data = data,
      category = category,
      value = value,
      innerRadius = innerRadius,
      threeD = threeD,
      depth = depth,
      colorStep = colorStep,
      variableRadius = variableRadius,
      variableDepth = variableDepth,
      chartTitle = chartTitle,
      theme = theme,
      backgroundColor = validateColor(backgroundColor),
      caption = caption,
      legend = legend,
      image = image,
      width = width,
      height = height,
      export = export,
      chartId = chartId,
      shinyId = elementId
    )
  )
  # create widget
  htmlwidgets::createWidget(
    name = 'amChart4',
    reactR::reactMarkup(component),
    width = "auto",
    height = "auto",
    package = 'rAmCharts4',
    elementId = elementId
  )
}

