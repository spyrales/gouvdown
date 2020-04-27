#' Colors vector
#'
#' `gouv_colors()` directly gives the colors as hex codes.
#'
#' @param ... The color you want, by code - from `"a0"` to `"r4"` or
#' `"bleu_france"`, `"blanc"`, `"rouge_marianne"`.
#' @return A named vector of character strings. Each value represents the
#'   requested hex code.
#' @references <https://www.gouvernement.fr/charte/charte-graphique-les-fondamentaux/les-couleurs>
#' @export
#' @examples
#' gouv_colors("a1")
#'
gouv_colors <- function(...) {
  # construction de la palette
  vect_col1 <- c(
    "#958B62",
    "#91AE4F",
    "#169B62",
    "#466964",
    "#00AC8C",
    "#5770BE",
    "#484D7A",
    "#FF8D7E",
    "#D08A77",
    "#FFC29E",
    "#FFE800",
    "#FDCF41",
    "#FF9940",
    "#E18B63",
    "#FF6F4C",
    "#7D4E5B",
    "#A26859",
    "#000000"
  )

  vect_col0 <- colorspace::darken(vect_col1, amount = 0.1, method = "relative")
  vect_col2 <- colorspace::lighten(vect_col1, amount = 0.5, method = "relative")
  vect_col3 <- colorspace::lighten(vect_col1, amount = 0.75, method = "relative")
  vect_col4 <- colorspace::lighten(vect_col1, amount = 0.9, method = "relative")

  names(vect_col0) <- paste0(letters[1:18], "0")
  names(vect_col1) <- paste0(letters[1:18], "1")
  names(vect_col2) <- paste0(letters[1:18], "2")
  names(vect_col3) <- paste0(letters[1:18], "3")
  names(vect_col4) <- paste0(letters[1:18], "4")

  # vecteur
  gouv_colors_vector <-
    c(vect_col0, vect_col1, vect_col2, vect_col3, vect_col4)

  # ajout du bleu/blanc/rouge
  gouv_colors_vector <- c(
    "bleu_france" = "#000091",
    "blanc" = "#FFFFFF",
    "rouge_marianne" = "#E1000F",
    gouv_colors_vector
  )

  # interrogation
  cols <- c(...)

  if (is.null(cols))
    return (gouv_colors_vector)

  gouv_colors_vector[cols]
}

#' Palettes interpolation
#'
#' @param palette Character name of palette in [gouv_palettes].
#' @param reverse Boolean indicating whether the palette should be reversed.
#' @param ... Additional arguments to pass to [grDevices::colorRampPalette()].
#' @return A function that takes an integer argument (the required number of
#'   colors) and returns a character vector of colors (see [grDevices::rgb])
#'   interpolating the given sequence.
#' @keywords internal
#'
gouv_pal_inter <- function(palette = "pal_gouv_fr", reverse = FALSE, ...) {
  pal <- gouvdown::gouv_palettes[[palette]]

  if (isTRUE(reverse))
    pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}

#' Discrete color scale
#'
#' @inheritParams gouv_pal_inter
#' @param ... Additional arguments passed to [ggplot2::discrete_scale()].
#'
#' @export
#'
scale_color_gouv_discrete <- function(
  palette = "pal_gouv_fr", reverse = FALSE, ...
) {
  pal <- gouv_pal_inter(palette = palette, reverse = reverse)

  ggplot2::discrete_scale("color", paste0("gouv_", palette), palette = pal,
                          ...)
}

#' Discrete fill scale
#'
#' @inheritParams gouv_pal_inter
#' @inheritDotParams scale_color_gouv_discrete
#'
#' @export
#'
scale_fill_gouv_discrete <- function(
  palette = "pal_gouv_fr", reverse = FALSE, ...
) {
  pal <- gouv_pal_inter(palette = palette, reverse = reverse)

  ggplot2::discrete_scale("fill", paste0("gouv_", palette), palette = pal, ...)
}


#' Continuous color scale
#'
#' @inheritParams gouv_pal_inter
#' @param ... Additional arguments passed to [ggplot2::scale_color_gradientn()].
#'
#' @export
#'
scale_color_gouv_continuous <- function(
  palette = "pal_gouv_a", reverse = FALSE, ...
) {
  pal <- gouv_pal_inter(palette = palette, reverse = reverse)

  ggplot2::scale_color_gradientn(colors = pal(256), ...)
}

#' Continuous fill scale
#'
#' @inheritParams gouv_pal_inter
#' @param ... Additional arguments passed to [ggplot2::scale_fill_gradientn()].
#'
#' @export
#'
scale_fill_gouv_continuous <- function(
  palette = "pal_gouv_a", reverse = FALSE, ...
) {
  pal <- gouv_pal_inter(palette = palette, reverse = reverse)

  ggplot2::scale_fill_gradientn(colors = pal(256), ...)
}
