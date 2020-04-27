test_that("marianne_font_dep() returns an object of class 'html_dependency'", {
  expect_s3_class(marianne_font_dep(), "html_dependency")
})

test_that("spectral_font_dep() returns an object of class 'html_dependency'", {
  expect_s3_class(spectral_font_dep(TRUE), "html_dependency")
  expect_s3_class(spectral_font_dep(FALSE), "html_dependency")
})

test_that("spectral_sc_font_dep() returns an object of class 'html_dependency'", {
  expect_s3_class(spectral_sc_font_dep(TRUE), "html_dependency")
  expect_s3_class(spectral_sc_font_dep(FALSE), "html_dependency")
})
