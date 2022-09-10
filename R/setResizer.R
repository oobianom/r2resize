#' Create settings for Rmarkdown page
#'
#' Set options for the styling of the Rmarkdown theme to use on the page
#' @param theme.color theme to use for the page
#' @param position primary color for the theme
#' @param font.size size of font in px e.g 14px
#' @param font.color set a list group icon
#' @param tables add the table
#' @param images add the resizer for all images
#'
#' @section Demos for r2resize:
#' More examples and demo pages for are located at this link -
#' \url{https://github.com/oobianom/r2resize}.
#'
#' @return styles for themeing the page
#'
#' @examples
#' add.resizer(
#'   theme.color = "black",
#'   position = "top",
#'   font.size = "12px",
#'   font.color = "gray",
#'   tables = TRUE,
#'   images = TRUE,
#'   line.color = "orange",
#'   line.width = 350
#' )
#'
#' @export

add.resizer <- function(
  theme.color = NULL,
  position = c("top","bottom"),
  font.size = NULL,
  font.color = NULL,
  tables = TRUE,
  images = TRUE,
  line.color = NULL,
  thumb.width = NULL,
  thumb.height = NULL,
  line.width = NULL,
  line.height = NULL,
  dim.units = "px"
  ) {

  position <- match.arg(position)

  # set content
  con <- ""

  # get thumb properties
  thumb.2width <- ifelse(is.null(thumb.width),"26px",paste0(as.numeric(thumb.width)+6,dim.units))
  thumb.2height <- ifelse(is.null(thumb.height),"26px",paste0(as.numeric(thumb.height)+6,dim.units))
  thumb.width <- ifelse(is.null(thumb.width),"20px",paste0(thumb.width,dim.units))
  thumb.height <- ifelse(is.null(thumb.height),"20px",paste0(thumb.height,dim.units))
  line.width <- ifelse(is.null(line.width),"100",paste0(line.width,dim.units))
  line.height <- ifelse(is.null(line.height),"7px",paste0(line.height,dim.units))



  # extract template
  theme.01 <- "default"
  # fetch css
  theme.02.css <- paste0(template.loc(), "/", theme.01, ".css")
  if (file.exists(theme.02.css)) {
    con <- c(con, "<style>", readLines(theme.02.css), "</style>")
  }

  # fetch js
  theme.02.js <- paste0(template.loc(), "/", theme.01,"_", position, ".js")
  if (file.exists(theme.02.js)) {
    con <- c(con, "<script>", readLines(theme.02.js), "</script>")
    con <- gsub("listgroupixon", "xxxxx", con)
  }

  # font size
  if(!is.null(font.size))
    con <- gsub("fontsizedefault", font.size, con)

  # font color
  if(!is.null(font.color))
    con <- gsub("fontcolordefault", font.color, con)


  # add resize to image or/and tables
  if(!tables)
    con <- gsub("if\\(allowtable\\)", "if(!allowtable)", con)
  if(!images)
    con <- gsub("if\\(allowimage\\)", "if(!allowimage)", con)

  # sub others
  if (!is.null(theme.color)) {
    con <- gsub("gray", theme.color, con)
  }
  if (!is.null(line.color)) {
    con <- gsub("#cfae7c", line.color, con)
  }
  if(!is.null(font.color))
    con <- gsub("fontcolorplaceholder", font.color, con)

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

.onLoad <- function(libname, pkgname) {
  # on load statements

}


.onAttach <- function(libname, pkgname) {
}
