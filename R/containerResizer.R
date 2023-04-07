#' Resizable split screen container
#'
#' Highly customizable and resizable split screen container
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
#' @return Resizeable split screen container
#'
#' @examples
#'
#' r2resize::splitCard(
#'   "Sample text",
#'   "Sample text 2"
#' )
#'
#'
#' r2resize::splitCard(
#'   "Sample r2symbols 1",
#'   "Sample nextGen 1",
#'   bg.right.color = "white",
#'   bg.left.color = "lightgray",
#'   position = "vertical"
#' )
#'
#' r2resize::splitCard(
#'   "Sample shinyStorePlus",
#'   "Sample nextGen 1",
#'   bg.right.color = "white",
#'   bg.left.color = "lightgray",
#'   border.color = "black",
#'   text.left.color = "black",
#'   text.right.color = "black",
#'   position = "vertical"
#' )
#'
#' r2resize::splitCard(
#'   "Sample sciRmdTheme 1",
#'   "Sample nextGen 1",
#'   bg.right.color = "white",
#'   bg.left.color = "lightgray",
#'   border.color = "gray",
#'   text.left.color = "black",
#'   text.right.color = "black",
#'   position = "horizontal"
#' )
#'
#' @export

splitCard <- function(left,
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
  bgurl <- "background-size: cover;background-image:url("
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
charNum1to100 <- as.character(unique(c(80,1:100)))


#' Re sizable split screen container version 2
#'
#' Highly customizable and re sizable split screen container version 2
#'
#' @param left content on the left or top
#' @param right content on the right or bottom
#' @param bg.left.color left panel color e.g red, black or #333333
#' @param bg.right.color right panel color e.g red, black or #333333
#' @param border.color border color of the container e.g. red or #f5f5f5
#' @param text.left.color color of left panel text
#' @param text.right.color color of right panel text
#' @param slider.position position of the slider in percent
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return Realizable split screen container style 2
#'
#' @examples
#'
#' r2resize::splitCard2(
#'   shiny::tags$h1("Question 1"),
#'   shiny::tags$h1("Answer 1"),
#'   slider.position = "40"
#' )
#'
#'
#' r2resize::splitCard2(
#'   "Sample r2symbols 1",
#'   "Sample nextGen 1",
#'   bg.right.color = "white",
#'   bg.left.color = "lightgray"
#' )
#'
#' r2resize::splitCard2(
#'   "Sample shinyStorePlus",
#'   "Sample nextGen 1",
#'   bg.right.color = "white",
#'   bg.left.color = "lightgray",
#'   border.color = "black",
#'   text.left.color = "black",
#'   text.right.color = "black"
#' )
#'
#' r2resize::splitCard2(
#'   "Sample sciRmdTheme 1",
#'   "Sample nextGen 1",
#'   bg.right.color = "white",
#'   bg.left.color = "lightgray",
#'   border.color = "gray",
#'   text.left.color = "black",
#'   text.right.color = "black"
#' )
#'
#' @export

splitCard2 <- function(left,
                       right,
                       bg.left.color = NULL,
                       bg.right.color = NULL,
                       border.color = NULL,
                       text.left.color = "black",
                       text.right.color = "black",
                       slider.position = charNum1to100) {

  # set position
  slider.position = paste0(match.arg(slider.position),"%")

  # preset
  if(is.null(border.color)) border.color <- "#ffffff"
  uniquenum <-nextGenShinyApps::rand.num(1)
  uniqclass <- paste0("r2rsC2",uniquenum)

  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/splitCard2.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
    css <- gsub("sib534lver", border.color, css)
    css <- gsub("slidepos1232", slider.position, css)
    css <- paste(css, collapse = "")
  }


  # script fetch js
  theme.02.js <- paste0(template.loc(), "/splitCard2.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <-
      paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
    script <- gsub("slidepos1232", slider.position, script)
  }
  # combine stylesheets and scripts
  cssjs <- paste0(css, script)
  cssjs <- gsub("c87n767m08o", uniqclass, cssjs)
  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # set initial content
  bgcol <- "background-color:"
  textcol <- "color:"
  shiny::div(
    class = uniqclass,
    shiny::div(
      class = paste0("r2resize-",uniqclass,"-splitcard2-split-container"),
      shiny::div(
        class = paste0("r2resize-",uniqclass,"-splitcard2-split-content-left"),
        style = paste0(bgcol, bg.left.color, ";"),
        shiny::div(
          class = paste0("r2resize-",uniqclass,"-splitcard2-content-text"),
          style = ifelse(is.null(text.left.color), "", paste0(textcol, text.left.color, ";")),
          shiny::div(
            shiny::div(
              class = paste0("r2resize-",uniqclass,"-splitcard2-text-left"),
              left
            )
          )
        )
      ),
      shiny::div(
        class = paste0("r2resize-",uniqclass,"-splitcard2-split-content-right"),
        style = paste0(bgcol, bg.right.color, ";"),
        shiny::div(
          class = paste0("r2resize-",uniqclass,"-splitcard2-content-text"),
          style = ifelse(is.null(text.right.color), "", paste0(textcol, text.right.color, ";")),
          shiny::div(
            shiny::div(
              class = paste0("r2resize-",uniqclass,"-splitcard2-text-left"),
              right
            )
          )
        )
      )
    ),
    cssjs
  )
}



