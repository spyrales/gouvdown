#' Create a grob from image file
#'
#' @param file local file
#' @param alias name from a bloque marque available in gouvdown
#' @param x_pos,y_pos x and y position of the file relative to the border
#'
#' @return a grob
#' @export
#'
#' @examples
#' \dontrun{
#' create_bloque_marque(alias = "marianne")
#'}

create_bloque_marque <- function (file=NULL,alias=NULL,x_pos=0.04,y_pos=0.96) {
  if (!is.null(file)) {
    logo <- file
  }

  if (!is.null(alias)) {
    logo <- get_bloque_marque(alias)
  }
  if (!is.null(alias) & !is.null(file)) {
    stop("Error Message: use either a local file or an alias to the package bloque marque")
  }
  if (is.null(alias) & is.null(file)) {
    stop("Error Message: use either a local file or an alias to the package bloque marque")
  }

  #Make the header
  header <- grid::grobTree(grid::rasterGrob(png::readPNG(logo), x = x_pos,y=y_pos))
  return(header)
}

#' add the bloque_marque to a plot
#'
#' @param plot the plot
#' @param header the header to add
#' @param ratio the ratio in % between the header and the plot
#'
#' @return a ggplot
#' @export

add_bloque_marque <- function(plot = ggplot2::last_plot(),header,ratio=10) {
plot_grid <- ggpubr::ggarrange(header, plot,
                               ncol = 1, nrow = 2,
                               heights = c(ratio/100,1))
return(plot_grid)
}
