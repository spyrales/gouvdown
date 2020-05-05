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

#' Create a grid graphical object from an image file
#'
#' @details Fill either `file` or `alias` parameter:  an error is thrown if both parameters are provided.
#' @param file Path to a local `png` file.
#' @param alias Name of a logo available in `gouvdown`.
#' @param x_pos,y_pos `x` and `y` positions of the logo relative to the border.
#'
#' @return An object of class "grob".
#' @export
#'
#' @examples
#' create_logo("marianne")
create_logo <- function(alias = NULL, file = get_logo(alias), x_pos = 0.04, y_pos = 0.96) {
  if (!xor(missing(alias), missing(file))) {
    stop("use either a local file or an alias for a gouvdown logos")
  }

  if (length(alias) > 1) {
    stop("please select only one alias")
  }

  if (length(file) > 1) {
    stop("please select only one file")
  }

  if (!is.null(file)) {
    logo <- file
  }


  #Make the header
  header <- grid::grobTree(grid::rasterGrob(png::readPNG(logo), x = x_pos, y = y_pos))
  return(header)
}

#' Add a logo to a plot
#'
#' @param plot A plot.
#' @param header The header to add.
#' @param ratio The ratio in % between the header and the plot.
#'
#' @return A `ggplot` object.
#' @export
add_logo <- function(plot = ggplot2::last_plot(), header, ratio = 10) {
  plot_grid <- ggpubr::ggarrange(header, plot,
                                 ncol = 1, nrow = 2,
                                 heights = c(ratio/100, 1))
  return(plot_grid)
}
