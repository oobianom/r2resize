#' @export
#'

addShinyImageResizer <- function(){
  ssp <- "r2resize"
  vs <- "0.0.0"
  template.loc1 <- file.path(find.package(package = ssp), "scripts")
  htmltools::tags$div(
    htmltools::htmlDependency(
    ssp, vs,
    src = template.loc1,
    script = c("dexie.js", paste0(tolower(ssp), ".js")),
    all_files = FALSE
    )
  )

}

