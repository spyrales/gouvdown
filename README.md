
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gouvdown

<!-- badges: start -->

[![R build
status](https://github.com/spyrales/gouvdown/workflows/R-CMD-check/badge.svg)](https://github.com/spyrales/gouvdown/actions)
[![Codecov test
coverage](https://codecov.io/gh/spyrales/gouvdown/branch/master/graph/badge.svg)](https://codecov.io/gh/spyrales/gouvdown?branch=master)
[![R-CMD-check](https://github.com/spyrales/gouvdown/workflows/R-CMD-check/badge.svg)](https://github.com/spyrales/gouvdown/actions)
<!-- badges: end -->

**gouvdown** let you write R Markdown documents which comply with the
French government design system.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("spyrales/gouvdown")
```

## Palettes

**gouvdown** provides the official colors and a set of palettes.

<img src="man/figures/README-palettes-1.png" width="100%" />

## Theme

**gouvdown** provides themes for `{ggplot2}` graphics and maps.

<img src="man/figures/README-theme-1.png" width="100%" />

## Rmarkdown

### html_document

**gouvdown** provides a html template for `{Rmarkdown}`

![](man/figures/html_gouv.png)

### bookdown

**gouvdown** provides a bookdown project template for `{bookdown}`

![](man/figures/gouvbook.png)

### pagedown

**gouvdown** provides a bookdown project template for `{pagedown}`

**CAPTURE ECRAN A AJOUTER UNE FOIS FINALISE**

This template is generated through a Github Action for Linux, Windows
and MacOS and uploaded as an artifact. This aims at helping to follow
the development of `{pagedown}` by providing a visual check.

### Word output format

**gouvdown** provides a word template for `{Rmarkdown}` for writing an
official letter.

## References

-   Design system:
    <https://www.gouvernement.fr/charte/charte-graphique-les-fondamentaux/introduction>
-   Example:
    <https://github.com/DISIC/design.numerique.gouv.fr/tree/master/src/assets>
