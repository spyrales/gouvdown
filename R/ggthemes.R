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

#' ggplot2 theme with french government design template
#'
#' @details All font sizes are set in points and colors are either a color name or a hex code.
#' @param base_family,base_size Base font family and size.
#' @param plot_title_family,plot_title_face,plot_title_size,plot_title_margin Plot title family, face, size and margin.
#' @param subtitle_family,subtitle_face,subtitle_size Plot subtitle family, face and size.
#' @param subtitle_margin Plot subtitle margin bottom (single numeric value).
#' @param strip_text_family,strip_text_face,strip_text_size,strip_text_color Facet label font family, face, size and color.
#' @param strip_background_color Facel label background color.
#' @param caption_family,caption_face,caption_size,caption_margin Plot caption family, face, size and margin.
#' @param axis_title_family,axis_title_face,axis_title_size Axis title font family, face and size.
#' @param axis_title_just Axis title font justification, one of `[blmcrt]`.
#' @param plot_margin Plot margin (specify with `ggplot2::margin()`).
#' @param grid_col,axis_col Grid and axis colors; defaults: `#888888` for grid color and `#CCCCCC` for axis color.
#' @param grid Panel grid (`TRUE`, `FALSE` or a combination of `X`, `x`, `Y`, `y`).
#' @param panel_background_color Panel background fill color; default to `white`.
#' @param panel_border_color Panel border color; default to `white`.
#' @param legend_background_color Legend background fill color; default to `white`.
#' @param legend_border_color Legend border color; default to `white`.
#' @param axis_text_size Font size of axis text.
#' @param axis Add x or y axes? `TRUE`, `FALSE` or "`xy`".
#' @param ticks Ticks: if `TRUE`, add ticks.
#'
#' @importFrom ggplot2 element_blank element_line element_text margin theme element_rect
#' @return A `ggplot2` theme.
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#'   geom_point(aes(color = Species, shape = Species)) +
#'   labs(
#'     x = "Sepal Length", y = "Sepal Width",
#'     title = "Sepal Length-Width",
#'     subtitle = "with theme_gouv()"
#'   ) +
#'   theme_gouv() +
#'   scale_color_gouv_discrete()
#' }
#'
theme_gouv <- function(base_family = "Spectral", base_size = 12,
                       plot_title_family = "Marianne", plot_title_size = 28,
                       plot_title_face = "bold", plot_title_margin = 10,
                       subtitle_family = "Marianne Light", subtitle_size = 22,
                       subtitle_face = "plain", subtitle_margin = 15,
                       strip_text_family = base_family, strip_text_size = 22,
                       strip_text_face = "plain", strip_text_color = "black",
                       strip_background_color = "#FFFFFF",
                       caption_family = base_family, caption_size = 12,
                       caption_face = "plain", caption_margin = 10,
                       axis_text_size = base_size,
                       axis_title_family = subtitle_family, axis_title_size = base_size,
                       axis_title_face = "plain", axis_title_just = "rt",
                       plot_margin = margin(30, 30, 30, 30),
                       grid_col = "#888888", grid = TRUE,
                       panel_background_color = "#FFFFFF",
                       panel_border_color = "#FFFFFF",
                       legend_background_color = "#FFFFFF",
                       legend_border_color = "#FFFFFF",
                       axis_col = "#CCCCCC", axis = FALSE, ticks = FALSE) {
  ret <- ggplot2::theme_minimal(base_family = base_family, base_size = base_size)

  ret <- ret + theme(legend.background = element_rect(
    fill = legend_background_color,
    color = legend_border_color
  ))
  ret <- ret + theme(legend.key = element_blank())

  if (inherits(grid, "character") | grid == TRUE) {
    ret <- ret + theme(panel.grid = element_line(color = grid_col, size = 0.2, linetype = "dotted"))
    ret <- ret + theme(panel.grid.major = element_line(color = grid_col, size = 0.2, linetype = "dotted"))
    ret <- ret + theme(panel.grid.minor = element_line(color = grid_col, size = 0.15, linetype = "dotted"))
    ret <- ret + theme(panel.background = element_rect(fill = panel_background_color, color = panel_border_color, size = 0.15))

    if (inherits(grid, "character")) {
      if (regexpr("X", grid)[1] < 0) ret <- ret + theme(panel.grid.major.x = element_blank())
      if (regexpr("Y", grid)[1] < 0) ret <- ret + theme(panel.grid.major.y = element_blank())
      if (regexpr("x", grid)[1] < 0) ret <- ret + theme(panel.grid.minor.x = element_blank())
      if (regexpr("y", grid)[1] < 0) ret <- ret + theme(panel.grid.minor.y = element_blank())
    }
  } else {
    ret <- ret + theme(panel.grid = element_blank())
  }

  if (inherits(axis, "character") | axis == TRUE) {
    ret <- ret + theme(axis.line = element_line(color = "#2b2b2b", size = 0.15))
    if (inherits(axis, "character")) {
      axis <- tolower(axis)
      if (regexpr("x", axis)[1] < 0) {
        ret <- ret + theme(axis.line.x = element_blank())
      } else {
        ret <- ret + theme(axis.line.x = element_line(color = axis_col, size = 0.15))
      }
      if (regexpr("y", axis)[1] < 0) {
        ret <- ret + theme(axis.line.y = element_blank())
      } else {
        ret <- ret + theme(axis.line.y = element_line(color = axis_col, size = 0.15))
      }
    } else {
      ret <- ret + theme(axis.line.x = element_line(color = axis_col, size = 0.15))
      ret <- ret + theme(axis.line.y = element_line(color = axis_col, size = 0.15))
    }
  } else {
    ret <- ret + theme(axis.line = element_blank())
  }

  if (!ticks) {
    ret <- ret + theme(axis.ticks = element_blank())
    ret <- ret + theme(axis.ticks.x = element_blank())
    ret <- ret + theme(axis.ticks.y = element_blank())
  } else {
    ret <- ret + theme(axis.ticks = element_line(size = 0.15))
    ret <- ret + theme(axis.ticks.x = element_line(size = 0.15))
    ret <- ret + theme(axis.ticks.y = element_line(size = 0.15))
    ret <- ret + theme(axis.ticks.length = grid::unit(5, "pt"))
  }

  xj <- switch(tolower(substr(axis_title_just, 1, 1)), b = 0, l = 0, m = 0.5, c = 0.5, r = 1, t = 1)
  yj <- switch(tolower(substr(axis_title_just, 2, 2)), b = 0, l = 0, m = 0.5, c = 0.5, r = 1, t = 1)

  ret <- ret + theme(axis.text.x = element_text(size = axis_text_size, margin = margin(t = 0)))
  ret <- ret + theme(axis.text.y = element_text(size = axis_text_size, margin = margin(r = 0)))
  ret <- ret + theme(axis.title = element_text(size = axis_title_size, family = axis_title_family))
  ret <- ret + theme(axis.title.x = element_text(
    hjust = xj, size = axis_title_size,
    family = axis_title_family, face = axis_title_face
  ))
  ret <- ret + theme(axis.title.y = element_text(
    hjust = yj, size = axis_title_size,
    family = axis_title_family, face = axis_title_face
  ))
  ret <- ret + theme(axis.title.y.right = element_text(
    hjust = yj, size = axis_title_size, angle = 90,
    family = axis_title_family, face = axis_title_face
  ))
  ret <- ret + theme(
    strip.text = element_text(
      hjust = 0, size = strip_text_size, color = strip_text_color,
      face = strip_text_face, family = strip_text_family
    ),
    strip.background = element_rect(fill = strip_background_color)
  )

  ret <- ret + theme(panel.spacing = grid::unit(2, "lines"))
  ret <- ret + theme(plot.title = element_text(
    hjust = 0, size = plot_title_size,
    margin = margin(b = plot_title_margin),
    family = plot_title_family, face = plot_title_face
  ))
  ret <- ret + theme(plot.subtitle = element_text(
    hjust = 0, size = subtitle_size,
    margin = margin(b = subtitle_margin),
    family = subtitle_family, face = subtitle_face
  ))
  ret <- ret + theme(plot.title.position = "plot")
  ret <- ret + theme(plot.caption = element_text(
    hjust = 1, size = caption_size,
    margin = margin(t = caption_margin),
    family = caption_family, face = caption_face
  ))
  ret <- ret + theme(plot.margin = plot_margin)

  ret
}

