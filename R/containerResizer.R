#' Resizable split screen container
#'
#' Creates a highly customizable and resizable split screen container for arranging UI elements side-by-side or top-and-bottom.
#'
#' @param left The content to be displayed in the left (or top, if `position = "horizontal"`) panel. Can be any `shiny::tagList` or HTML content.
#' @param right The content to be displayed in the right (or bottom, if `position = "horizontal"`) panel. Can be any `shiny::tagList` or HTML content.
#' @param splitter.color The color of the draggable splitter line. Can be a named R color (e.g., "red", "black") or a hexadecimal color code (e.g., "#333333").
#' @param bg.left.color The background color of the left panel. Can be a named R color or a hexadecimal color code.
#' @param bg.right.color The background color of the right panel. Can be a named R color or a hexadecimal color code.
#' @param left.bg.url An optional URL for a background image for the left panel (e.g., "image1.png" or "https://example.com/image1.png").
#' @param right.bg.url An optional URL for a background image for the right panel (e.g., "image1.png" or "https://example.com/image1.png").
#' @param position The orientation of the splitter. Can be "vertical" (left/right split) or "horizontal" (top/bottom split). Defaults to "vertical".
#' @param border.color The border color of the entire container. Can be a named R color or a hexadecimal color code.
#' @param text.left.color The text color for the content within the left panel.
#' @param text.right.color The text color for the content within the right panel.
#' @param min.height The minimum height of the entire split container (e.g., "200px", "50vh").
#' @param left.width The initial width of the left panel (when `position = "vertical"`) or height of the top panel (when `position = "horizontal"`). Can be a percentage (e.g., "50\%") or a fixed pixel value (e.g., "500px").
#'
#' @details
#' The `splitCard` function provides a dynamic way to present two distinct sections of content within a single, resizable container.
#' Users can drag the splitter to adjust the visible area of each panel, making it ideal for comparisons,
#' dashboards, or any scenario requiring flexible content layout. The `position` argument allows
#' switching between a left/right split and a top/bottom split, offering versatility in design.
#' It's particularly useful within Shiny applications or R Markdown documents where interactive layouts are desired.
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return A `shiny::div` element representing the resizable split screen container, ready for inclusion in a Shiny UI or R Markdown output.
#'
#' @family Container Functions
#' @seealso \code{\link{splitCard2}}, \code{\link{sizeableCard}}, \code{\link{windowCard}}
#' @note This function requires the `shiny` package for rendering and interactive functionality.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   # Basic vertical split card with default settings
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Basic Split Card"),
#'       splitCard(
#'         shiny::div(h3("Left Panel"), p("Content for the left side.")),
#'         shiny::div(h3("Right Panel"), p("Content for the right side."))
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Horizontal split card with custom colors and minimum height
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Horizontal Split Card with Custom Styling"),
#'       splitCard(
#'         shiny::div(h3("Top Panel (Blue)"), p("Content for the top section.")),
#'         shiny::div(h3("Bottom Panel (Green)"), p("Content for the bottom section.")),
#'         bg.left.color = "#E0F2F7",
#'         bg.right.color = "#E8F5E9",
#'         splitter.color = "#7CB342",
#'         position = "horizontal",
#'         min.height = "300px",
#'         border.color = "#4CAF50"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Vertical split card with background images and specific widths
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Split Card with Background Images"),
#'       splitCard(
#'         shiny::div(h3("Image Background Left"), p("Some text over an image.")),
#'         shiny::div(h3("Image Background Right"), p("More text over another image.")),
#'         left.bg.url = "https://r2resize.obi.obianom.com/m/image1.jpg",
#'         right.bg.url = "https://r2resize.obi.obianom.com/m/image2.jpg",
#'         text.left.color = "white",
#'         text.right.color = "black",
#'         left.width = "30%",
#'         min.height = "450px"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
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
                      text.right.color = "black",
                      min.height = NULL,
                      left.width = NULL) {
  # fetch selected position
  position <- match.arg(position)

  # preset
  h.m.set <- ifelse(is.null(min.height),'200px',min.height)
  l.w.set <- ifelse(is.null(left.width),'50%',left.width)
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
    css <- gsub("mhw20x03", h.m.set, css)
    css <- gsub("lws50x73", l.w.set, css)
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


#' Resizable Split Screen Container Version 2 (Fixed Slider)
#'
#' Creates a highly customizable and resizable split screen container with a fixed, non-draggable slider position.
#' This version is ideal for presenting two content areas with a pre-defined division.
#'
#' @param left The content to be displayed in the left panel. Can be any `shiny::tagList` or HTML content.
#' @param right The content to be displayed in the right panel. Can be any `shiny::tagList` or HTML content.
#' @param bg.left.color The background color of the left panel. Can be a named R color (e.g., "red", "black") or a hexadecimal color code (e.g., "#333333").
#' @param bg.right.color The background color of the right panel. Can be a named R color or a hexadecimal color code.
#' @param border.color The border color of the entire container. Can be a named R color or a hexadecimal color code.
#' @param text.left.color The text color for the content within the left panel.
#' @param text.right.color The text color for the content within the right panel.
#' @param slider.position The fixed position of the slider as a percentage from 1 to 100 (e.g., "40" for 40\% left panel width). Defaults to "80".
#'
#' @details
#' Unlike `splitCard`, `splitCard2` provides a static split where the division between the left and right
#' content areas is set by the `slider.position` and cannot be interactively adjusted by the user.
#' This makes it suitable for layouts where the proportional display of content is fixed.
#' Common use cases include presenting questions and answers, code alongside output, or two related pieces of
#' information with a predetermined visual hierarchy.
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return A `shiny::div` element representing the split screen container style 2, ready for inclusion in a Shiny UI or R Markdown output.
#'
#' @family Container Functions
#' @seealso \code{\link{splitCard}}, \code{\link{sizeableCard}}, \code{\link{windowCard}}
#' @note This function requires the `shiny` package for rendering.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   # Basic split card 2 with a 40\% left panel
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Basic Fixed Split Card"),
#'       splitCard2(
#'         shiny::div(h1("Question:"), p("What is the capital of France?")),
#'         shiny::div(h1("Answer:"), p("Paris.")),
#'         slider.position = "40",
#'         bg.left.color = "#FFFDE7",
#'         bg.right.color = "#E8F5E9"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Split card 2 with custom text and border colors
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Styled Fixed Split Card"),
#'       splitCard2(
#'         shiny::div(h4("Left Side"), p("Detailed information here.")),
#'         shiny::div(h4("Right Side"), p("Corresponding summary or data.")),
#'         bg.right.color = "white",
#'         bg.left.color = "#F0F4C3",
#'         border.color = "#FFC107",
#'         text.left.color = "darkgreen",
#'         text.right.color = "darkblue",
#'         slider.position = "60"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
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
  uniquenum <- quickcode::number(1)
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



#' Resizable Container Content Holder with Size Controls
#'
#' Creates a highly customizable container that holds content and provides a mini toolbar on the right
#' for adjusting the content's display size (small, medium, large).
#'
#' @param ... The content to be placed inside the sizeable card. Can be any `shiny::tagList` or HTML content.
#' @param bg.color The background color of the content area. Can be a named R color (e.g., "red", "black") or a hexadecimal color code (e.g., "#333333").
#' @param border.color The border color of the container. Can be a named R color or a hexadecimal color code.
#'
#' @details
#' The `sizeableCard` function is designed to present content in a flexible box that users can
#' scale using intuitive "A" (small, medium, large) buttons integrated into a toolbar. This is useful
#' for displaying text, images, or other UI elements where the user might want to adjust their
#' size without altering the entire page layout. It provides a simple, self-contained resizing mechanism.
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @return A `shiny::div` element representing the sizeable container with a resizing toolbar, ready for inclusion in a Shiny UI or R Markdown output.
#'
#' @family Container Functions
#' @seealso \code{\link{splitCard}}, \code{\link{splitCard2}}, \code{\link{windowCard}}
#' @note This function requires the `shiny` package for rendering.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   # Simple sizeable card with default settings
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Basic Sizeable Card"),
#'       sizeableCard(
#'         shiny::p("This is some sample text within a sizeable card."),
#'         shiny::img(src = "https://r2resize.obi.obianom.com/m/image1.jpg", height = "100px"),
#'         shiny::p("Use the controls on the right to change its size.")
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Sizeable card with custom background and border colors
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Styled Sizeable Card"),
#'       sizeableCard(
#'         shiny::h4("My Report Summary"),
#'         shiny::p("This card contains important information about a project."),
#'         shiny::em("Adjust the size as needed."),
#'         bg.color = "#F0F4C3",
#'         border.color = "#C0CA33"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
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




#' Resizable, Moveable, and Expandable Window Card
#'
#' Creates an easily expandable, resizable, and moveable window-like container for content,
#' mimicking a desktop window within your Shiny application or HTML output.
#'
#' @param ... The content to be placed inside the window card. Can be any `shiny::tagList` or HTML content.
#' @param title The title displayed in the header of the window card.
#' @param width The initial width of the window card (e.g., "50\%", "600px").
#' @param bg.color The background color of the content area within the window card. Can be a named R color or a hexadecimal color code.
#' @param border.color The border color of the entire window card. Can be a named R color or a hexadecimal color code.
#' @param header.text.color The text color of the title in the header.
#' @param body.text.color The text color of the content within the card's body.
#'
#' @details
#' The `windowCard` function is a versatile UI component that allows for highly interactive content display.
#' Users can drag the window around the page, resize it from its edges, and expand/collapse its content.
#' This is particularly useful for pop-up information, draggable dashboards, or interactive panels in
#' complex Shiny applications. The window initially appears centered on the screen.
#'
#' @section Examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://rpkg.net/package/r2resize}.
#'
#' @note Due to the underlying JavaScript implementation and reliance on specific DOM IDs,
#' only one `windowCard` should be created per page to ensure proper functionality and avoid conflicts.
#' This function requires the `shiny` package for rendering and interactive functionality.
#'
#' @return A `shiny::div` element representing the moveable, resizable, and expandable window card.
#'
#' @family Container Functions
#' @seealso \code{\link{splitCard}}, \code{\link{splitCard2}}, \code{\link{sizeableCard}}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   # Simple window card with default attributes
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Interactive Window Card"),
#'       windowCard(
#'         shiny::h3("Welcome!"),
#'         shiny::p("This is a draggable and resizable window."),
#'         shiny::actionButton("closeBtn", "Close Window")
#'       )
#'     ),
#'     server = function(input, output) {
#'       observeEvent(input$closeBtn, {
#'         # Example: How you might handle closing (requires custom JS for actual close)
#'         showNotification("Window close requested (functionality not built-in)")
#'       })
#'     }
#'   )
#'
#'   # Custom styled window card with a plot
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Styled Window Card with Plot"),
#'       windowCard(
#'         title = "Dynamic Plot Window",
#'         width = "600px",
#'         bg.color = "#E8F5E9",
#'         border.color = "#4CAF50",
#'         header.text.color = "white",
#'         body.text.color = "#333333",
#'         shiny::plotOutput("myPlot")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$myPlot <- shiny::renderPlot({
#'         hist(rnorm(100), col = "skyblue", border = "white", main = "Random Normal Data")
#'       })
#'     }
#'   )
#' }
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

#' Create an Emphasis Card with a Dynamic Border
#'
#' Creates a container that visually emphasizes its content with a subtle, dynamic border effect.
#' This card is designed to draw user attention to important information or sections.
#'
#' @param ... The content to be placed inside the emphasis card. Can be any `shiny::tagList` or HTML content.
#' @param bg.color The background color of the content area. Can be a named R color (e.g., "red", "black") or a hexadecimal color code (e.g., "#333333").
#'
#' @details
#' The `empahsisCard` (and its alias `emphasisCard`) provides a unique visual cue to highlight content.
#' The border of the card subtly animates or changes, indicating that the content within is significant
#' or has a special status. This is ideal for calls to action, important notices, or featured content.
#'
#' @section More examples for r2resize:
#' More examples and demo pages are located at this link -
#' \url{https://r2resize.obi.obianom.com}.
#'
#' @return A `shiny::div` element representing the emphasis card with its dynamic border, ready for inclusion in a Shiny UI or R Markdown output.
#'
#' @family Container Functions
#' @seealso \code{\link{emphasisCard}} (alias), \code{\link{splitCard}}
#' @note This function requires the `shiny` package for rendering.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   # Simple emphasis card with basic text
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Emphasis Card Example"),
#'       empahsisCard(
#'         shiny::h4("Important Announcement!"),
#'         shiny::p("Please read this crucial message.")
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Emphasis card with a custom background color and multiple elements
#'   shinyApp(
#'     ui = fluidPage(
#'       h2("Styled Emphasis Card"),
#'       empahsisCard(
#'         shiny::h3("Featured Product"),
#'         shiny::img(src = "https://r2resize.obi.obianom.com/m/logo.png", height = "50px"),
#'         shiny::p("Check out our new amazing product!"),
#'         bg.color = "#FFEBEE"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
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
                        ...),css)
}


#' @inherit empahsisCard
#' @export
#'

emphasisCard <- empahsisCard
