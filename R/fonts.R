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

#' Load installed fonts
#' @export
#' @examples
#' load_fonts()
load_fonts <- function() {
  # load fonts
  # Run it once in every R session

  # The extrafont package uses a non standard way to call functions:
  # we need to assign the pdfFonts() function from grDevices
  # in the current environment
  pdfFonts <- grDevices::pdfFonts

  extrafont::loadfonts(quiet = TRUE)
  # On windows only
  if (.Platform$OS.type == "windows") {
    # The extrafont package uses a non standard way to call functions:
    # we need to assign the windowsFonts() function from grDevices
    # in the current environment
    windowsFonts <- grDevices::windowsFonts

    extrafont::loadfonts(device = "win", quiet = TRUE)
  }
}

#' Test if fonts are available on the system and import them in R
#'
#' @param fonts Vector of fonts.
#' @param import Logical. Whether to import `ttf` font files in R (otherwise
#'   just check).
#' @param verbose List fonts to install if needed.
#'
#' @details
#' For fonts to be used, they need to be installed on the machine.
#'
#' @export
#' @examples
#' \donttest{
#' check_fonts_in_r(import = FALSE)
#'
#' # Test if working
#' library(ggplot2)
#' ggplot(mtcars) +
#'   geom_point(aes(cyl, mpg)) +
#'   labs(
#'     title = "Mon titre avec Marianne",
#'     x = "lab X avec Spectral",
#'     y = "Lab Y avec Spectral"
#'   ) +
#'   theme(
#'     title = element_text(family = "Marianne"),
#'     axis.title.x = element_text(family = "Spectral"),
#'     axis.title.y = element_text(family = "Spectral")
#'   )
#' }
check_fonts_in_r <- function(fonts = c("Marianne", "Spectral"),
                             import = TRUE,
                             verbose = TRUE) {

  # Import fonts
  if (isTRUE(import)) {
    fonts_no_space <- gsub(" ", "", fonts)
    res <- lapply(fonts_no_space, function(x) {
      res <- tryCatch(
        extrafont::font_import(paths = dirname(systemfonts::match_font(x)$path), pattern = x, prompt = FALSE),
        error = function(e) FALSE
      )
      if (is.null(res)) {
        res <- TRUE
      }
      res
    })
    res <- unlist(res)
    names(res) <- fonts

    # load installed fonts
    load_fonts()
  } else {
    res <- lapply(fonts, function(x) {
      (extrafont::choose_font(x) != "")
    })

    res <- unlist(res)
    names(res) <- fonts
  }

  # If some are missing
  if (!all(res) && isTRUE(verbose)) {
    warning(
      "To use the complete ggplot gouv_theme, you need to install the following fonts on your computer: ",
      paste(names(res)[!res], collapse = ", "), ".",
      "\n  To install, see for instance: https://www.howtogeek.com/192980/how-to-install-remove-and-manage-fonts-on-windows-mac-and-linux/",
      "\n  Run gouvdown::check_fonts_in_r() after fonts installation.",
      call. = FALSE, immediate. = TRUE
    )
  }

  res
}

#' HTML dependencies for fonts used in French governmental documents
#'
#' These functions provide common HTML dependencies for re-use by other R
#' Markdown output formats or Shiny applications.
#'
#' @param use_gouvdown_fonts Do you prefer using `gouvdown.fonts` dependencies?
#'
#' @return An object that can be included in a list of dependencies passed to
#'   [attachDependencies][htmltools::attachDependencies()].
#'
#' @references <https://www.gouvernement.fr/charte/charte-graphique-les-fondamentaux/la-typographie>
#' @keywords internal
#' @name fonts-dependencies
#'
#' @examples
#' library(htmltools)
#' library(gouvdown)
#'
#' tag <- p(
#'   "The quick brown fox jumps over the lazy dog",
#'   style = "font-family: 'Marianne', Arial, sans-serif"
#' )
#'
#' tag <- attachDependencies(tag, marianne_font_dep())
#'
#' html_print(tag)
NULL

#' Create an HTML dependency for Marianne font
#' @rdname fonts-dependencies
#' @export
marianne_font_dep <- function(use_gouvdown_fonts = TRUE) {
  if (isTRUE(use_gouvdown_fonts) && xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_marianne", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "Marianne", "0.999", src = pkg_resource("fonts", "marianne"),
    stylesheet = "stylesheet.css", all_files = FALSE
  )
}

#' Create an HTML dependency for Spectral font
#' @rdname fonts-dependencies
#' @export
spectral_font_dep <- function(use_gouvdown_fonts = TRUE) {
  if (isTRUE(use_gouvdown_fonts) && xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_spectral", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "Spectral", "2.000", src = pkg_resource(),
    head = paste(
      readLines(pkg_resource("fonts", "spectral", "desktop", "head.html")),
      collapse = "\n"
    ),
    all_files = FALSE
  )
}

#' Create an HTML dependency for Spectral SmallCaps font
#' @rdname fonts-dependencies
#' @export
spectral_sc_font_dep <- function(use_gouvdown_fonts = TRUE) {
  if (isTRUE(use_gouvdown_fonts) && xfun::loadable("gouvdown.fonts")) {
    dep <- utils::getFromNamespace("html_dependency_spectral_sc", "gouvdown.fonts")
    return(dep())
  }

  htmltools::htmlDependency(
    "SpectralSC", "2.000", src = pkg_resource(),
    head = paste(
      readLines(pkg_resource("fonts", "spectral", "sc", "head.html")),
      collapse = "\n"
    ),
    all_files = FALSE
  )
}

