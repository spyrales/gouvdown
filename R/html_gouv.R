
#' gouvdown html document
#'
#' @param ...
#' @param extra_dependencies  extra dep
#' @param css csss
#'
#' @return
#' @export
#'
#' @examples

html_gouv = function(..., extra_dependencies = list(),css = NULL) {

  extra_deps <- append(extra_dependencies,
                               list(
                                 gouvdown.fonts::html_dependency_marianne(),
                                 gouvdown.fonts::html_dependency_spectral())
  )

  rmarkdown::html_document(..., extra_dependencies = extra_deps,
  css = gouvdown:::pkg_resource('css','default.css'))
}
