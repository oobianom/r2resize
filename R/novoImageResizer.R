#' Add shiny resize for images
#'
#' Elegant image viewer and resizer for images
#'
#' @export
#'

addShinyImageResizer <- function(){
  ssp <- "r2resize"
  vs <- "0.0.0"
  template.loc1 <- file.path(find.package(package = ssp), "themes")
  htmltools::tags$div(
    htmltools::htmlDependency(
    ssp, vs,
    src = template.loc1,
    stylesheet = "imgviewer.css",
    script = "imgviewer.js",
    all_files = FALSE
    )
  )

}

