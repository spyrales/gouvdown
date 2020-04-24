test_that("pkg_resource() finds the resources dir of the package", {
  expect_true(dir.exists(pkg_resource()))
})