#' Resizable container content holder
#'
#' Highly customizable and resizable  container content holder
#'
#' @param ... content of container
#' @param bg.color content background color e.g red, black or #333333
#' @param border.color border color of container e.g. red or #f5f5f5
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return Container with a resizing toolbar feature on the right
#'
#' @examples
#'
#' r2resize::sizeableCard(
#'   "sample rpkg.net text"
#' )
#'
#' r2resize::sizeableCard(
#'   "sample r2resume text",
#'   bg.color = "lightgray",
#'   border.color="black"
#' )
#'
#' @export

sizeableCard <- function(...,
                         bg.color = NULL,
                         border.color = NULL) {
  # preset
  border.color <-
    ifelse(is.null(border.color), "#ffffff", border.color)
  bg.color <- ifelse(is.null(bg.color), "#ffffff", bg.color)
  uniquenum <-
    substring(round(as.numeric(Sys.time()) * sample(1:50, 1)), 5)

  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/rezcontCard.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
    css <- gsub("bgheaderbordercolor", border.color, css)
    css <- gsub("contentbgcolor", bg.color, css)
    css <- paste(css, collapse = "")
  }


  # script fetch js
  theme.02.js <- paste0(template.loc(), "/rezcontCard.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <-
      paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
  }
  # combine stylesheets and scripts
  cssjs <- paste0(css, script)
  cssjs <- gsub("87n767m08o", uniquenum, cssjs)
  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # content
  shiny::div(shiny::div(
    class = paste0("r2resize-rezconcard-holder", uniquenum),
    shiny::div(
      class = paste0("r2resize-rezconcard-controls", uniquenum),
      shiny::tags$a(
        href = "#",
        class = paste0("r2resize-rezconcard-controls-small", uniquenum),
        "A"
      ),
      shiny::tags$a(
        href = "#",
        class = paste0("r2resize-rezconcard-controls-medium", uniquenum),
        "A"
      ),
      shiny::tags$a(
        href = "#",
        class = paste0("r2resize-rezconcard-controls-large", uniquenum),
        "A"
      )
    ),
    shiny::div(class = paste0("r2resize-rezconcard-body", uniquenum),
               ...)
  ),
  cssjs)
}



