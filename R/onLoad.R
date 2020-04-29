.onAttach <- function(libname, pkgname) {
  # switch the default ggplot2 theme to theme_dreal
  # ggplot2::theme_set(theme_gouv())
  packageStartupMessage("\n\n*******************************************************")
  # packageStartupMessage("Note: gouvdown changes the default ggplot2 theme.")
  # packageStartupMessage("To recover the default ggplot2 theme, execute:\n  theme_set(theme_gray())")
  packageStartupMessage("theme_gouv() for ggplot2 is not set as default,\nto do so, execute:\n  theme_set(theme_gouv())")
  packageStartupMessage("*******************************************************\n")
}
.onLoad <- function(libname, pkgname) {
  onload_function()
}
