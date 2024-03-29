% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggthemes.R
\name{theme_gouv_map}
\alias{theme_gouv_map}
\title{ggplot2 theme for map with French government design template}
\usage{
theme_gouv_map(
  base_family = "Marianne",
  base_size = 12,
  plot_title_family = "Marianne",
  plot_title_size = 28,
  plot_title_face = "bold",
  plot_title_margin = 10,
  subtitle_family = "Marianne Light",
  subtitle_size = 22,
  subtitle_face = "plain",
  subtitle_margin = 15,
  strip_text_family = base_family,
  strip_text_size = 14,
  strip_text_face = "plain",
  strip_text_color = "black",
  strip_background_color = "#FFFFFF",
  caption_family = base_family,
  caption_size = 12,
  caption_face = "plain",
  caption_margin = 10,
  plot_margin = margin(30, 30, 30, 30),
  legend_background_color = "#FFFFFF",
  legend_border_color = "#FFFFFF"
)
}
\arguments{
\item{base_family, base_size}{Base font family and size.}

\item{plot_title_family, plot_title_face, plot_title_size, plot_title_margin}{Plot title family, face, size and margin.}

\item{subtitle_family, subtitle_face, subtitle_size}{Plot subtitle family, face and size.}

\item{subtitle_margin}{Plot subtitle margin bottom (single numeric value).}

\item{strip_text_family, strip_text_face, strip_text_size, strip_text_color}{Facet label font family, face, size and color.}

\item{strip_background_color}{Facel label background color.}

\item{caption_family, caption_face, caption_size, caption_margin}{Plot caption family, face, size and margin.}

\item{plot_margin}{Plot margin (specify with \code{ggplot2::margin()}).}

\item{legend_background_color}{Legend background fill color; default to \code{white}.}

\item{legend_border_color}{Legend border color; default to \code{white}.}
}
\value{
A \code{ggplot2} theme.
}
\description{
ggplot2 theme for map with French government design template
}
\details{
This theme is designed for making map with ggplot plot with \code{ggplot2::geom_sf()}.
All font sizes are set in points and colors are either a color name or a hex code.
}
\examples{
\dontrun{
library(ggplot2)
library(sf)
demo(nc, ask = FALSE, echo = FALSE)

ggplot(data = nc) + geom_sf(aes(fill = BIR79)) + theme_gouv_map() +
    scale_color_gouv_continuous() + labs(title = "North Carolina SIDS",
    subtitle = "with theme_gouv_map()")
}
}
