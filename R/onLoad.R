# Copyright 2020 République Française
#
# Licensed under the EUPL, Version 1.2 or – as soon they will be approved by
# the European Commission - subsequent versions of the EUPL (the "Licence");
# You may not use this work except in compliance with the Licence.
# You may obtain a copy of the Licence at:
#
# https://joinup.ec.europa.eu/software/page/eupl
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the Licence is distributed on an "AS IS" basis,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Licence for the specific language governing permissions and
# limitations under the Licence.

.onAttach <- function(libname, pkgname) {
  # switch the default ggplot2 theme to theme_gouv
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
