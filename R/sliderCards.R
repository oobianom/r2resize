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
#'   item1 = c(
#'   bg = "https://r2resize.obi.obianom.com/m/image1.jpg",
#'   icon = "edit",
#'   title="Sample text 1",
#'   subtitle="A cool subtitle"),
#'   item2 = c(
#'   bg = "https://r2resize.obi.obianom.com/m/image2.jpg",
#'   icon = "edit",
#'   title="Sample text 2",
#'   subtitle="A cool subtitle")
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
  cardlist <- list(...)


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
  uniquenum <- nextGenShinyApps::rand.num(1)
  cssjs <- paste0(css, script)
  cssjs <- gsub("87n767m08o", uniquenum, cssjs)

  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # set initial content
  bgcol <- paste0("--bgcolorEA:",border.width.px,"px solid ",border.color,";")
  bgurl <- "--optionBackground:url("
  textcol <- "color:"


  #combine all flex cards
  step = 0
  shiny::div(shiny::div(
    class = "options",
    lapply(cardlist, function(self){
      self <- as.list(self)
      step <<- step + 1
      shiny::div(
        class="option",
        class=ifelse(step == active.panel,"active",""),
        style = paste0(bgcol,ifelse(is.null(self$bg), "", paste0(bgurl, self$bg, ");"))),
        shiny::div(
          class="shadow"
        ),
        shiny::div(
          class="label",
          shiny::div(
            class="icon",
            style=paste0("--defaultIconBg1:",ifelse(is.null(self$icon.color),"#000",self$icon.color)),
            shiny::icon(self$icon)
          ),
          shiny::div(
            class="info",
            style=paste0("--defaulttEXTbG1:",ifelse(is.null(self$text.color),"#FFF",self$text.color)),
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
  ),
  style = ifelse(is.null(height.px),"",paste0("height:", height.px, ";")),
  style = ifelse(is.null(width.px),"",paste0("width:", width.px, ";")),
  cssjs)
}











#' Elastic card container
#'
#' Expandable elastic card holder for images or navigation items
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
#' @return Multiple cards with elastic functionality
#'
#' @examples
#'
#' r2resize::elastiCard(
#'   "Sample text",
#'   "Sample text 2"
#' )
#'
#' @export

elastiCard <- function(...,
                     height.px = NULL,
                     width.px = NULL,
                     border.color = "white",
                     border.width.px = 1,
                     active.panel = 1,
                     title.color = "black",
                     descr.color = "black") {
  # fetch selected position
  cardlist <- list(...)


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
  uniquenum <- nextGenShinyApps::rand.num(1)
  cssjs <- paste0(css, script)
  cssjs <- gsub("87n767m08o", uniquenum, cssjs)

  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # set initial content
  bgcol <- paste0("--bgcolorEA:",border.width.px,"px solid ",border.color,";")
  bgurl <- "--optionBackground:url("
  textcol <- "color:"


  #combine all flex cards
  step = 0
  shiny::div(shiny::div(
    class = "options",
    lapply(cardlist, function(self){
      self <- as.list(self)
      step <<- step + 1
      shiny::div(
        class="option",
        class=ifelse(step == active.panel,"active",""),
        style = paste0(bgcol,ifelse(is.null(self$bg), "", paste0(bgurl, self$bg, ");"))),
        shiny::div(
          class="shadow"
        ),
        shiny::div(
          class="label",
          shiny::div(
            class="icon",
            style=paste0("--defaultIconBg1:",ifelse(is.null(self$icon.color),"#000",self$icon.color)),
            shiny::icon(self$icon)
          ),
          shiny::div(
            class="info",
            style=paste0("--defaulttEXTbG1:",ifelse(is.null(self$text.color),"#FFF",self$text.color)),
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
  ),
  style = ifelse(is.null(height.px),"",paste0("height:", height.px, ";")),
  style = ifelse(is.null(width.px),"",paste0("width:", width.px, ";")),
  cssjs)
}



