#' HTML dependencies for fonts used in French governmental documents
#'
#' These functions provide common HTML dependencies for re-use by other R
#' Markdown output formats or Shiny applications.
#'
#' @param use_gouvdown_fonts Do you prefer to use `gouvdown.fonts` dependencies?
#'
#' @return An object that can be included in a list of dependencies passed to
#'   [attachDependencies][htmltools::attachDependencies()].
#'
#' @keywords internal
#' @name fonts-dependencies
#'
#' @examples
#' spectral_font_dep()
NULL

#' Create an HTML dependency for Marianne font
#' @rdname fonts-dependencies
#' @export
marianne_font_dep <- function() {
  if (xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_marianne", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "Marianne", "0.999", src = pkg_resource("fonts", "marianne"),
    stylesheet = "stylesheet.css", all_files = FALSE
  )
}

#' Create an HTML dependency for Spectral font
#' @rdname fonts-dependencies
#' @export
spectral_font_dep <- function(use_gouvdown_fonts = TRUE) {
  if (isTRUE(use_gouvdown_fonts) && xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_spectral", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "Spectral", "2.000", src = pkg_resource(),
    head = paste(
      readLines(pkg_resource("fonts", "spectral", "desktop", "head.html")),
      collapse = "\n"
    ),
    all_files = FALSE
  )
}

#' Create an HTML dependency for Spectral SmallCaps font
#' @rdname fonts-dependencies
#' @export
spectral_sc_font_dep <- function(use_gouvdown_fonts = TRUE) {
  if (isTRUE(use_gouvdown_fonts) && xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_spectral_sc", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "SpectralSC", "2.000", src = pkg_resource(),
    head = paste(
      readLines(pkg_resource("fonts", "spectral", "sc", "head.html")),
      collapse = "\n"
    ),
    all_files = FALSE
  )
}

