#' Colors palettes for France design system
#'
#' ```{r palettes, echo=FALSE}
#' pal <- gouvdown::gouv_palettes
#' labels <- names(pal)
#' do.call(pals::pal.bands,
#'         c(pal, list(labels = labels, gap = 0.2, main = "gouvdown palettes"))
#' )
#' ```
#'
#' @format A named list with `r length(gouvdown::gouv_palettes)` palettes.
#' @inherit gouv_colors references
"gouv_palettes"
