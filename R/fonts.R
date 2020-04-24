#' HTML dependencies for fonts used by the French government
#'
#' These functions provide common HTML dependencies for re-use by other R
#' Markdown output formats or Shiny applications.
#'
#' @param use_gouvdown_fonts Do you prefer to use `gouvdown.fonts` dependencies?
#'
#' @return An object that can be included in a list of dependencies passed to
#'   [attachDependencies][htmltools::attachDependencies()].
#'
#' @export
#' @keywords internal
#'
#' @examples
#' spectral_font_dep()
spectral_font_dep <- function(use_gouvdown_fonts = TRUE) {
  if (isTRUE(use_gouvdown_fonts) && xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_spectral", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "fontspectral", "v2.000", src = pkg_resource(),
    head = paste(readLines(pkg_resource("fonts", "spectral", "links.html")), collapse = "\n")
  )
}


