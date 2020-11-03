# gouvdown 0.0.0.9000

* Add logos for regional prefecture and 3 ministries

* Added `Book project using gouvdown` template

* Added `html_gouv()` rmarkdown template and `create_header_html_gouv()` function to make html report.

* Added a vignette on using the `scale_` and `theme_gouv_` functions.

* Added a `pkgdown` Actions.

* Added several helper functions for logos management: `list_logos()` to list logos contained in `gouvdown`, `logo_file_path()` to retrieve the logos file paths on system, `gglogo()` and `add_plot_header()` to add a logo in a ggplot2 plot object (#15).

* Added the official Marianne and French government logos (#15). 

* Added `theme_gouv()` `theme_gouv_map()` and `theme_grey_gouv()` (#1 and #15) ggplot2 themes

* Display the palettes in the documentation (#14).

* Added colors helper functions (#11).

* Added `CONTRIBUTING.md` and `CODE_OF_CONDUCT.md` (#9).

* Created a `marianne_font_dep()` function which returns HTML dependencies for
the Marianne font.

* Licence is updated after `gouvdown.fonts` creation.

* Created a `spectral_font_dep()` function which returns HTML dependencies for
the Spectral font.

* Created `inst/resources` directory and `pkg_resource()` function for 
resources management.

* Added a `NEWS.md` file to track changes to the package.
