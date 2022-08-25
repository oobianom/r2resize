#' Create settings for Rmarkdown page
#'
#' Set options for the styling of the Rmarkdown theme to use on the page
#' @param theme.color theme to use for the page
#' @param position primary color for the theme
#' @param font.size make header sticky, TRUE or FALSE
#' @param font.color set a list group icon
#' @param tables add the table
#' @param images add the resizer for all images
#'
#' @section Demos for sciRmdTheme:
#' More examples and demo pages for are located at this link -
#' \url{https://github.com/oobianom/sciRmdTheme}.
#'
#' @return styles for themeing the page
#'
#' @examples
#' add.resizer(
#'    theme.color = NULL,
#'    position = "top",
#'    font.size = NULL,
#'    font.color = NULL,
#'    tables = TRUE,
#'    images = TRUE
#' )
#'
#' @export

add.resizer <- function(
  theme.color = NULL,
  position = c("top","bottom","left","right"),
  font.size = NULL,
  font.color = NULL,
  tables = TRUE,
  images = TRUE
  ) {

  position <- match.arg(position)

  # set content
  con <- ""



  # extract template
  theme.01 <- "default"
  # fetch css
  theme.02.css <- paste0(template.loc(), "/", theme.01, ".css")
  if (file.exists(theme.02.css)) {
    con <- c(con, "<style>", readLines(theme.02.css), "</style>")
    if (!is.null(color)) {
      con <- gsub("gray", color, con)
    }
    if(!is.null(font.color))
      con <- gsub("fontcolorplaceholder", font.color, con)
  }

  # fetch js
  theme.02.js <- paste0(template.loc(), "/", theme.01, ".js")
  if (file.exists(theme.02.js)) {
    con <- c(con, "<script>", readLines(theme.02.js), "</script>")
    con <- gsub("listgroupixon", "xxxxx", con)
  }

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
