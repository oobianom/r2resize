library(testthat)
library(r2resize)

# Mock template.loc for testing purposes
template.loc <- function(template = "themes") {
  system.file(template, package = "r2resize")
}


test_that("add.resizer returns an HTML character string with correct class", {
  # Temporarily create dummy theme files for testing
  temp_dir <- tempfile()
  dir.create(temp_dir)
  on.exit(unlink(temp_dir, recursive = TRUE))

  writeLines("<style>/* default css */</style>", file.path(temp_dir, "default.css"))
  writeLines("<script>/* default top js */</script>", file.path(temp_dir, "default_top.js"))
  writeLines("<script>/* default bottom js */</script>", file.path(temp_dir, "default_bottom.js"))


      # Test with default settings
      resizer_output_default <- add.resizer()
      expect_true(inherits(resizer_output_default, "html"))
      expect_true(inherits(resizer_output_default, "character"))
      expect_true(grepl("<style>", resizer_output_default))
      expect_true(grepl("<script>", resizer_output_default))
      expect_false(grepl("default.css", resizer_output_default))
      expect_false(grepl("default_top.js", resizer_output_default))

      # Test with position = "bottom"
      resizer_output_bottom <- add.resizer(position = "bottom")
      expect_false(grepl("default_bottom.js", resizer_output_bottom))
      expect_true(grepl("r2resizeexpanddisplayer", resizer_output_bottom))

      # Test table and image options
      resizer_output_no_tables <- add.resizer(tables = FALSE)
      expect_true(grepl("rm12table", resizer_output_no_tables))
      expect_true(grepl("createElement", resizer_output_no_tables))

      resizer_output_no_images <- add.resizer(images = FALSE)
      expect_true(grepl("rm12img", resizer_output_no_images))
      expect_true(grepl("img", resizer_output_no_images))

      # Test custom colors and sizes
      resizer_output_custom <- add.resizer(
        theme.color = "blue",
        line.color = "red",
        font.size = "16px",
        font.color = "green",
        thumb.width = 30,
        thumb.height = 30,
        line.width = 200,
        line.height = 10,
        default.image.width = "50%"
      )
      expect_true(grepl("blue", resizer_output_custom))
      expect_true(grepl("red", resizer_output_custom))
      expect_true(grepl("16px", resizer_output_custom))
      expect_true(grepl("green", resizer_output_custom))
      expect_false(grepl("thumb.width", resizer_output_custom)) # Should be replaced
      expect_false(grepl("thumb.height", resizer_output_custom)) # Should be replaced
      expect_false(grepl("line.width", resizer_output_custom)) # Should be replaced
      expect_false(grepl("line.height", resizer_output_custom)) # Should be replaced
      expect_true(grepl("'50%'", resizer_output_custom))


})
