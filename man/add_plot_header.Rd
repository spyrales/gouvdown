% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logo.R
\name{add_plot_header}
\alias{add_plot_header}
\title{Add a logo to a plot}
\usage{
add_plot_header(plot = ggplot2::last_plot(), header, ratio = 10)
}
\arguments{
\item{plot}{A \code{ggplot2} plot object.}

\item{header}{The header to add.}

\item{ratio}{The ratio in \% between the header and the plot.}
}
\value{
A \code{ggplot2} plot object.
}
\description{
Add a logo to a plot
}
\examples{
library(ggplot2)

p <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point(aes(color = Species, shape = Species))

add_plot_header(p, gglogo("marianne"))
}
