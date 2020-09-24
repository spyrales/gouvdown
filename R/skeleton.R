gouvdown_book_skeleton <- function(path) {

  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # copy 'resources' folder to path
  resources <- pkg_file('rstudio', 'templates', 'project', 'resources')

  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  source <- file.path(resources, files)
  target <- file.path(path, files)
  file.copy(source, target)
  # copy 'default.css' and 'gouv_book.css' file to path
  css <- gouvdown:::pkg_resource('css',c('default.css','gouv_book.css'))
  file.copy(css, path)
  # add book_filename to _bookdown.yml and default to the base path name
  f = file.path(path, '_bookdown.yml')
  x = xfun::read_utf8(f)
  xfun::write_utf8(c(sprintf('book_filename: "%s"', basename(path)), x), f)

  TRUE
}
