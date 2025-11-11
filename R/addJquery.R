#' @title Attach jQuery to an HTML Document for r2resize Components
#'
#' @description This function dynamically includes the jQuery library into an HTML output. It's particularly useful when
#' other functions within the `r2resize` package, which rely on jQuery, are used in an environment (like a knitted R Markdown document
#' or a Shiny application) where jQuery might not be automatically present or where a specific version is required.
#'
#' @details The `add.JQuery` function generates a `<script>` HTML tag that links to a specified version of the jQuery library
#' from a Content Delivery Network (CDN). By calling this function, you ensure that the necessary jQuery functionalities
#' are available for `r2resize`'s interactive components, such as those used in `splitCard`, `sizeableCard`, or `windowCard`.
#' This function adds the `html` and `character` classes to the output, making it compatible with `htmltools::htmlDependency`
#' and other HTML rendering contexts in R.
#'
#' @param version A character string specifying the desired jQuery version (e.g., "3.5.1", "3.7.0").
#'   Defaults to "3.5.1" if no version is provided. Ensure the version specified is available on the jQuery CDN.
#'
#' @note
#' This function is crucial for maintaining the robustness and reliability of the `r2resize` package.
#' It acts as a fallback mechanism, ensuring that interactive functionalities remain operational even
#' when jQuery is not explicitly included in the HTML page by default. This enhances the package's
#' ability to gracefully handle diverse HTML environments, facilitating seamless integration and usage.
#'
#' @return An HTML `<script>` tag as a character string, with `html` and `character` classes, containing the link to the jQuery library.
#'
#' @examples
#' # Attach the default jQuery version (3.5.1)
#' r2resize::add.JQuery()
#'
#' # Attach a specific jQuery version (e.g., 3.7.0)
#' r2resize::add.JQuery("3.7.0")
#'
#' # This function is often used implicitly by other r2resize components,
#' # but can be manually added to ensure jQuery is present in a custom HTML context.
#'
#' # Example in a simple R Markdown chunk (won't render fully without proper setup)
#' \dontrun{
#' r2resize::add.JQuery()
#' htmltools::div("This text requires jQuery for some interactive features.")
#' }
#' @seealso
#' \code{\link{splitCard}} for an example of a `r2resize` component that might rely on jQuery.
#'
#' @export
#'
add.JQuery <- function(version = "3.5.1"){
  con <-paste0('<script src="https://code.jquery.com/jquery-',version,'.min.js" crossorigin="anonymous"></script>')
  attr(con, "html") <- TRUE
  class(con) <- c("html", "character")
  return(con)
}
