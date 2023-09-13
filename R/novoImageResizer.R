#' Add shiny resize for images
#'
#' Elegant image viewer and resizer for images
#'
#' @export
#'

addShinyImageResizer <- function(imageid){
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
    lapply(imageid,function(i)
    htmltools::tags$script(paste0('$(document).ready(function() { var $initScope = $("#',i,'"); if ($initScope.length) { $initScope.justifiedGallery( { border: -1, rowHeight: 150, margins: 8, waitThumbnailsLoad: true, randomize: false, }).on("jg.complete", function() { $initScope.lightGallery( { thumbnail: true, animateThumb: true, showThumbByDefault: true, }); }); }; $initScope.on("onAfterOpen.lg", function(event) { $("body").addClass("overflow-hidden"); }); $initScope.on("onCloseAfter.lg", function(event) { $("body").removeClass("overflow-hidden"); }); });'))
    )
    )

}

