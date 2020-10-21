#' @include html_gouv.R
NULL

#' The gouvdown GitBook output format
#'
#' @param ... Additional arguments passed to \code{bookdown::\link{gitbook}()}.
#' @inheritParams html_gouv
#' @return An R Markdown output format object to be passed to
#'   \code{rmarkdown::\link{render}()}.
#' @export
gitbook_gouv <- function(extra_dependencies = list(),
                         ...,
                         use_gouvdown_fonts = TRUE) {
  extra_dependencies <- c(
    gouvdown_dependencies(use_gouvdown_fonts),
    extra_dependencies
  )

  bookdown::gitbook(extra_dependencies = extra_dependencies, ...)
}
