#' Elegant viewer functionality for images
#'
#' Provides an elegant image viewer and resizer for images within Shiny applications.
#'
#' @details
#' The `shinyExpandImage` function integrates powerful JavaScript libraries, `justifiedGallery`
#' and `lightGallery`, to transform static image containers into interactive,
#' user-friendly galleries.
#'
#' `justifiedGallery` arranges images in a justified grid layout, ensuring aesthetic
#' presentation regardless of image dimensions. It intelligently fills horizontal
#' space, creating a visually appealing and responsive gallery.
#'
#' `lightGallery` then provides the lightbox functionality. When an image in the
#' gallery is clicked, it expands into a full-screen or modal viewer, offering
#' features such as:
#' \itemize{
#'   \item **Zoom In/Out**: Users can magnify or reduce the image size.
#'   \item **Navigation**: Easy transition between multiple images within the same `imageid` container.
#'   \item **Thumbnail Navigation**: A strip of thumbnails at the bottom for quick jumps between images.
#'   \item **Download**: Option to download the currently viewed image.
#'   \item **Animated Transitions**: Smooth visual effects during image changes.
#' }
#'
#' This function is designed for use in Shiny applications. It takes one or more
#' HTML `div` element IDs as input, where each `div` is expected to contain
#' `<a>` tags wrapping `<img>` tags. The `href` attribute of the `<a>` tag
#' should point to the full-resolution image.
#'
#' @param imageid A character vector containing one or more IDs of HTML `div` elements
#'   that act as containers for images. Each `div` should contain `<a>` tags,
#'   where each `<a>` tag wraps an `<img>` tag. The `href` attribute of the
#'   `<a>` tag should be the source of the high-resolution image to be viewed.
#'
#' @return
#' Returns an `htmltools::tagList` containing an `htmltools::htmlDependency` for
#' the necessary CSS and JavaScript files (`imgviewer.css`, `imgviewer.js`) and
#' multiple `htmltools::tags$script` elements. These script elements initialize
#' the `justifiedGallery` and `lightGallery` functionalities on the specified
#' `imageid` containers, enabling the interactive image viewer features.
#'
#' @section Use case:
#' Use in a shiny application for image(s) that you\'d like to carry a viewer feature on click.\cr\cr
#' When the image is clicked, it is expanded and toolbars appear to allow the user to in zoom in or out, as well as download the image. \cr\cr
#' If there are multiple images within the imageid holder, then they are automatically ordered at the bottom for ease of transition.
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   library(shiny)
#'   library(htmltools)
#'   library(r2resize)
#'
#'   # Example 1: Simple image gallery with a single container ID
#'   shinyApp(
#'     ui = fluidPage(
#'       h3("Single Image Gallery Example"),
#'       shinyExpandImage(c("gallery1")), # Initialize viewer for \'gallery1\'
#'       tags$div(
#'         id = "gallery1",
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/1b.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/1b.jpg",
#'                    alt = "Sample Image 1",
#'                    style = "width: 150px; height: 100px; object-fit: cover;")
#'         ),
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/1.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/1.jpg",
#'                    alt = "Sample Image 2",
#'                    style = "width: 150px; height: 100px; object-fit: cover;")
#'         ),
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/1c.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/1c.jpg",
#'                    alt = "Sample Image 3",
#'                    style = "width: 150px; height: 100px; object-fit: cover;")
#'         )
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Example 2: Multiple image galleries on the same page
#'   shinyApp(
#'     ui = fluidPage(
#'       h3("Multiple Image Galleries Example"),
#'       shinyExpandImage(c("myGalleryA", "myGalleryB")), # Initialize for both galleries
#'
#'       h4("Gallery A: Nature"),
#'       tags$div(
#'         id = "myGalleryA",
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/1b.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/1b.jpg",
#'                    alt = "Nature Image 1",
#'                    style = "width: 120px; height: 80px; object-fit: cover;")
#'         ),
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/1c.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/1c.jpg",
#'                    alt = "Nature Image 2",
#'                    style = "width: 120px; height: 80px; object-fit: cover;")
#'         )
#'       ),
#'
#'       h4("Gallery B: Abstract"),
#'       tags$div(
#'         id = "myGalleryB",
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/1.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/1.jpg",
#'                    alt = "Abstract Image 1",
#'                    style = "width: 100px; height: 100px; object-fit: cover;")
#'         ),
#'         tags$a(
#'           href = "https://r2resize.obi.obianom.com/m/2.jpg",
#'           tags$img(src = "https://r2resize.obi.obianom.com/m/2.jpg",
#'                    alt = "Abstract Image 2",
#'                    style = "width: 100px; height: 100px; object-fit: cover;")
#'         )
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
#' }
#' @family Image and Container Resizing
#' @seealso \code{\link{flexCard}}, \code{\link{elastiCard}}
#' @export
#'
shinyExpandImage <- function(imageid = c()) {
  # declare folder name for htmltools
  vs <- utils::packageVersion(.packageName)
  quickcode::add_key(imageid) # add keys to the vector of ids

  # embed in a div and render
  htmltools::tags$div(
    htmltools::htmlDependency(
      .packageName, vs,
      src = file.path(find.package(package = .packageName), "themes"),
      stylesheet = "imgviewer.css",
      script = "imgviewer.js",
      all_files = FALSE
    ),
    lapply(imageid, function(i)
      htmltools::tags$script(
        paste0("$(document).ready(function() { var $initScope", i$key, ' = $("#', i$value, '"); if ($initScope', i$key, ".length) { $initScope", i$key, '.justifiedGallery( { border: -1, rowHeight: 150, margins: 8, waitThumbnailsLoad: true, randomize: false, }).on("jg.complete", function() { $initScope', i$key, ".lightGallery( { thumbnail: true, animateThumb: true, showThumbByDefault: true, }); }); }; $initScope", i$key, '.on("onAfterOpen.lg", function(event) { $("body").addClass("overflow-hidden"); }); $initScope', i$key, '.on("onCloseAfter.lg", function(event) { $("body").removeClass("overflow-hidden"); }); });'))
    )
  )
}
