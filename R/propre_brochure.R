#' gouvdown PDF brochure - PROPRE style
#'
#' @inheritParams html_gouv
#' @param ... Additional arguments passed to \code{bookdown::\link{html_document2}()}.
#' @param css A character vector of additionnal CSS file paths.
#' @param width_main_column Width of the main text column (in %)
#'
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
propre_brochure <- function(extra_dependencies = list(),
                            includes = NULL,
                            ...,
                            logo = NULL,
                            css = NULL,
                            use_gouvdown_fonts = TRUE,
                            width_main_column = 15,
                            made_with = "Ce document a été réalisé avec le package `gouvdown`") {
  # init variable
  logo_html_fragment <- NULL

  # create HTML fragment for logo
  if (!is.null(logo)) {
    if (xfun::file_ext(logo) == "") {
      logo_html_fragment <- create_header_html_gouv(logo = logo)
    }
    else {
      match.arg(xfun::file_ext(logo), c("png", "svg", "jpg", "gif"))
      logo_html_fragment <- create_header_html_gouv(file = logo)
    }
  }

  includes <- as.list(includes)
  includes$before_body <-
    c(includes$before_body, logo_html_fragment)

  # custom css
  book_css <- pkg_resource("css/propre", "book.css")

  # fonts dependencies - taken from html_gouv
  extra_dependencies <- c(gouvdown_dependencies(use_gouvdown_fonts),
                          extra_dependencies)

  # width of main column - write css
  width_css <- tempfile(fileext = ".css")

  writeLines(paste(
    paste0(":root {--main-column-width:", width_main_column , "%;}"),
    paste0(":root {--secondary-column-width:", 100 - width_main_column - 5, "%;}"), sep = "\n"
  ),
  con = width_css)

  # text made with gouvdown - write css
  made_with_css <- tempfile(fileext = ".css")

  writeLines(paste(
    paste0(":root {--made-with:", made_with , ";}")
  ),
  con = made_with_css)

  # render
  pagedown::html_paged(
    extra_dependencies = extra_dependencies,
    includes = includes,
    number_sections = FALSE,
    # self_contained = FALSE,
    toc = FALSE,
    css = c(css, book_css, width_css, made_with_css),
    ...
  )
}
