#' Obtenir les couleurs de la charte graphique
#'
#' gouv_colors() donne directement les couleurs principales
#' de la charte graphique
#'
#' @param ... La couleur souhaitée
#'
#' @return
#' @export
#'
#' @import dplyr
#' @importFrom stringr str_to_title
#' @importFrom tibble tibble
#' @importFrom colorspace darken
#' @importFrom colorspace lighten
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_longer
#'
#' @examples
#' gouv_colors("a1")
#'
gouv_colors <- function(...) {
  # construction de la palette
  gouv_colors_tibble <- tibble(
    name = letters[1:18],
    vect_col1 = c(
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
    ),
    vect_col0 = darken(vect_col1, amount = 0.1, method = "relative"),
    vect_col2 = lighten(vect_col1, amount = 0.5, method = "relative"),
    vect_col3 = lighten(vect_col1, amount = 0.75, method = "relative"),
    vect_col4 = lighten(vect_col1, amount = 0.9, method = "relative")
  ) %>%
    pivot_longer(-name,
                 names_to = c("vect_col", "number"),
                 names_pattern = "(.*[vect_col])(.*)") %>%
    mutate(names_col = paste0(name, number)) %>%
    arrange(names_col) %>%
    filter(names_col != "r0")

  # vecteur
  gouv_colors_vector <- (gouv_colors_tibble$value)
  names(gouv_colors_vector) <- gouv_colors_tibble$names_col

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

  gouv_colors_vector[cols] %>%
    as.vector()
}

# Definition des palettes
gouv_palettes <- list(
  "pal_gouv_fr" = gouv_colors("bleu_france", "blanc", "rouge_marianne"),
  "pal_gouv_a" = gouv_colors("a0", "a1", "a2", "a3", "a4"),
  "pal_gouv_b" = gouv_colors("b0", "b1", "b2", "b3", "b4"),
  "pal_gouv_c" = gouv_colors("c0", "c1", "c2", "c3", "c4"),
  "pal_gouv_d" = gouv_colors("d0", "d1", "d2", "d3", "d4"),
  "pal_gouv_e" = gouv_colors("e0", "e1", "e2", "e3", "e4"),
  "pal_gouv_f" = gouv_colors("f0", "f1", "f2", "f3", "f4"),
  "pal_gouv_g" = gouv_colors("g0", "g1", "g2", "g3", "g4"),
  "pal_gouv_h" = gouv_colors("h0", "h1", "h2", "h3", "h4"),
  "pal_gouv_i" = gouv_colors("i0", "i1", "i2", "i3", "a4"),
  "pal_gouv_j" = gouv_colors("j0", "j1", "j2", "j3", "j4"),
  "pal_gouv_k" = gouv_colors("k0", "k1", "k2", "k3", "k4"),
  "pal_gouv_l" = gouv_colors("l0", "l1", "l2", "l3", "l4"),
  "pal_gouv_m" = gouv_colors("m0", "m1", "m2", "m3", "m4"),
  "pal_gouv_n" = gouv_colors("n0", "n1", "n2", "n3", "n4"),
  "pal_gouv_o" = gouv_colors("o0", "o1", "o2", "o3", "o4"),
  "pal_gouv_p" = gouv_colors("p0", "p1", "p2", "p3", "p4"),
  "pal_gouv_q" = gouv_colors("q0", "q1", "q2", "q3", "a4"),
  "pal_gouv_r" = gouv_colors("r1", "r2", "r3", "r4"),
  "pal_gouv_qual1" = gouv_colors(paste0(letters[1:18], "1")),
  "pal_gouv_qual2" = gouv_colors("c1", "f1", "h1", "k1", "p1"),
  "pal_gouv_div1" = gouv_colors("f0", "f1", "f2", "f3", "f4", "h4", "h3", "h2", "h1", "h0"),
  "pal_gouv_div2" = gouv_colors("p0", "p1", "p2", "p3", "p4", "c4", "c3", "c2", "c1", "c0")
)

usethis::use_data(gouv_palettes, overwrite = TRUE)

#' Interpolation des palettes
#'
#' @param palette Character name of palette in omni_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#' @keywords internal
#'
#' @importFrom grDevices colorRampPalette
#'
gouv_pal_inter <-
  function(palette = "pal_gouv_fr",
           reverse = FALSE,
           ...) {
    pal <- gouv_palettes[[palette]]

    if (reverse)
      pal <- rev(pal)

    colorRampPalette(pal, ...)
  }

#' Echelle de couleur discrète
#'
#' @param palette Nom de la palette
#' @param reverse Palette inversée ou non
#' @param ... Additional arguments
#'
#' @importFrom ggplot2 discrete_scale
#'
#' @export
#' @example
#' iris %>%
#'  ggplot(aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
#'  geom_point() +
#'  scale_color_gouv_discrete(palette = "pal_gouv_i")
#'
scale_color_gouv_discrete <-
  function(palette = "pal_gouv_fr",
           reverse = FALSE,
           ...) {
    pal <- gouv_pal_inter(palette = palette, reverse = reverse)

    discrete_scale("color", paste0("gouv_", palette), palette = pal, ...)

  }

#' Echelle de fill discrète
#'
#' @param palette Nom de la palette
#' @param reverse Palette inversée ou non
#' @param ... Additional arguments
#'
#' @importFrom ggplot2 discrete_scale
#'
#' @export
#'
scale_fill_gouv_discrete <-
  function(palette = "pal_gouv_fr",
           reverse = FALSE,
           ...) {
    pal <- gouv_pal_inter(palette = palette, reverse = reverse)

    ggplot2::discrete_scale("fill", paste0("gouv_", palette), palette = pal, ...)
  }


#' Echelle de couleur continue
#'
#' @param palette Nom de la palette
#' @param reverse Palette inversée ou non
#' @param ... Additional arguments
#'
#' @importFrom ggplot2 scale_color_gradientn
#'
#' @export
#'

scale_color_gouv_continuous <-
  function(palette = "pal_gouv_a",
           reverse = FALSE,
           ...) {
    pal <- gouv_pal_inter(palette = palette, reverse = reverse)

    scale_color_gradientn(colors = pal(256), ...)

  }

#' Echelle de fill continue
#'
#' @param palette Nom de la palette
#' @param reverse Palette inversée ou non
#' @param ... Additional arguments
#'
#' @importFrom ggplot2 scale_fill_gradientn
#'
#' @export
#'
scale_fill_gouv_continuous <-
  function(palette = "pal_gouv_a",
           reverse = FALSE,
           ...) {
    pal <- gouv_pal_inter(palette = palette, reverse = reverse)

    scale_fill_gradientn(colors = pal(256), ...)
  }
