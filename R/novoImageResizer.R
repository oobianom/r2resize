#' Add shiny resize for images
#'
#' Elegant image viewer and resizer for images
#'
#' @param imageid one or more IDs of a div containing images
#'
#' @return Feature that allows images to be easily expanded and viewed
#'
#' @section Use case:
#' Use in a shiny application for image(s) that you'd like to carry a viewer feature on click.\cr\cr
#' When the image is clicked, it is expanded and toolbars appear to allow the user to in zoom in or out, as well as download the image. \cr\cr
#' if there are multiple images within the imageid holder, then they are automatically ordered at the bottom for ease of transition.
#'
#' @examples
#' # simple expansion for images
#' if(interactive()){
#'   shinyApp(
#'     ui = fluidPage(),
#'     server = (function(input, output){})
#'   )
#' }
#'
#' @export

shinyExpandImage <- function(imageid = c()) {
  # declare folder name for htmltools
  ssp <- "r2resize"
  vs <- "0.0.0"
  quickcode::add_key(imageid) # add keys to the vector of ids

  # embed in a div and render
  htmltools::tags$div(
    htmltools::htmlDependency(
      ssp, vs,
      src = file.path(find.package(package = ssp), "themes"),
      stylesheet = "imgviewer.css",
      script = "imgviewer.js",
      all_files = FALSE
    ),
    lapply(imageid, function(i) {
      htmltools::tags$script(paste0("$(document).ready(function() { var $initScope", i$key, ' = $("#', i$value, '"); if ($initScope', i$key, ".length) { $initScope", i$key, '.justifiedGallery( { border: -1, rowHeight: 150, margins: 8, waitThumbnailsLoad: true, randomize: false, }).on("jg.complete", function() { $initScope', i$key, ".lightGallery( { thumbnail: true, animateThumb: true, showThumbByDefault: true, }); }); }; $initScope", i$key, '.on("onAfterOpen.lg", function(event) { $("body").addClass("overflow-hidden"); }); $initScope', i$key, '.on("onCloseAfter.lg", function(event) { $("body").removeClass("overflow-hidden"); }); });'))
    })
  )
}
