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

#' List available logos
#'
#' @return A list with the names of the logos available in `gouvdown`.
#' @export
list_logos <- function() {
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

  match.arg(logo, list_logos())

  dir <- pkg_resource("blocs_marque", logo)
  file <- list.files(dir, full.names = TRUE)
  return(file)
}
