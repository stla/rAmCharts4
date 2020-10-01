#' HTML widget displaying a gauge chart
#' @description Create a HTML widget displaying a gauge chart.
#'
#' @param score gauge value, a number between \code{minScore} and
#'   \code{maxScore}
#' @param minScore minimal score
#' @param maxScore maximal score
#' @param scorePrecision an integer, the number of decimals of the score
#'   to be displayed
#' @param gradingData data for the gauge, a dataframe with three required
#'   columns: \code{label}, \code{lowScore}, and \code{highScore}, and an
#'   optional column \code{color}; if the column \code{color} is not present,
#'   then the colors will be derived from the theme
#' @param innerRadius inner radius of the gauge given as a percentage,
#'   between \code{0} (the gauge has no width) and \code{100} (the gauge is
#'   a semi-disk)
#' @param labelsRadius radius for the labels given as a percentage; use the
#'   default value to get centered labels
#' @param axisLabelsRadius radius for the axis labels given as a percentage
#' @param chartFontSize reference font size, a numeric value, the font size in
#'   pixels; this font size has an effect only if you use the relative CSS unit
#'   \code{em} for other font sizes
#' @param labelsFont a list of settings for the font of the labels created with
#'   \code{\link{amFont}}, but the font size must be given in pixels or in
#'   \code{em} CSS units (no other units are accepted)
#' @param axisLabelsFont a list of settings for the font of the axis labels
#'   created with \code{\link{amFont}}
#' @param scoreFont a list of settings for the font of the score created with
#'   \code{\link{amFont}}
#' @param scoreLabelFont a list of settings for the font of the score label
#'   created with \code{\link{amFont}}
#' @param hand a list of settings for the hand of the gauge created with
#'   \code{\link{amHand}}
#' @param gridLines a list of settings for the grid lines created with
#'   \code{\link{amLine}}, or a logical value: \code{FALSE} for no grid lines,
#'   \code{TRUE} for default grid lines
#' @param chartTitle chart title, it can be \code{NULL} or \code{FALSE} for no
#'   title, a character string,
#'   a list of settings created with \code{\link{amText}}, or a list with two
#'   fields: \code{text}, a list of settings created with \code{\link{amText}},
#'   and \code{align}, can be \code{"left"}, \code{"right"} or \code{"center"}
#' @param theme theme, \code{NULL} or one of \code{"dataviz"},
#'   \code{"material"}, \code{"kelly"}, \code{"dark"}, \code{"moonrisekingdom"},
#'   \code{"frozen"}, \code{"spiritedaway"}, \code{"patterns"},
#'   \code{"microchart"}
#' @param backgroundColor a color for the chart background; it can be given by
#'   the name of a R color, the name of a CSS
#'   color, e.g. \code{"aqua"} or \code{"indigo"}, an HEX code like
#'   \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
#'   like \code{"hsl(360,11,255)"}
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
#'   ignored if the chart is displayed in Shiny, in which case the width is
#'   given in \code{\link{amChart4Output}}
#' @param height the height of the chart, e.g. \code{"400px"};
#'   ignored if the chart is displayed in Shiny, in which case the height is
#'   given in \code{\link{amChart4Output}}
#' @param export logical, whether to enable the export menu
#' @param chartId a HTML id for the chart
#' @param elementId a HTML id for the container of the chart; ignored if the
#'   chart is displayed in Shiny, in which case the id is given by the Shiny id
#'
#' @note In Shiny, you can change the score of a gauge chart with the help of
#'   \code{\link{updateAmGaugeChart}}.
#'
#' @import htmlwidgets
#' @importFrom htmltools validateCssUnit
#' @export
#'
#' @examples library(rAmCharts4)
#'
#' gradingData <- data.frame(
#'   label = c("Slow", "Moderate", "Fast"),
#'   color = c("blue", "green", "red"),
#'   lowScore = c(0, 100/3, 200/3),
#'   highScore = c(100/3, 200/3, 100)
#' )
#'
#' amGaugeChart(
#'   score = 40, minScore = 0, maxScore = 100, gradingData = gradingData
#' )
amGaugeChart <- function(
  score,
  minScore,
  maxScore,
  scorePrecision = 0,
  gradingData,
  innerRadius = 70,
  labelsRadius = (100-innerRadius)/2,
  axisLabelsRadius = 19,
  chartFontSize = 11,
  labelsFont = amFont(fontSize = "2em", fontWeight = "bold"),
  axisLabelsFont = amFont(fontSize = "1.2em"),
  scoreFont = amFont(fontSize = "6em"),
  scoreLabelFont = amFont(fontSize = "2em"),
  hand = amHand(
    innerRadius = 45, width = 8, color = "slategray", strokeColor = "black"
  ),
  gridLines = FALSE,
  chartTitle = NULL,
  theme = NULL,
  backgroundColor = NULL,
  caption = NULL,
  image = NULL,
  width = NULL,
  height = NULL,
  export = FALSE,
  chartId = NULL,
  elementId = NULL
) {

  stopifnot(minScore <= score && score <= maxScore)

  stopifnot(isPositiveInteger(scorePrecision))

  if(!all(is.element(
    c("label", "lowScore", "highScore"), names(gradingData))
  )){
    stop("Invalid `gradingData` argument.", call. = TRUE)
  }

  stopifnot(all(gradingData[["lowScore"]] < gradingData[["highScore"]]))

  if("color" %in% names(gradingData)){
    gradingData[["color"]] <-
      vapply(gradingData[["color"]], validateColor, FUN.VALUE = character(1L))
  }

  stopifnot(is.numeric(chartFontSize) && chartFontSize > 0)

  if(!grepl("(px$|em$)", labelsFont[["fontSize"]])){
    stop("Invalid `labelsFont` argument.")
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
    chartId <- paste0("gaugechart-", randomString(15))
  }

  # describe a React component to send to the browser for rendering.
  innerRadius <- max(min(innerRadius, 100), 0)
  component <- reactR::component(
    "AmGaugeChart",
    list(
      score = score,
      minScore = minScore,
      maxScore = maxScore,
      scorePrecision = scorePrecision,
      gradingData = gradingData,
      innerRadius = innerRadius,
      labelsRadius = max(min(labelsRadius, 100), 0),
      axisLabelsRadius = max(min(axisLabelsRadius, 100), 0),
      chartFontSize = chartFontSize,
      labelsFont = labelsFont,
      axisLabelsFont = axisLabelsFont,
      scoreFont = scoreFont,
      scoreLabelFont = scoreLabelFont,
      hand = hand,
      gridLines = gridLines,
      chartTitle = chartTitle,
      theme = theme,
      backgroundColor = validateColor(backgroundColor),
      caption = caption,
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
    name = "amChart4",
    reactR::reactMarkup(component),
    width = "auto",
    height = "auto",
    package = "rAmCharts4",
    elementId = elementId
  )
}
