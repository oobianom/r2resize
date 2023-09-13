#' Add shiny resize for images
#'
#' Elegant image viewer and resizer for images
#'
#' @export
#'

addShinyImageResizer <- function(){
  ssp <- "r2resize"
  vs <- "0.0.0"
  htmltools::tags$div(
    htmltools::htmlDependency(
    ssp, vs,
    src = file.path(find.package(package = ssp), "themes"),
    stylesheet = "imgviewer.css",
    script = "imgviewer.js",
    all_files = FALSE
    ),
    htmltools::HTML(
      "<b>hello</b>"
    )
  )

}

