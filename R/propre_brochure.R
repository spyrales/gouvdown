#' gouvdown PDF brochure - PROPRE style
#'
#' @inheritParams html_gouv
#' @param ... Additional arguments passed to \code{bookdown::\link{html_document2}()}.
#' @param css A character vector of additionnal CSS file paths.
#'
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
propre_brochure <- function(extra_dependencies = list(),
                            includes = NULL,
                            ...,
                            logo = NULL,
                            css = NULL,
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

  # custom css
  book_css <- pkg_resource("css/propre", "book.css")

  # custom Pandoc template
  brochure_html <- pkg_resource("html", "propre_brochure.html")

  # fonts dependencies - taken from html_gouv
  extra_dependencies <- c(
    gouvdown_dependencies(use_gouvdown_fonts),
    extra_dependencies
  )

  # render
  pagedown::html_paged(extra_dependencies = extra_dependencies,
                       includes = includes,
                       number_sections = FALSE,
                       # self_contained = FALSE,
                       toc = FALSE,
                       css = c(book_css, css),
                       template = brochure_html,
                       ...)
}
