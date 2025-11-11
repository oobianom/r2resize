#' Flexible card container
#'
#' Creates an expandable and flexible card holder, ideal for showcasing images, navigation items, or categorized content in an interactive manner.
#'
#' @param ... A list of image or content containers, where each item is a named vector or list specifying properties like `bg` (background image URL),
#'   `icon` (Font Awesome icon name), `title`, `subtitle`, `icon.color`, and `text.color`.
#'   See examples for the expected structure of these item lists.
#' @param height.px Numeric. The fixed height of the entire `flexCard` container in pixels. If `NULL`, the height adjusts automatically.
#' @param width.px Numeric. The fixed width of the entire `flexCard` container in pixels. If `NULL`, the width adjusts automatically.
#' @param border.color Character string. The color of the border for each individual card panel (e.g., "white", "#RRGGBB").
#' @param border.width.px Numeric. The width of the border for each individual card panel in pixels.
#' @param active.panel Numeric. The index (1-based) of the panel that should be initially active (expanded).
#'   Use `0` to make all panels initially inactive/collapsed.
#'
#' @details
#' The `flexCard` function generates a visually appealing and interactive set of cards that expand on click.
#' It is particularly useful for dashboards, portfolios, or content sections where space is at a premium
#' but detailed information needs to be accessible. Each card can have its own background image,
#' an icon, a main title, and a subtitle, with customizable colors for icons and text.
#' The function relies on internal CSS and JavaScript to manage the expansion and collapse behavior.
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @note
#' Ensure that `shiny` is loaded if using this function within a Shiny application.
#' The `active.panel` parameter determines which card is initially open; setting it to `0` starts with all cards collapsed.
#'
#' @return An HTML `div` element containing multiple flex cards with interactive expansion functionality,
#'   suitable for inclusion in Shiny applications or R Markdown documents.
#'
#' @family Image and Container Resizing Components
#' @seealso
#' \code{\link{elastiCard}} for hover-elastic cards,
#' \code{\link{shinyExpandImage}} for elegant image viewing and resizing.
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   library(shiny)
#'   library(r2resize)
#'   library(htmltools)
#'
#'   ui <- fluidPage(
#'     tags$h2("Flexible Cards Example"),
#'     flexCard(
#'       item1 = c(
#'         bg = "https://r2resize.obi.obianom.com/m/image1.jpg",
#'         icon = "chart-line",
#'         title = "Market Trends",
#'         subtitle = "Analysis of current market movements"
#'       ),
#'       item2 = c(
#'         bg = "https://r2resize.obi.obianom.com/m/image2.jpg",
#'         icon = "flask",
#'         title = "Research Projects",
#'         subtitle = "Ongoing studies and experiments",
#'         icon.color = "blue",
#'         text.color = "lightgray"
#'       ),
#'       item3 = c(
#'         bg = "https://r2resize.obi.obianom.com/m/image3.jpg",
#'         icon = "users",
#'         title = "Team Collaboration",
#'         subtitle = "Enhancing team productivity",
#'         icon.color = "green"
#'       ),
#'       height.px = 400,
#'       width.px = 800,
#'       border.color = "darkgray",
#'       border.width.px = 2,
#'       active.panel = 2 # Start with the second panel active
#'     ),
#'     tags$br(),
#'     tags$h2("Flexible Cards with default active panel"),
#'     flexCard(
#'       itemA = c(
#'         title = "Default Panel 1",
#'         subtitle = "No background image",
#'         icon = "info-circle"
#'       ),
#'       itemB = c(
#'         title = "Default Panel 2",
#'         subtitle = "Just text",
#'         icon = "lightbulb"
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output) {}
#'
#'   shinyApp(ui, server)
#' }
#' }
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
  uniquenum <- quickcode::number(1)
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
#' Creates an automatic elastic card holder, designed for showcasing images or navigation items
#' with a hover-based expansion effect, providing an engaging user experience.
#'
#' @param ... A list of image or content containers, where each item is a named vector or list specifying
#'   properties like `bg` (background image URL), `icon` (Font Awesome icon name), `title`, `subtitle`,
#'   `desc` (longer description), and `text.color`.
#'   See examples for the expected structure of these item lists.
#' @param height.px Numeric. The fixed height of the entire `elastiCard` container in pixels. If `NULL`, the height adjusts automatically.
#' @param width.px Numeric. The fixed width of the entire `elastiCard` container in pixels. If `NULL`, the width adjusts automatically.
#' @param border.color Character string. The color of the border for the entire container (e.g., "white", "#RRGGBB").
#' @param border.width.px Numeric. The width of the border for the entire container in pixels.
#' @param active.panel Numeric. This parameter is retained for consistency with `flexCard` but
#'   does not affect the hover-based behavior of `elastiCard`.
#'
#' @details
#' The `elastiCard` function provides a dynamic display of multiple content cards that automatically
#' expand on hover. This effect is suitable for interactive galleries, team member profiles,
#' or feature lists where a preview is shown and more details emerge on user interaction.
#' Each card can display a background image, a title, a subtitle, a longer description,
#' and customizable text colors. The hover-based elasticity makes for an intuitive and responsive design.
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @note
#' Ensure that `shiny` is loaded if using this function within a Shiny application.
#' The `elastiCard` leverages CSS transitions for its hover effects, providing a smooth user experience.
#' For best visual results, provide images with consistent aspect ratios if using `bg` properties.
#'
#' @return An HTML `section` element containing multiple elastic cards with hover-based expansion functionality,
#'   suitable for inclusion in Shiny applications or R Markdown documents.
#'
#' @family Image and Container Resizing Components
#' @seealso
#' \code{\link{flexCard}} for click-expandable flexible cards,
#' \code{\link{shinyExpandImage}} for elegant image viewing and resizing.
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   library(shiny)
#'   library(r2resize)
#'   library(htmltools)
#'
#'   ui <- fluidPage(
#'     tags$h2("Hover Elastic Cards - Text Only"),
#'     elastiCard(
#'       item1 = c(
#'         icon = "brain",
#'         title = "Cognitive Science",
#'         subtitle = "Exploring the mind",
#'         desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,
#'                 sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
#'         text.color = "lightblue"
#'       ),
#'       item2 = c(
#'         title = "Neurobiology",
#'         subtitle = "The science of the nervous system",
#'         desc = "Ut enim ad minim veniam, quis nostrud exercitation ullamco
#'                 laboris nisi ut aliquip ex ea commodo consequat.",
#'         text.color = "lightgreen"
#'       ),
#'       height.px = 300,
#'       width.px = 900,
#'       border.color = "gray",
#'       border.width.px = 1
#'     ),
#'     tags$br(),
#'     tags$h2("Hover Elastic Cards - With Background Images"),
#'     elastiCard(
#'       itemA = c(
#'         bg = "https://r2resize.obi.obianom.com/m/image1.jpg",
#'         icon = "chart-pie",
#'         title = "Data Visualization",
#'         subtitle = "Making data accessible",
#'         desc = "Duis aute irure dolor in reprehenderit in voluptate velit esse
#'                 cillum dolore eu fugiat nulla pariatur."
#'       ),
#'       itemB = c(
#'         bg = "https://r2resize.obi.obianom.com/m/image2.jpg",
#'         title = "Machine Learning",
#'         subtitle = "AI-powered insights",
#'         desc = "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui
#'                 officia deserunt mollit anim id est laborum.",
#'         text.color = "white"
#'       ),
#'       itemC = c(
#'         bg = "https://r2resize.obi.obianom.com/m/image3.jpg",
#'         title = "Cloud Computing",
#'         subtitle = "Scalable solutions",
#'         desc = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem
#'                 accusantium doloremque laudantium.",
#'         text.color = "yellow"
#'       ),
#'       height.px = 350
#'     )
#'   )
#'
#'   server <- function(input, output) {}
#'
#'   shinyApp(ui, server)
#' }
#' }
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
  uniquenum <-  quickcode::number(1)
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
