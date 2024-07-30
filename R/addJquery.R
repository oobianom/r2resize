#' Attach jQuery to current document
#'
#' The current function allows inclusion of jQuery in an HTML output
#'
#' @param version jQuery version
#' @note
#' This function holds significance across the entire package, particularly
#' in scenarios where a specific HTML output lacks the inclusion of the jQuery script
#' required by other functions within this package. It serves as a crucial mechanism for
#' ensuring that functionalities within the package remain operable even when the necessary
#' jQuery script is absent from the HTML page by default knitting. By providing a fallback option,
#' this function enhances the robustness and reliability of the package, allowing it to gracefully handle
#' situations where jQuery is not explicitly included. Its role is pivotal in maintaining
#' consistent behavior and functionality across diverse HTML environments, thereby
#' facilitating seamless integration and usage of the package across various web
#' development contexts.
#'
#' @return script tag with jQuery link
#' @examples
#' add.JQuery()
#' add.JQuery("3.7.0") # add a specific version
#' @export
#'
add.JQuery <- function(version = "3.5.1"){
  con <-paste0('<script src="https://code.jquery.com/jquery-',version,'.min.js" crossorigin="anonymous"></script>')
  attr(con, "html") <- TRUE
  class(con) <- c("html", "character")
  return(con)
}