#' ggplot2 grey theme with french government design template
#'
#' @param ... Other params passed to `theme_gouv()`.
#' @return A `ggplot2` theme.
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
#'   geom_point(aes(color = Species, shape = Species)) +
#'   labs(
#'     x = "Sepal Length", y = "Sepal Width",
#'     title = "Sepal Length-Width",
#'     subtitle = "with gouv_theme()"
#'   ) +
#'   theme_grey_gouv() +
#'   scale_color_gouv_discrete(palette = "pal_gouv_fr")
#' }
#'
theme_grey_gouv <- function(...) {
  theme_gouv(...,
    grid_col = "#FFFFFF",
    panel_background_color = "#C0C0C0",
    panel_border_color = "#888888",
    legend_background_color = "#C0C0C0",
    legend_border_color = "#888888"
  )
}

#' ggplot2 theme for map with French government design template
#'
#' @details
#' This theme is designed for making map with ggplot plot with `ggplot2::geom_sf()`.
#' All font sizes are set in points and colors are either a color name or a hex code.
#' @param base_family,base_size Base font family and size.
#' @param plot_title_family,plot_title_face,plot_title_size,plot_title_margin Plot title family, face, size and margin.
#' @param subtitle_family,subtitle_face,subtitle_size Plot subtitle family, face and size.
#' @param subtitle_margin Plot subtitle margin bottom (single numeric value).
#' @param strip_text_family,strip_text_face,strip_text_size,strip_text_color Facet label font family, face, size and color.
#' @param strip_background_color Facel label background color.
#' @param caption_family,caption_face,caption_size,caption_margin Plot caption family, face, size and margin.
#' @param plot_margin Plot margin (specify with `ggplot2::margin()`).
#' @param legend_background_color Legend background fill color; default to `white`.
#' @param legend_border_color Legend border color; default to `white`.
#'
#' @importFrom ggplot2 element_blank element_line element_text margin theme element_rect
#' @return A `ggplot2` theme.
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(sf)
#' demo(nc, ask = FALSE, echo = FALSE)
#'
#' ggplot(data = nc) +
#'   geom_sf(aes(fill = BIR79)) +
#'   theme_gouv_map() +
#'   scale_color_gouv_continuous() +
#'   labs(title = "North Carolina SIDS", subtitle = "with theme_gouv_map()")
#' }
theme_gouv_map <- function(base_family = "Spectral", base_size = 12,
                           plot_title_family = "Marianne", plot_title_size = 28,
                           plot_title_face = "bold", plot_title_margin = 10,
                           subtitle_family = "Marianne Light", subtitle_size = 22,
                           subtitle_face = "plain", subtitle_margin = 15,
                           strip_text_family = base_family, strip_text_size = 14,
                           strip_text_face = "plain", strip_text_color = "black",
                           strip_background_color = "#FFFFFF",
                           caption_family = base_family, caption_size = 12,
                           caption_face = "plain", caption_margin = 10,
                           plot_margin = margin(30, 30, 30, 30),
                           legend_background_color = "#FFFFFF",
                           legend_border_color = "#FFFFFF") {
  ret <- ggplot2::theme_minimal(base_family = base_family, base_size = base_size)

  ret <- ret + theme(legend.background = element_rect(
    fill = legend_background_color,
    color = legend_border_color
  ))
  ret <- ret + theme(legend.key = element_blank())

  ret <- ret + theme(panel.grid = element_blank())
  ret <- ret + theme(panel.background = element_blank())
  ret <- ret + theme(panel.border = element_blank())
  ret <- ret + theme(panel.grid = element_blank())
  ret <- ret + theme(plot.background = element_blank())
  ret <- ret + theme(axis.line = element_blank())
  ret <- ret + theme(axis.text = element_blank())
  ret <- ret + theme(axis.ticks = element_blank())
  ret <- ret + theme(axis.title = element_blank())


  ret <- ret + theme(
    strip.text = element_text(
      hjust = 0, size = strip_text_size, color = strip_text_color,
      face = strip_text_face, family = strip_text_family
    ),
    strip.background = element_rect(fill = strip_background_color)
  )

  ret <- ret + theme(panel.spacing = grid::unit(2, "lines"))

  ret <- ret + theme(plot.title = element_text(
    hjust = 0, size = plot_title_size,
    margin = margin(b = plot_title_margin),
    family = plot_title_family, face = plot_title_face
  ))

  ret <- ret + theme(plot.subtitle = element_text(
    hjust = 0, size = subtitle_size,
    margin = margin(b = subtitle_margin),
    family = subtitle_family, face = subtitle_face
  ))

  ret <- ret + theme(plot.title.position = "plot")

  ret <- ret + theme(plot.caption = element_text(
    hjust = 1, size = caption_size,
    margin = margin(t = caption_margin),
    family = caption_family, face = caption_face
  ))

  ret <- ret + theme(plot.margin = plot_margin)

  ret
}
