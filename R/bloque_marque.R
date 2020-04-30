
#' list all marque etat available
#'
#' @return a list
#' @export


list_bloque_marque <- function() {
  list.dirs(path = pkg_resource("bloque_marque"),recursive = F,full.names = F)
}

#' get the link to the bloque marque in the package directory
#'
#' @param bloque_marque
#'
#' @return
#' @export
#'
#' @examples

get_bloque_marque <- function(bloque_marque) {

  liste_bloque_marque <- list_bloque_marque()

  if (!bloque_marque %in% liste_bloque_marque) {
    stop("Error Message: this bloque_marque is not know")
  }
  dir <- gouvdown:::pkg_resource("bloque_marque",bloque_marque)
  files <- list.files(dir,full.names = TRUE)
  return(files)
}

