
#' list all marque etat available
#'
#' @return A list with the names of the logos available in `gouvdown`.
#' @export
list_bloque_marque <- function() {
  list.dirs(path = pkg_resource("bloque_marque"), recursive = FALSE, full.names = FALSE)
}

#' get the path to the bloque marque in the package directory
#'
#' @param bloque_marque name of the bloque marque
#'
#'
#' @return a string
#' @export
get_bloque_marque <- function(bloque_marque) {

  liste_bloque_marque <- list_bloque_marque()

  if (!bloque_marque %in% liste_bloque_marque) {
    stop("Error Message: this bloque_marque is not know")
  }
  dir <- pkg_resource("bloque_marque", bloque_marque)
  files <- list.files(dir,full.names = TRUE)
  return(files)
}
