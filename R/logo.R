# Copyright 2020 République Française
#
# Licensed under the EUPL, Version 1.2 or – as soon they will be approved by
# the European Commission - subsequent versions of the EUPL (the "Licence");
# You may not use this work except in compliance with the Licence.
# You may obtain a copy of the Licence at:
#
# https://joinup.ec.europa.eu/software/page/eupl
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the Licence is distributed on an "AS IS" basis,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Licence for the specific language governing permissions and
# limitations under the Licence.

#' Add a logo to a plot
#'
#' @param plot A `ggplot2` plot object.
#' @param header The header to add.
#' @param ratio The ratio in % between the header and the plot.
#'
#' @return A `ggplot2` plot object.
#' @export
#' @examples
#' library(ggplot2)
#'
#' p <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#'   geom_point(aes(color = Species, shape = Species))
#'
#' add_plot_header(p, gglogo("marianne"))
add_plot_header <- function(plot = ggplot2::last_plot(), header, ratio = 10) {
  plot_grid <- ggpubr::ggarrange(header, plot,
                                 ncol = 1, nrow = 2,
                                 heights = c(ratio/100, 1))
  return(plot_grid)
}

#' Create a graphical object from a logo file
#'
#' The `gglogo()` function creates a `grob` (a `grid` graphical object) from
#' a logo file. This `grob` can be combined with a `ggplot2` plot object.
#'
#' Fill either `logo` or `file` parameter: an error is thrown if both
#' parameters are provided.
#'
#' @inheritParams grid::rasterGrob
#' @param file Path to a `png` file.
#' @param logo Name of a logo available in `gouvdown`. The list of available
#'   logos can be obtained with [list_logos()].
#' @param x,y `x` and `y` positions of the logo relative to the border. Since
#'   these arguments are passed to [grid::rasterGrob()],
#'   [unit objects][grid::unit()] are allowed.
#' @param ... Other arguments passed to [grid::rasterGrob()].
#'
#' @return An object of class "grob".
#' @export
#'
#' @examples
#' library(grid)
#'
#' header <- gglogo("marianne", x = 0, y = 1)
#' vp <- viewport(x = 0.22, y = 0.78,
#'                width = 0.2, height = 0.2,
#'                just = c("right", "bottom"))
#' pushViewport(vp)
#' grid.draw(header)
gglogo <- function(
  logo, file = logo_file_path(logo), x = 0.04, y = 0.96,
  just = c("left", "top"), ...
) {
  if (!xor(missing(logo), missing(file))) {
    stop("use either a logo name or a path to a file")
  }

  if (!missing(logo)) {
    match.arg(logo, list_logos())
  }

  if (length(file) > 1) {
    stop("please select only one file")
  }

  #Make the header
  image <- png::readPNG(file)
  raster <- grid::rasterGrob(image, x = x, y = y, just = just, ...)
  header <- grid::grobTree(raster)
  return(header)
}

#' Get the path to the logo file in the package directory
#'
#' @param logo Name of the logo.
#'
#' @return A character string with the path to the logo file.
#' @export
logo_file_path <- function(logo) {
  match.arg(logo, list_logos())

  dir <- pkg_resource("blocs_marque", logo)
  file <- list.files(dir, full.names = TRUE)
  return(file)
}

#' List available logos
#'
#' `list_logos()` is a helper function that can be used to obtain the list of
#' the official design marks contained in the `gouvdown` package.
#'
#' @return A list with the names of the logos available in `gouvdown`.
#' @export
list_logos <- function() {
  list.dirs(path = pkg_resource("blocs_marque"), recursive = FALSE, full.names = FALSE)
}
