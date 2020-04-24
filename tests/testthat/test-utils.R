test_that("pkg_resource() finds files under the resources dir of the package", {
  expect_true(dir.exists(pkg_resource("fonts")))
})
