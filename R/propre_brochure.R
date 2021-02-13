#' gouvdown PDF brochure - PROPRE style
#'
#' @param ... Additional arguments passed to \code{bookdown::\link{html_document2}()}.
#' @param css A character vector of additionnal CSS file paths.
#'
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
propre_brochure <- function(...,
                            css = NULL) {

  # custom css
  book_css <- pkg_resource("css/propre/book.css")

  # custom Pandoc template

  # render
  pagedown::html_paged(number_sections = FALSE,
                       # self_contained = FALSE,
                       toc = FALSE,
                       css = c(book_css, css),
                       ...)
}
