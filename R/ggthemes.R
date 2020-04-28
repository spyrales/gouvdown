#' Function to run onLoad

onload_function <- function() {
  # load fonts
  load_fonts()
  # test for fonts
  check_fonts_in_r(import = FALSE)
}

#' Load installed fonts
#' @export
#' @examples
#' load_fonts()

load_fonts <- function() {
  # load fonts
  # Run it once in every R session
  pdfFonts <- grDevices::pdfFonts
  # extrafont::loadfonts("pdf",quiet=T)
  extrafont::loadfonts(quiet = TRUE)
  # On windows only
  if (.Platform$OS.type == "windows") {
    windowsFonts <- grDevices::windowsFonts
    extrafont::loadfonts(device = "win",quiet = TRUE)
  }
}


#' Tests if fonts are available on the system and import for extrafont
#'
#' @param fonts vector of fonts
#' @param import Logical. Whether to import ttf in R. (Otherwise just check)
#' @param verbose list fonts to install if needed
#'
#' @importFrom utils browseURL unzip
#'
#' @details
#' For fonts to be used, they need to be installed on the machine.
#'
#' @export
#' @examples
#' check_fonts_in_r(import = FALSE)
#'
#' # Test if working
#' \dontrun{
#' library(ggplot2)
#' ggplot(mtcars) +
#'   geom_point(aes(cyl, mpg)) +
#'   labs(title = "Mon titre avec Marianne",
#'        x = "lab X avec Spectral",
#'        y = "Lab Y avec Spectral") +
#'   theme(title = element_text(family = "Marianne"),
#'         axis.title.x = element_text(family = "Spectral"),
#'         axis.title.y = element_text(family = "Spectral")
#'   )
#' }

check_fonts_in_r <- function(fonts = c("Marianne", "Spectral"),
                             import = TRUE,
                             verbose = TRUE) {

  # Import fonts
  if (isTRUE(import)) {
    fonts_no_space <- gsub(" ", "", fonts)
    res <- lapply(fonts_no_space, function(x) {
      res <- attempt::try_catch(
        extrafont::font_import(path = dirname(systemfonts::match_font(x)$path),pattern = x, prompt = FALSE), .e = ~FALSE)
      if (is.null(res)) {res <- TRUE}
      res
    }) %>% unlist()
    names(res) <- fonts

    # load installed fonts
    load_fonts()
  }

  res <- lapply(fonts, function(x) {(extrafont::choose_font(x) != "")}) %>%
    unlist()
  names(res) <- fonts

  # If some are missing
  if (sum(!res) != 0 & isTRUE(verbose)) {
    warning("To use the complete ggplot gouv_theme, you need to install the following fonts on your computer: ",
            paste(names(res)[!res], collapse = ", "), ".",
            "\n  To install, see for instance: https://www.howtogeek.com/192980/how-to-install-remove-and-manage-fonts-on-windows-mac-and-linux/",
            "\n2 - Run gouvdown::check_fonts_in_r() after fonts installation."
    )
  }
  res
}