#' Resizable Moveable Expandable Window Card
#'
#' Easily expandable and resizable content container holder
#'
#' @param ... content of the container
#' @param title title of the header
#' @param width width of the container
#' @param bg.color background color of the content area
#' @param border.color color of the container border
#' @param header.text.color color of the header text
#' @param body.text.color color of the content text
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @note Please note that only one windowCard may be created by page
#'
#' @return A window-like card container that is expandable and resizable
#'
#' @examples
#'
#' r2resize::windowCard("sample r2symbols text")
#'
#' r2resize::windowCard(
#' title = "Sample Window card",
#' width = "500px",
#' bg.color = "white",
#' border.color = "brown",
#' header.text.color = "white",
#' body.text.color = "black")
#'
#' @export

windowCard <- function(...,
                       title = "Sample title",
                       width = "50%",
                       bg.color = NULL,
                       border.color = NULL,
                       header.text.color = NULL,
                       body.text.color = NULL) {
  # presets
  border.color <-
    ifelse(is.null(border.color), "#999999", border.color)
  bg.color <- ifelse(is.null(bg.color), "#f1f1f1", bg.color)
  body.text.color <-
    ifelse(is.null(body.text.color), "#000000", body.text.color)
  header.text.color <-
    ifelse(is.null(header.text.color), "#000000", header.text.color)

  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/windowCard.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
    css <- gsub("bgheaderbordercolor", border.color, css)
    css <- gsub("contentbgcolor", bg.color, css)
    css <- gsub("contentwidth", width, css)
    css <- gsub("body1text1color", body.text.color, css)
    css <- gsub("header1text1color", header.text.color, css)
    css <- paste(css, collapse = "")
  }

  # fetch selected border
  border <- border.color

  # script fetch js
  theme.02.js <- paste0(template.loc(), "/windowCard.js")
  script <- ""
  if (file.exists(theme.02.js)) {
    script <-
      paste(c("<script>", readLines(theme.02.js), "</script>"), collapse = " ")
  }

  # combine stylesheets and scripts
  cssjs <- paste0(css, script)
  # set to html
  attr(cssjs, "html") <- TRUE
  class(cssjs) <- c("html", "character")

  # content
  shiny::div(
    shiny::div(
      id = "r2resize-windowcard-pane",
      shiny::div(class = "r2resize-windowcard-title",
                 title),
      shiny::div(class = "r2resize-windowcard-content",
                 ...)
    ),
    shiny::div(id = "r2resize-windowcard-ghostpane"),
    cssjs
  )
}


#' Create an Emphasis Card
#'
#' Emphasis container
#'
#' @param ... content of the card
#' @param bg.color content background color
#'
#' @section More examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://r2resize.obi.obianom.com}.
#'
#' @return container with a moving border to denote emphasis
#'
#' @examples
#'
#' r2resize::empahsisCard(
#'   "sample rpkg.net 1",
#'   "sample rpkg.net 2 ",
#'   bg.color = "cyan"
#' )
#'
#' @export

empahsisCard <- function(..., bg.color = NULL) {
  # preset
  bg.color <- ifelse(is.null(bg.color), "#f5f5f5", bg.color)

  # fetch css
  css <- ""
  theme.02.css <- paste0(template.loc(), "/empahsisCard.css")
  if (file.exists(theme.02.css)) {
    css <- c(css, "<style>", readLines(theme.02.css), "</style>")
    css <- gsub("contentbgcolor", bg.color, css)
    css <- paste(css, collapse = "")
  }
  # set to html
  attr(css, "html") <- TRUE
  class(css) <- c("html", "character")

  # content
  shiny::div(shiny::div(class = "r2resize-emphasizeDiv",
                        ...),
             css)
}


#' Create an Emphasis Card
#'
#' Emphasis container
#'
#' @inheritParams empahsisCard
#'
#' @return container with a moving border to denote emphasis
#'
#' @examples
#'
#' r2resize::emphasisCard(
#'   "sample rpkg.net 1",
#'   "sample rpkg.net 2 ",
#'   bg.color = "cyan"
#' )
#'
#' @export
#'

emphasisCard <- empahsisCard


