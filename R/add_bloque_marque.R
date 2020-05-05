#' Create a grid graphical object from an image file
#'
#' @param file Path to a local `png` file.
#' @param alias Name of a logo available in `gouvdown`.
#' @param x_pos,y_pos `x` and `y` positions of the logo relative to the border.
#'
#' @return An object of class "grob".
#' @export
#'
#' @examples
#' create_logo(alias = "marianne")

create_logo <- function(file = NULL, alias = NULL, x_pos = 0.04, y_pos = 0.96) {
  if (!is.null(file)) {
    logo <- file
  }

  if (!is.null(alias)) {
    logo <- get_bloque_marque(alias)
  }
  if (!is.null(alias) && !is.null(file)) {
    stop("Error Message: use either a local file or an alias to the package bloque marque")
  }
  if (is.null(alias) && is.null(file)) {
    stop("Error Message: use either a local file or an alias to the package bloque marque")
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

add_bloque_marque <- function(plot = ggplot2::last_plot(), header, ratio = 10) {
  plot_grid <- ggpubr::ggarrange(header, plot,
                                 ncol = 1, nrow = 2,
                                 heights = c(ratio/100, 1))
  return(plot_grid)
}
