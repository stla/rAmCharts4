% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bullets.R
\name{rAmCharts4-shapes}
\alias{rAmCharts4-shapes}
\alias{amTriangle}
\alias{amCircle}
\alias{amRectangle}
\title{Bullets}
\usage{
amTriangle(
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
)

amCircle(
  color = NULL,
  opacity = 1,
  radius = 6,
  strokeColor = NULL,
  strokeOpacity = 1,
  strokeWidth = 2,
  image = NULL
)

amRectangle(
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
)
}
\arguments{
\item{color}{bullet color; this can be a
\link[rAmCharts4:amColorAdapterFromVector]{color adapter}}

\item{opacity}{bullet opacity, a number between 0 and 1}

\item{width}{bullet width}

\item{height}{bullet height}

\item{strokeColor}{stroke color of the bullet; this can be a
\link[rAmCharts4:amColorAdapterFromVector]{color adapter}}

\item{strokeOpacity}{stroke opacity of the bullet, a number between 0 and 1}

\item{strokeWidth}{stroke width of the bullet}

\item{direction}{triangle direction}

\item{rotation}{rotation angle}

\item{image}{option to include an image in the bullet, a list created
with \code{\link{amImage}}}

\item{radius}{circle radius}

\item{cornerRadius}{radius of the rectangle corners}
}
\value{
A list of settings for the bullets.
}
\description{
Create a list of settings for bullets,
their shape and their style.
}
\note{
A color can be given by the name of a R color, the name of a CSS
  color, e.g. \code{"transparent"} or \code{"fuchsia"}, an HEX code like
  \code{"#ff009a"}, a RGB code like \code{"rgb(255,100,39)"}, or a HSL code
  like \code{"hsl(360,11,255)"}.
}
