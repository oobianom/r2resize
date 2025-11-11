#' Configure and add a dynamic resizing toolbar to HTML documents
#'
#' This function allows the inclusion and configuration of a responsive toolbar in HTML outputs,
#' enabling users to dynamically resize images and tables within the document. It provides
#' fine-grained control over the toolbar's appearance and behavior, enhancing the interactivity
#' and user experience of R Markdown documents, Shiny applications, or any HTML output.
#'
#' @param theme.color A character string specifying the theme color for the resizer and table elements (e.g., "black" or "#000000").
#' @param position A character string indicating the position of the resize toolbar, either "top" or "bottom".
#' @param font.size A character string specifying the font size of the page elements in pixels (e.g., "14px").
#' @param font.color A character string specifying the font color of the page elements (e.g., "darkblue" or "#006699").
#' @param tables A logical value (TRUE or FALSE). If TRUE, the resize toolbar will be added to HTML tables.
#' @param images A logical value (TRUE or FALSE). If TRUE, the resize toolbar will be added to HTML images.
#' @param line.color A character string specifying the color of the resizer track (e.g., "red" or "#f5f5f5").
#' @param thumb.width A numeric value specifying the width of the resizer thumb.
#' @param thumb.height A numeric value specifying the height of the resizer thumb.
#' @param line.width A numeric value specifying the width of the resizer track.
#' @param line.height A numeric value specifying the height of the resizer track.
#' @param dim.units A character string specifying the unit for the height and width of the track or thumb (e.g., "px").
#' @param default.image.width A character string specifying the default width of all images on the page (e.g., "100\%", "500px").
#'
#' @details
#' The `add.resizer` function injects necessary CSS and JavaScript into your HTML document
#' to create interactive resizing capabilities. It dynamically modifies the dimensions of
#' images and tables based on user interaction with the generated toolbar. This is particularly
#' useful for documents where content responsiveness and user-controlled viewing preferences
#' are important.
#'
#' The function relies on an internal templating system to fetch and customize the
#' CSS and JavaScript files. Parameters like `theme.color`, `font.size`, `line.color`,
#' and dimension-related arguments directly influence the visual styling of the toolbar
#' and the initial appearance of content.
#'
#' For Shiny applications, this function should be called within the UI to ensure the
#' necessary scripts and styles are loaded when the application starts. In R Markdown
#' documents, simply including a call to `add.resizer()` will integrate the toolbar
#' into the knitted HTML output.
#'
#' @section Examples for r2resize:
#' More examples and demo pages for this function are located at this link -
#' \url{https://r2resize.obi.obianom.com}.
#'
#' @return An HTML script tag containing the necessary CSS and JavaScript for the
#'   resizing toolbar, applied as an `html` object.
#'
#' @family Interactive Components
#' @seealso \code{\link{splitCard}}, \code{\link{shinyExpandImage}}
#'
#' @examples
#' # Default settings: adds resizer to both tables and images at the top
#' r2resize::add.resizer()
#'
#' # Add resizer to only images, placed at the bottom of the page
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(
#'       r2resize::add.resizer(
#'         tables = FALSE,
#'         images = TRUE,
#'         position = "bottom"
#'       ),
#'       shiny::tags$img(src = "https://via.placeholder.com/150", width = "100px"),
#'       shiny::h3("Only images will have a resizer toolbar.")
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
#'
#' # Add resizer to only tables with a specific theme color and font size
#' if (interactive()) {
#'   shiny::shinyApp(
#'     ui = shiny::fluidPage(
#'       r2resize::add.resizer(
#'         tables = TRUE,
#'         images = FALSE,
#'         theme.color = "darkgreen",
#'         font.size = "16px"
#'       ),
#'       shiny::h3("Table with resizer:"),
#'       shiny::renderTable(data.frame(
#'         A = 1:3,
#'         B = LETTERS[1:3]
#'       ))
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
#'
#' # Customize resizer line color, width, and height, and set default image width
#' r2resize::add.resizer(
#'   line.color = "#FF5733",
#'   line.width = 250,
#'   line.height = 10,
#'   thumb.width = 30,
#'   thumb.height = 30,
#'   dim.units = "pt",
#'   default.image.width = "60%"
#' )
#'
#' # Full customization example for R Markdown or Shiny
#' \dontrun{
#'   # In an R Markdown document or Shiny UI:
#'   add.resizer(
#'     theme.color = "purple",
#'     position = "top",
#'     font.size = "13px",
#'     font.color = "#4A148C",
#'     tables = TRUE,
#'     images = TRUE,
#'     line.color = "#C2185B",
#'     thumb.width = 28,
#'     thumb.height = 28,
#'     line.width = 200,
#'     line.height = 8,
#'     dim.units = "px",
#'     default.image.width = "75%"
#'   )
#' }
#'
#' @export

add.resizer <- function(theme.color = NULL,
                        position = c("top", "bottom"),
                        font.size = NULL,
                        font.color = NULL,
                        tables = TRUE,
                        images = TRUE,
                        line.color = NULL,
                        thumb.width = NULL,
                        thumb.height = NULL,
                        line.width = NULL,
                        line.height = NULL,
                        dim.units = "px",
                        default.image.width = NULL) {
  # fetch selected position
  position <- match.arg(position)

  # set initial content
  con <- ""

  # get thumb properties
  thumb.2width <- ifelse(is.null(thumb.width), "26px", paste0(as.numeric(thumb.width) + 6, dim.units))
  thumb.2height <- ifelse(is.null(thumb.height), "26px", paste0(as.numeric(thumb.height) + 6, dim.units))
  thumb.width <- ifelse(is.null(thumb.width), "20px", paste0(thumb.width, dim.units))
  thumb.height <- ifelse(is.null(thumb.height), "20px", paste0(thumb.height, dim.units))
  line.width <- ifelse(is.null(line.width), "170px", paste0(line.width, dim.units))
  line.height <- ifelse(is.null(line.height), "7px", paste0(line.height, dim.units))



  # extract template
  theme.01 <- "default"

  # fetch css
  theme.02.css <- paste0(template.loc(), "/", theme.01, ".css")
  if (file.exists(theme.02.css)) {
    con <- c(con, "<style>", readLines(theme.02.css), "</style>")
  }

  # fetch js
  theme.02.js <- paste0(template.loc(), "/", theme.01, "_", position, ".js")
  if (file.exists(theme.02.js)) {
    con <- c(con, "<script>", readLines(theme.02.js), "</script>")
    con <- gsub("listgroupixon", "xxxxx", con)
    if (!is.null(default.image.width)) {
      con <- gsub("'pre3e2423'", paste0("'", default.image.width, "'"), con)
    }
  }

  # font size
  if (!is.null(font.size)) {
    con <- gsub("fontsizedefault", font.size, con)
  }

  # font color
  if (!is.null(font.color)) {
    con <- gsub("fontcolordefault", font.color, con)
  }


  # add resize to image or/and tables
  if (!tables) {
    con <- gsub("table", "rm12table", con)
  }
  if (!images) {
    con <- gsub("img", "rm12img", con)
  }

  # sub other properties
  if (!is.null(theme.color)) {
    con <- gsub("gray", theme.color, con)
  }
  if (!is.null(line.color)) {
    con <- gsub("#cfae7c", line.color, con)
  }
  if (!is.null(font.color)) {
    con <- gsub("fontcolorplaceholder", font.color, con)
  }

  # sub properties in content
  con <- gsub("thumb.width", thumb.width, con)
  con <- gsub("thumb.height", thumb.height, con)
  con <- gsub("thumb.2width", thumb.2width, con)
  con <- gsub("thumb.2height", thumb.2height, con)
  con <- gsub("line.width", line.width, con)
  con <- gsub("line.height", line.height, con)

  # combine and collapse content
  con <- paste(con, collapse = "")

  # set to html
  attr(con, "html") <- TRUE
  class(con) <- c("html", "character")

  # return content
  con
}

template.loc <- function(template = "themes") {
  file.path(find.package(package = .packageName), template)
}


#' @import utils
#' @import DT

.onLoad <- function(libname, pkgname) {
  # hooks for future enhancements
}


.onAttach <- function(libname, pkgname) {
  # hooks for future enhancements
}
