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
create_header_html_gouv <- function(logo = NULL,
                                    file = logo_file_path(logo),
                                    output = 'header.html') {
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

  invisible(output)
}

#' gouvdown HTML document
#'
#' @inheritParams rmarkdown::html_document
#' @param ... Additional arguments passed to \code{rmarkdown::\link{html_document}()}.
#' @param logo a logo available in \code{gouvdown::\link{list_logos}()} or a file path to image file
#' @param use_gouvdown_fonts Use the fonts provided by the `gouvdown.fonts` package, if installed.
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
html_gouv = function(...,
                     extra_dependencies = list(),
                     includes = NULL,
                     logo = NULL,
                     use_gouvdown_fonts = TRUE) {
  # init variable
  logo_html_fragment <- NULL

  # create HTML fragment for logo
  if (!is.null(logo)){
    if (xfun::file_ext(logo) == "") {
      logo_html_fragment <- create_header_html_gouv(logo = logo)
    }
    else {
      match.arg(xfun::file_ext(logo), c("png", "svg", "jpg", "gif"))
      logo_html_fragment <- create_header_html_gouv(file = logo)
    }
  }

  includes <- as.list(includes)
  includes$before_body <- c(includes$before_body, logo_html_fragment)

  extra_dependencies <- c(
    gouvdown_dependencies(use_gouvdown_fonts),
    extra_dependencies
  )

  rmarkdown::html_document(
    extra_dependencies = extra_dependencies,
    includes = includes, ...
  )
}

gouvdown_dependencies <- function(use_gouvdown_fonts = TRUE) {
  # default CSS stylesheet
  default_dep <- list(htmltools::htmlDependency(
    'gouvdown-default', utils::packageVersion('gouvdown'),
    src = pkg_resource('css'), stylesheet = file.path('default.css')
  ))

  # fonts dependencies (see R/fonts.R)
  font_deps <- lapply(
    paste0(c('marianne', 'spectral', 'spectral_sc'), '_font_dep'),
    function(x) do.call(x, list(use_gouvdown_fonts = use_gouvdown_fonts))
  )

  c(font_deps, default_dep)
}
