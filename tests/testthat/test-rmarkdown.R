# inspired by mitchell O'Hara-Wild vitae package : https://github.com/mitchelloharawild/vitae/blob/master/tests/testthat/test-template.R
expect_render <- function(template){

  outputdir <- tempfile()
  dir.create(outputdir)
  dir.create(file.path(outputdir,'www'))
  file.copy(system.file("rmarkdown", "templates", template, "skeleton", "skeleton.Rmd", package = "gouvdown"),outputdir)
  file <- file.path(outputdir,"skeleton.Rmd")
  expect_output(
    expect_message(
      rmarkdown::render(
        file,
        output_dir = outputdir),
      "Output created"),
    "pandoc")
}

test_that("gouvdown_html_document", {
  expect_render("gouvdown_html_document")
})

test_that("Le template lettre_word fonctionne", {
  expect_render("gouvdown-lettre-word")
})
