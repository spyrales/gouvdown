#' The gouvdown GitBook output format
#'
#' This output format function ported a style provided by GitBook
#' (\url{https://www.gitbook.com}) for R Markdown.
#' @inheritParams html_chapters
#' @param fig_caption,number_sections,self_contained,lib_dir,pandoc_args ...
#'   Arguments to be passed to \code{rmarkdown::\link{html_document}()}
#'   (\code{...} not including \code{toc}, and \code{theme}).
#' @param template Pandoc template to use for rendering. Pass \code{"default"}
#'   to use the bookdown default template; pass a path to use a custom template.
#'   The default template should be sufficient for most use cases. In case you
#'   want to develop a custom template, we highly recommend to start from the
#'   default template:
#'   \url{https://github.com/rstudio/bookdown/blob/master/inst/templates/gitbook.html}.
#'
#' @param config A list of configuration options for the gitbook style, such as
#'   the font/theme settings.
#' @param table_css \code{TRUE} to load gitbook's default CSS for tables. Choose
#' \code{FALSE} to unload and use customized CSS (for exmaple, bootstrap) via
#' the \code{css} option. Default is \code{TRUE}.
#' @export
gitbook_gouv <- function(
  fig_caption = TRUE, number_sections = TRUE, self_contained = FALSE,
  lib_dir = 'libs', pandoc_args = NULL, ..., template = 'default',
  split_by = c('chapter', 'chapter+number', 'section', 'section+number', 'rmd', 'none'),
  split_bib = TRUE, config = list(), table_css = TRUE
) {
  html_gouv2 <- function(..., extra_dependencies = list()) {
    html_gouv(
      ..., extra_dependencies = c(extra_dependencies, bookdown:::gitbook_dependency(table_css),logo = NULL)
    )
  }
  gb_config = config
  if (identical(template, 'default')) {
    template = bookdown:::bookdown_file('templates', 'gitbook.html')
  }
  config = html_gouv2(
    toc = TRUE, number_sections = number_sections, fig_caption = fig_caption,
    self_contained = self_contained, lib_dir = lib_dir, theme = NULL,
    template = template, pandoc_args = bookdown:::pandoc_args2(pandoc_args), ...
  )
  split_by = match.arg(split_by)
  post = config$post_processor  # in case a post processor have been defined
  config$post_processor = function(metadata, input, output, clean, verbose) {
    if (is.function(post)) output = post(metadata, input, output, clean, verbose)
    on.exit(bookdown:::write_search_data(), add = TRUE)

    # a hack to remove Pandoc's margin for code blocks since gitbook has already
    # defined margin on <pre> (there would be too much bottom margin)
    x = xfun::read_utf8(output)
    x = x[x != 'div.sourceCode { margin: 1em 0; }']
    xfun::write_utf8(x, output)

    bookdown:::move_files_html(output, lib_dir)
    output2 = bookdown:::split_chapters(
      output, bookdown:::gitbook_page, number_sections, split_by, split_bib, gb_config, split_by
    )
    if (file.exists(output) && !xfun::same_path(output, output2)) file.remove(output)
    bookdown:::move_files_html(output2, lib_dir)
    output2
  }
  config = bookdown:::common_format_config(config, 'html')
  config
}