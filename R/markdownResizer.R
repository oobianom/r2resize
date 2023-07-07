#' Configure toolbar settings for the page
#'
#' Set options for the inclusion of sizing toolbar in documents
#'
#' @param theme.color theme color for resizer and table e.g. black or #000000
#' @param position position of the resize toolbar e.g. top or bottom
#' @param font.size size of the page font in px e.g. 14px
#' @param font.color color of the page font in e.g. darkblue or #006699
#' @param tables boolean. TRUE or FALSE, to add resize toobar to tables
#' @param images boolean. TRUE or FALSE, to add resize toobar to images
#' @param line.color color of the resizer track e.g. red or #f5f5f5
#' @param thumb.width width of the resizer thumb e.g. 25
#' @param thumb.height height of the resizer thumb e.g. 25
#' @param line.width width of the resizer track e.g. 200
#' @param line.height height of the resizer track e.g. 10
#' @param dim.units unit for the height and width of the track or thumb
#' @param default.image.width default width of all images on the page e.g. 100
#'
#' @section Examples for r2resize:
#' More examples and demo pages for are located at this link -
#' \url{https://rnetwork.obi.obianom.com/package/r2resize}.
#'
#' @return Inclusion of mini toolbar for images and tables within a page
#'
#' @examples
#' r2resize::add.resizer() #default settings
#'
#' r2resize::add.resizer(
#'   theme.color = "blue",
#'   position = "top",
#'   font.size = "12px",
#'   font.color = "brown",
#'   tables = TRUE,
#'   images = TRUE,
#'   line.color = "green",
#'   line.width = 150,
#'   line.height = 5,
#'   default.image.width = "40%"
#' ) # customized settings
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
    if(!is.null(default.image.width))
      con <- gsub("'pre3e2423'", paste0("'",default.image.width,"'"), con)
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
    con <- gsub("if\\(allowtable\\)", "if(!allowtable)", con)
  }
  if (!images) {
    con <- gsub("if\\(allowimage\\)", "if(!allowimage)", con)
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
  file.path(find.package(package = "r2resize"), template)
}


#' @import utils
#' @import DT

.onLoad <- function(libname, pkgname) {
  # hooks for future enhancements
}


.onAttach <- function(libname, pkgname) {
  # hooks for future enhancements
}
