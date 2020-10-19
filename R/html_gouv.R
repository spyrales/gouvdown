#' create html_gouv bootstrap header
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
  if (!missing(file) & !file.exists(file)) {
    stop("the file argument doesn't exist")
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
#' @param extra_dependencies  extra dep
#' @param includes Named list of additional content to include within the document (typically created using the \code{rmarkdown::\link{includes}()} function).
#' @param css css
#' @param ... Additional arguments passed to \code{rmarkdown::\link{html_document}()}.
#' @param logo a logo available in \code{gouvdown::\link{list_logos}()} or a file path to image file
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @importFrom rmarkdown includes
#' @export
html_gouv = function(..., extra_dependencies = list(),includes=NULL,css = NULL,logo = NULL) {
  if (!is.null(logo)){
    if (xfun::file_ext(logo) == "") {
      create_header_html_gouv(logo = logo)
    }
    else {
      match.arg(xfun::file_ext(logo),c("png","svg","jpg","gif"))
      create_header_html_gouv(file = logo)
    }
  }
  default_css <- pkg_resource('css','default.css')
  if (xfun::loadable("gouvdown.fonts")){
    all_css <- c(default_css,css)
    in_header_gouv <- NULL
  }
  else {
    marianne_css <- pkg_resource('fonts','marianne','stylesheet.css')
    all_css <- c(default_css,marianne_css,css)
    spectral_header <- pkg_resource('fonts','spectral','desktop','head.html')
    spectral_sc_header <- pkg_resource('fonts','spectral','sc','head.html')
    in_header_gouv <- c(spectral_header,spectral_sc_header)
  }
  extra_deps <- append(extra_dependencies,
                               list(
                                 marianne_font_dep(),
                                 spectral_font_dep(),
                                 spectral_sc_font_dep()
                                 )
  )
  if (is.null(logo)) {
    inc <- includes(in_header = in_header_gouv)
  }
  else {
    inc <- includes(in_header = in_header_gouv,before_body = 'header.html')
  }
  inc <- mapply(c,inc,includes(includes), SIMPLIFY = FALSE)
  rmarkdown::html_document(..., extra_dependencies = extra_deps,
  css = all_css,
  includes = inc)
}
