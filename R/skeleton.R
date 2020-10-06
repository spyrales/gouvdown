gouvdown_book_skeleton <- function(path, ...) {
  dots <- list(...)
  logo_name <- dots$logo_name
  logo_file <- dots$logo_file
  if (logo_name != "" & logo_file != "") {
    stop("please select either a logo name or a logo file")
  }
  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path, "www"), recursive = TRUE, showWarnings = FALSE)

  # copy 'resources' folder to path
  resources <- pkg_file("rstudio", "templates", "project", "resources")

  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  source <- file.path(resources, files)
  target <- file.path(path, files)
  target_logo <- file.path(path, "www")
  file.copy(source, target)
  # copy 'default.css' and 'gouv_book.css' file to path
  css <- pkg_resource("css", c("default.css", "gouv_book.css"))
  file.copy(css, path)
  if (logo_file != "" | logo_name != "") {
    if (logo_file == "") {
      logo_file <- logo_file_path(logo_name)
    }
    file.copy(logo_file, target_logo)
    file_name <- basename(logo_file)
    content <- sprintf('        <li><a href="./"><img src="www/%s" width = "130"></a></li>', file_name)
    f <- file.path(path, "_output.yml")
    x <- xfun::read_utf8(f)
    output <- c(x[1:5], content, x[7:length(x)])
    xfun::write_utf8(output, f)
  }
  # add book_filename to _bookdown.yml and default to the base path name
  f <- file.path(path, "_bookdown.yml")
  x <- xfun::read_utf8(f)
  xfun::write_utf8(c(sprintf('book_filename: "%s"', basename(path)), x), f)

  TRUE
}
