l <- list_logos()

get_extension <- function(file) {
  ex <- strsplit(basename(file), split = "\\.")[[1]]
  return(ex[-1])
}

test_that(
  "There is one file in each inst/blocs_marque/ subdirectories",
  for (i in l) {
    expect_equal(length(logo_file_path(i)), 1)
  }
)

test_that(
  "Design marks are only png files",
  for (i in l) {
    expect_equal(get_extension(logo_file_path(i)), "png")
  }
)

test_that(
  "all design marks can be read",
  for (i in l) {
    expect_error(png::readPNG(logo_file_path(i)), NA)
  }
)

test_that(
  "gglogo() raises no error for internal design marks",
  for (i in l) {
    expect_error(gglogo(i), NA)
  }
)
