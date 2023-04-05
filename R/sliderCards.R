#' Flexible card container
#'
#' Expandable flexible card holder for images or navigation items
#'
#' @param left content on the left or top
#' @param right content on the right or bottom
#' @param splitter.color splitter color e.g red, black or #333333
#' @param bg.left.color left panel color e.g red, black or #333333
#' @param bg.right.color right panel color e.g red, black or #333333
#' @param left.bg.url left panel background image e.g image1.png or https://..image1.png
#' @param right.bg.url right panel background image e.g image1.png or https://..image1.png
#' @param position position of divider or splitter
#' @param border.color border color of the container e.g. red or #f5f5f5
#' @param text.left.color color of left panel text
#' @param text.right.color color of right panel text
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return Multiple cards with flex functionality
#'
#' @examples
#'
#' r2resize::flexCard(
#'   "Sample text",
#'   "Sample text 2"
#' )
#'
#' @export

flexCard <- function(left,
                      right,
                      splitter.color = NULL,
                      bg.left.color = NULL,
                      left.bg.url = NULL,
                      right.bg.url = NULL,
                      bg.right.color = NULL,
                      border.color = NULL,
                      position = c("vertical", "horizontal"),
                      text.left.color = "black",
                      text.right.color = "black") {
  # fetch selected position
  position <- match.arg(position)

  # preset
  if(is.null(border.color)) border.color <- "#ffffff"
  uniquenum <-
    substring(round(as.numeric(Sys.time()) * sample(7:78, 1)), 5)

  # set splitter classes
  switch(position,
         vertical = {
           class.0 <- paste0("container",uniquenum)
           class.a <- paste0("left",uniquenum)
           class.b <- paste0("splitter",uniquenum)
           class.c <- paste0("right",uniquenum)
           class.d <- paste0("Height",uniquenum)
         },
         horizontal = {
           class.0 <- paste0("container-horizontal",uniquenum)
           class.a <- paste0("top",uniquenum)
           class.b <- paste0("splitter-horizontal",uniquenum)
           class.c <- paste0("bottom",uniquenum)
           class.d <- paste0("Width",uniquenum)
         })

  holders <- paste0("r2resize-resizablediv-panel-", class.0)
  panel.a <- paste0("r2resize-resizablediv-panel-", class.a)
  splitters <- paste0("r2resize-resizablediv-", class.b)
  panel.b <- paste0("r2resize-resizablediv-panel-", class.c)

  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/splitCard.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
    css <- gsub("sib53lver", border.color, css)
    css <- paste(css, collapse = "")
  }


  # script fetch js
  theme.02.js <- paste0(template.loc(), "/divsplitter.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <-
      paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
    script <- gsub("resizepanelwhich", panel.a, script)
    script <- gsub("resizesplitterwhich", splitters, script)
    script <- gsub("HeWigdht", class.d, script)
  }
  # combine stylesheets and scripts
  cssjs <- paste0(css, script)
  cssjs <- gsub("87n767m08o", uniquenum, cssjs)
  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # set initial content
  bgcol <- "background-color:"
  bgurl <- "background-image:url("
  textcol <- "color:"
  shiny::div(shiny::div(
    class = holders,
    shiny::div(
      class = panel.a,
      style = paste0(bgcol, bg.left.color, ";"),
      style = ifelse(is.null(left.bg.url), "", paste0(bgurl, left.bg.url, ");")),
      style = ifelse(
        is.null(text.left.color),
        "",
        paste0(textcol, text.left.color, ";")
      ),
      left
    ),
    shiny::div(class = splitters,
               style = paste0(bgcol, splitter.color)),
    shiny::div(
      class = panel.b,
      style = paste0(bgcol, bg.right.color, ";"),
      style = ifelse(is.null(right.bg.url), "", paste0(bgurl, right.bg.url, ");")),
      style = ifelse(
        is.null(text.right.color),
        "",
        paste0(textcol, text.right.color, ";")
      ),
      right
    )
  ),
  cssjs)
}
