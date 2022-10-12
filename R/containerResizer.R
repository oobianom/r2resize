#' Resizable split screen container
#'
#' Highly customizable and resizable split screen container
#'
#' @param left theme color for resizer and table e.g. black or #000000
#' @param right position of the resize toolbar e.g. top or bottom
#' @param width.left size of the page font in px e.g. 14px
#' @param width.right color of the page font in e.g. darkblue or #006699
#' @param width.units boolean. TRUE or FALSE, to add resize toobar to tables
#' @param splitter.color splitter color e.g red, black or #333333
#' @param bg.left.color left panel color e.g red, black or #333333
#' @param bg.right.color right panel color e.g red, black or #333333
#' @param left.bg.url left panel background image e.g image1.png or https://..image1.png
#' @param right.bg.url right panel background image e.g image1.png or https://..image1.png
#' @param border color of the resizer track e.g. red or #f5f5f5
#' @param text.left.color color of left panel text
#' @param text.right.color color of right panel text
#'
#' @section Examples for r2resize:
#' More examples and demo pages for are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return Split screen container
#'
#' @examples
#'
#' r2resize::splitCard(
#'   "sample rpkg.net 1",
#'   "sample rpkg.net 2 ",
#'   splitter.color = "transparent",
#'   bg.right.color = "pink",
#'   bg.left.color = "gray",
#'   text.left.color = "green",
#'   text.right.color = "yellow",
#'   position = "vertical"
#' )
#'
#' @export

splitCard <- function(left, right,
                      width.left = 50,
                      width.right = 50,
                      width.units = "%", splitter.color = "gray",
                      bg.left.color = "yellow",
                      left.bg.url = NULL,
                      right.bg.url = NULL,
                      bg.right.color = "lightgray",
                      border = c("none", "primary", "secondary", "warning", "danger", "success"),
                      position = c("vertical", "horizontal"),
                      text.left.color = "white",
                      text.right.color = "black") {

  # fetch selected position
  position <- match.arg(position)

  # fetch selected border
  border <- match.arg(border)

  # set splitter classes

  switch(position,
    vertical = {
      class.0 <- "container"
      class.a <- "left"
      class.b <- "splitter"
      class.c <- "right"
      class.d <- "Height"
    },
    horizontal = {
      class.0 <- "container-horizontal"
      class.a <- "top"
      class.b <- "splitter-horizontal"
      class.c <- "bottom"
      class.d <- "Width"
    }
  )

  holders <- paste0("r2resize-resizablediv-panel-", class.0)
  panel.a <- paste0("r2resize-resizablediv-panel-", class.a)
  splitters <- paste0("r2resize-resizablediv-", class.b)
  panel.b <- paste0("r2resize-resizablediv-panel-", class.c)
  # script fetch js
  theme.02.js <- paste0(template.loc(), "/divsplitter.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <- paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
    script <- gsub("resizepanelwhich", panel.a, script)
    script <- gsub("resizesplitterwhich", splitters, script)
    script <- gsub("HeWigdht", class.d, script)
  }
  # set to html
  attr(script, "html") <- TRUE
  class(script) <- c("html", "character")

  # set initial content
  bgcol <- "background-color:"
  bgurl <- "background-image:url("
  textcol <- "color:"
  shiny::div(
    shiny::div(
      class = holders,
      shiny::div(
        class = panel.a,
        style = paste0(bgcol, bg.left.color, ";"),
        style = ifelse(is.null(left.bg.url), "", paste0(bgurl, left.bg.url, ");")),
        style = ifelse(is.null(text.left.color), "", paste0(textcol, text.left.color, ";")),
        left
      ),
      shiny::div(
        class = splitters,
        style = paste0(bgcol, splitter.color)
      ),
      shiny::div(
        class = panel.b,
        style = paste0(bgcol, bg.right.color, ";"),
        style = ifelse(is.null(right.bg.url), "", paste0(bgurl, right.bg.url, ");")),
        style = ifelse(is.null(text.right.color), "", paste0(textcol, text.right.color, ";")),
        right
      )
    ),
    script
  )
}
