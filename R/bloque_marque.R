
#' List available logos
#'
#' @return A list with the names of the logos available in `gouvdown`.
#' @export
list_logo <- function() {
  list.dirs(path = pkg_resource("blocs_marque"), recursive = FALSE, full.names = FALSE)
}

#' Get the path to the logo file in the package directory
#'
#' @param logo Name of the logo.
#'
#'
#' @return A character string with the path to the logo file.
#' @export
get_logo <- function(logo) {

  liste_blocs_marque <- list_logo()

  if (length(logo) > 1) {
    stop("Error Message: please select only one logo")
  }

  if (!logo %in% liste_blocs_marque) {
    stop("Error Message: this logo is not known")
  }
  dir <- pkg_resource("blocs_marque", logo)
  file <- list.files(dir, full.names = TRUE)
  return(file)
}
