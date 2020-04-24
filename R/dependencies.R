#' HTML dependencies for French government web documents
#'
#' These functions provide common HTML dependencies for re-use by other R
#' Markdown output formats or Shiny applications.
#'
#' @return An object that can be included in a list of dependencies passed to
#'   [attachDependencies][htmltools::attachDependencies()].
#'
#' @export
#' @keywords internal
#'
#' @examples
#' html_dependency_spectral()
html_dependency_spectral <- function() {
  htmltools::htmlDependency(
    "fontspectral", "v2.003", src = pkg_resource("fonts", "spectral"),
    stylesheet = file.path("stylesheet.css"), all_files = TRUE
  )
}
