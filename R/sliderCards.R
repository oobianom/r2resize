#' Flexible card container
#'
#' Expandable flexible card holder for images or navigation items
#'
#' @param ... list of image containers, see example below
#' @param height.px height of container as numeric
#' @param width.px width of container as numeric
#' @param border.color color of border of each container
#' @param border.width.px width of the container border
#' @param active.panel the active panel or container e.g. 1. Use 0 to make all panels inactive
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
#'   subtitle="A cool subtitle",
#'   icon.color = "blue",
#'   text.color = "brown"
#'   )
#' )
#'
#' @export

flexCard <- function(...,
                     height.px = NULL,
                     width.px = NULL,
                      border.color = "white",
                      border.width.px = 1,
                      active.panel = 1) {
  # fetch card list
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
    class = "r2resize-flexCard-options",
    lapply(seq_along(cardlist), function(index,self = cardlist[[index]]){
      self <- as.list(self)
      shiny::div(
        class="r2resize-flexCard-option",
        class=ifelse(index == active.panel,"r2resize-flexCard-active",""),
        style = paste0(bgcol,ifelse(is.null(self$bg), "", paste0(bgurl, self$bg, ");"))),
        shiny::div(
          class="r2resize-flexCard-shadow"
        ),
        shiny::div(
          class="r2resize-flexCard-label",
          shiny::div(
            class="r2resize-flexCard-icon",
            style=paste0("--defaultIconBg1:",ifelse(is.null(self$icon.color),"#000",self$icon.color)),
            shiny::icon(self$icon)
          ),
          shiny::div(
            class="r2resize-flexCard-info",
            style=paste0("--defaulttEXTbG1:",ifelse(is.null(self$text.color),"#FFF",self$text.color)),
            shiny::div(
              class="r2resize-flexCard-main",
              self$title
            ),
            shiny::div(
              class="r2resize-flexCard-sub",
              self$subtitle
            )
          )
        )
      )
    }),
  style = ifelse(is.null(height.px),"",paste0("height:", height.px, "px;")),
  style = ifelse(is.null(width.px),"",paste0("width:", width.px, "px;"))
  ),
  cssjs)
}











#' Hover elastic card container
#'
#' Automatic elastic card holder for images or navigation items
#'
#' @param ... list of image containers, see example below
#' @param height.px height of container as numeric
#' @param width.px width of container as numeric
#' @param border.color color of border of each container
#' @param border.width.px width of the container border
#' @param active.panel the active panel or container e.g. 1
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return Multiple cards with hover elastic functionality
#'
#' @examples
#'
#' r2resize::elastiCard(
#'   item1 = c(
#'   bg = "https://r2resize.obi.obianom.com/m/image1.jpg",
#'   icon = "edit",
#'   title="Sample text 1",
#'   subtitle="A cool subtitle"),
#'   item2 = c(
#'   bg = "https://r2resize.obi.obianom.com/m/image2.jpg",
#'   title="Sample text 2",
#'   subtitle="A cool subtitle",
#'   text.color = "brown"
#'   )
#' )
#'
#' @export

elastiCard <- function(...,
                     height.px = NULL,
                     width.px = NULL,
                     border.color = "white",
                     border.width.px = 1,
                     active.panel = 1) {
  # fetch card list
  cardlist <- list(...)


  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/expandingAccordian.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
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
  bgbdr <- paste0("border:",border.width.px,"px solid ",border.color,";")
  bgurl <- "background-image:url("
  textcol <- "color:"


  #combine all flex cards
  step = 0
  shiny::div(shiny::tags$section(
    class = "r2resize-elastiCard-team",
    lapply(cardlist, function(self){
      self <- as.list(self)
      shiny::tags$article(
        style = ifelse(is.null(self$bg), "", paste0(bgurl, self$bg, ");")),
        shiny::div(
        class="r2resize-flexCard-info",
        style=paste0("color:",ifelse(is.null(self$text.color),"#FFF",self$text.color)),
        shiny::tags$h2(self$title),
        shiny::tags$h5(self$subtitle),
        shiny::tags$p(self$desc)
        )
      )
    }),

    style = paste0(ifelse(is.null(height.px),"",paste0("height:", height.px, "px;")),
                   ifelse(is.null(width.px),"",paste0("width:", width.px, "px;")),bgbdr)
  ),
  cssjs)
}


