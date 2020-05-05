
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
get_bloque_marque <- function(bloque_marque) {

  liste_bloque_marque <- list_bloque_marque()

  if (!bloque_marque %in% liste_bloque_marque) {
    stop("Error Message: this logo is not known")
  }
  dir <- pkg_resource("bloque_marque", bloque_marque)
  files <- list.files(dir,full.names = TRUE)
  return(files)
}
