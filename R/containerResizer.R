#' Resizable split screen container
#'
#' Highly customizable and resizable split screen container
#'
#' @param left content on the left or top
#' @param right content on the right or bottom
#' @param width.left width of the left or top
#' @param width.right width of the right or bottom
#' @param width.units boolean. TRUE or FALSE, to add resize toobar to tables
#' @param splitter.color splitter color e.g red, black or #333333
#' @param bg.left.color left panel color e.g red, black or #333333
#' @param bg.right.color right panel color e.g red, black or #333333
#' @param left.bg.url left panel background image e.g image1.png or https://..image1.png
#' @param right.bg.url right panel background image e.g image1.png or https://..image1.png
#' @param border.color color of the container e.g. red or #f5f5f5
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
                      border.color = NULL,
                      position = c("vertical", "horizontal"),
                      text.left.color = "white",
                      text.right.color = "black") {

  # fetch selected position
  position <- match.arg(position)

  # fetch selected border
  border <- border.color

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



#' Resizable container content holder
#'
#' Highly customizable and resizable  container content holder
#'
#' @param ... content
#' @param width.left size of the page font in px e.g. 14px
#' @param width.right color of the page font in e.g. darkblue or #006699
#' @param width.units boolean. TRUE or FALSE, to add resize toobar to tables
#' @param splitter.color splitter color e.g red, black or #333333
#' @param bg.left.color left panel color e.g red, black or #333333
#' @param bg.right.color right panel color e.g red, black or #333333
#' @param left.bg.url left panel background image e.g image1.png or https://..image1.png
#' @param right.bg.url right panel background image e.g image1.png or https://..image1.png
#' @param border.color color of the container e.g. red or #f5f5f5
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
#' r2resize::rezcontCard(
#'   "sample rpkg.net 1"
#' )
#'
#' @export

rezcontCard <- function(...,
                      width.left = 50,
                      width.right = 50,
                      width.units = "%", splitter.color = "gray",
                      bg.left.color = "yellow",
                      left.bg.url = NULL,
                      right.bg.url = NULL,
                      bg.right.color = "lightgray",
                      border.color = NULL,
                      position = c("vertical", "horizontal"),
                      text.left.color = "white",
                      text.right.color = "black") {

  # fetch selected position
  position <- match.arg(position)

  # fetch selected border
  border <- border.color

  # script fetch js
  theme.02.js <- paste0(template.loc(), "/rezcontCard.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <- paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
    # script <- gsub("resizepanelwhich", panel.a, script)
    # script <- gsub("resizesplitterwhich", splitters, script)
    # script <- gsub("HeWigdht", class.d, script)
  }
  # set to html
  attr(script, "html") <- TRUE
  class(script) <- c("html", "character")

  #content
  shiny::div(
  shiny::div(
    class = "r2resize-rezconcard-holder",
    shiny::div(
      class = "r2resize-rezconcard-controls",
      shiny::tags$a(href = "#",class = "r2resize-rezconcard-controls-small","A"),
      shiny::tags$a(href = "#",class = "r2resize-rezconcard-controls-medium","A"),
      shiny::tags$a(href = "#",class = "r2resize-rezconcard-controls-large","A")
    ),
    ...
  ),
  script)
}



#' Resizable Moveable Expandable Card
#'
#' Highly expandable and resizable container holder
#'
#' @param ... content
#' @param title title of header
#' @param width.right color of the page font in e.g. darkblue or #006699
#' @param width.units boolean. TRUE or FALSE, to add resize toobar to tables
#' @param splitter.color splitter color e.g red, black or #333333
#' @param bg.left.color left panel color e.g red, black or #333333
#' @param bg.right.color right panel color e.g red, black or #333333
#' @param left.bg.url left panel background image e.g image1.png or https://..image1.png
#' @param right.bg.url right panel background image e.g image1.png or https://..image1.png
#' @param border.color color of the container e.g. red or #f5f5f5
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

windowCard <- function(...,
                       title = "Sample title",
                        width.right = 50,
                        width.units = "%", splitter.color = "gray",
                        bg.left.color = "yellow",
                        left.bg.url = NULL,
                        right.bg.url = NULL,
                        bg.right.color = "lightgray",
                        border.color = NULL,
                        position = c("vertical", "horizontal"),
                        text.left.color = "white",
                        text.right.color = "black") {

  # fetch selected position
  position <- match.arg(position)

  # fetch selected border
  border <- border.color

  # script fetch js
  theme.02.js <- paste0(template.loc(), "/windowCard.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <- paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
    # script <- gsub("resizepanelwhich", panel.a, script)
    # script <- gsub("resizesplitterwhich", splitters, script)
    # script <- gsub("HeWigdht", class.d, script)
  }
  # set to html
  attr(script, "html") <- TRUE
  class(script) <- c("html", "character")

  #content
  shiny::div(
    shiny::div(
      class = "r2resize-windowcard-pane",
      shiny::div(
        class = "r2resize-windowcard-title",
        title
      ),
      ...
    ),
    shiny::div(
      class = "r2resize-windowcard-ghostpane"),
    script)
}
