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

flexCard <- function(...,
                     height.px = NULL,
                     width.px = NULL,
                      border.color = "white",
                      border.width.px = 1,
                      active.panel = 1,
                      title.color = "black",
                      descr.color = "black") {
  # fetch selected position
  position <- match.arg(position)

  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/expandingAccordian.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
    css <- gsub("sib53lver", border.color, css)
    css <- gsub("sib53lpxver", border.width.px, css)
    css <- paste(css, collapse = "")
  }


  # script fetch js
  theme.02.js <- paste0(template.loc(), "/expandingAccordian.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <-
      paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
    script <- gsub("resizepanelwhich", active.panel, script)
  }
  # combine stylesheets and scripts
  cssjs <- paste0(css, script)
  cssjs <- gsub("87n767m08o", uniquenum, cssjs)

  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # set initial content
  bgcol <- "background-color:"
  bgurl <- "--optionBackground:url("
  textcol <- "color:"


  #combine all flex cards
  flexcards = lapply(cardlist, function(self){
    shiny::div(
      class="option active",
      style = ifelse(is.null(self$bg), "", paste0(bgurl, self$url, ");")),
      shiny::div(
        class="shadow"
      ),
      shiny::div(
        class="label",
        shiny::div(
          class="icon",
          self$icon
        ),
        shiny::div(
          class="info",
          shiny::div(
            class="main",
            self$title
          ),
          shiny::div(
            class="sub",
            self$subtitle
          )
        )
      )
    )
  })


  shiny::div(shiny::div(
    class = "options",
    flexcards
  ),
  style = ifelse(is.null(height.px), "height:", height.px, ";"),
  style = ifelse(is.null(width.px), "width:", width.px, ";"),
  cssjs)
}


