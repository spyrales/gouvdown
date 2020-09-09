#' create html_gouv header
#'
#' @param file Path to a `png` file.
#' @param logo Name of a logo available in `gouvdown`. The list of available
#'   logos can be obtained with [list_logos()].
#' @param output name of the header. The logo is copied in an 'www' subfolder
#' @importFrom glue glue
#' @importFrom here here
#'
#' @return an html file
#' @export
#'
#' @examples
#' create_header_html_gouv(logo = 'gouvernement')
create_header_html_gouv <- function(logo = NULL, file = logo_file_path(logo), output = 'header.html') {
  if (!xor(missing(logo), missing(file))) {
    stop("use either a logo name or a path to a file")
  }

  if (!missing(logo)) {
    match.arg(logo, list_logos())
  }

  if (length(file) > 1) {
    stop("please select only one file")
  }
  logo_name <- basename(file)
  if (!dir.exists(here::here("www"))) {dir.create(here::here("www"))}
  file.copy(file,'www')
  writeLines(
    glue(
      "<div class=\"row\">

<div class=\"col-md-4\">
<a>
<img src=\"www/{logo_name}\" width=\"215px\">
</a>
</div>

</div>"),
    output
  )
}

#' gouvdown html document
#'
#' @param ... Additional arguments passed to \code{rmarkdown::html_document()}.
#' @param extra_dependencies  extra dep
#' @param css css
#' @param header header to include
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @importFrom rmarkdown includes
#' @export
html_gouv = function(..., extra_dependencies = list(),css = NULL,header = 'header.html') {
  default_css <- pkg_resource('css','default.css')
  if (requireNamespace("gouvdown.fonts", quietly = TRUE)) {
  extra_deps <- append(extra_dependencies,
                               list(
                                 gouvdown.fonts::html_dependency_marianne(),
                                 gouvdown.fonts::html_dependency_spectral())
  )
  }
  else {
    extra_deps <- append(extra_dependencies)
  }
  rmarkdown::html_document(..., extra_dependencies = extra_deps,
  css = c(default_css,css),
  includes = includes(before_body = header))
}
