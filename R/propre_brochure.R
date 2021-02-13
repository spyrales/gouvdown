#' gouvdown PDF brochure - PROPRE style
#'
#' @param ... Additional arguments passed to \code{bookdown::\link{html_document2}()}.
#' @param css A character vector of additionnal CSS file paths.
#' @param use_gouvdown_fonts Use the fonts provided by the `gouvdown.fonts` package, if installed.
#'
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
propre_brochure <- function(extra_dependencies = list(),
                            ...,
                            css = NULL,
                            use_gouvdown_fonts = TRUE) {

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
                       number_sections = FALSE,
                       # self_contained = FALSE,
                       toc = FALSE,
                       css = c(book_css, css),
                       template = brochure_html,
                       ...)
}
