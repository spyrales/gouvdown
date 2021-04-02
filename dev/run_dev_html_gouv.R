## Script pour les modifs en live
local({
  all_attached <- paste("package:", names(sessionInfo()$otherPkgs),
                        sep = "")
  try(suppressWarnings(lapply(all_attached,
                              detach, character.only = TRUE, unload = TRUE)), silent = TRUE)

  pkgload::load_all()

  file_rmd <- system.file("rmarkdown", "templates", "gouvdown_html_document", "skeleton", "skeleton.Rmd", package = "gouvdown")

  ok <- rmarkdown::render(
    file_rmd,
    output_format = gouvdown::html_gouv()
  )
  browseURL(ok)
})
