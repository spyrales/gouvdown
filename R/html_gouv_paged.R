#' gouvdown pdf paged document - hosrt version
#'
#' @param ... Additional arguments passed to \code{rmarkdown::\link{html_document}()}.
#' @param extra_dependencies  extra dep
#' @param css css
#' @param header header to include
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @importFrom rmarkdown includes
#' @export
html_paged_short_gouv = function(...,
                     extra_dependencies = list(),
                     css = NULL,
                     header = 'header.html') {

  default_css <- pkg_resource('css', 'default.css')
  paged_css <- pkg_resource('css', 'paged_short.css')
  if (xfun::loadable("gouvdown.fonts")) {
    extra_deps <- append(
      extra_dependencies,
      list(
        marianne_font_dep(),
        spectral_font_dep(),
        spectral_sc_font_dep()
      )
    )
  }
  else {
    extra_deps <- append(extra_dependencies)
  }
  pagedown::html_paged(
    ...,
    extra_dependencies = extra_deps,
    css = c(default_css, paged_css, css),
    includes = includes(before_body = header)
  )
}
