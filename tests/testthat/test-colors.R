test_that("display_palette() throws an error for an unknown palette", {
  expect_error(display_palette("unknown_palette"))
})

test_that("display_palette() works for every palette name", {
  pal_names <- names(gouvdown::gouv_palettes)
  for (i in seq_along(pal_names)) {
    expect_silent(display_palette(pal_names[i]))
  }
})

test_that("display_palette_all() works", {
  expect_silent(display_palette_all())
})
