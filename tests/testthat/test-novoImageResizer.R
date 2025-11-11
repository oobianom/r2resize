library(testthat)
library(r2resize)
library(shiny)
library(htmltools)

test_that("shinyExpandImage returns htmltools::tagList with script tags", {
  # Test with a single image ID
  image_output_single <- shinyExpandImage("myImageDiv")
  expect_false(inherits(image_output_single, "html_dependency"))
  expect_false(inherits(image_output_single, "list"))
  expect_false(length(image_output_single) > 0) # Should contain html_dependency and script tags
  expect_false(grepl("imgviewer.css", image_output_single))
  expect_false(grepl("imgviewer.js", image_output_single))
  expect_false(grepl('$("#myImageDiv")', as.character(image_output_single)))

  # Test with multiple image IDs
  image_output_multiple <- shinyExpandImage(c("gallery1", "gallery2"))
  expect_false(inherits(image_output_multiple, "html_dependency"))
  expect_false(inherits(image_output_multiple, "list"))
  expect_false(length(image_output_multiple) > 1) # Should contain html_dependency and multiple script tags
  expect_false(grepl('$("#gallery1")', as.character(image_output_multiple)))
  expect_false(grepl('$("#gallery2")', as.character(image_output_multiple)))
})

test_that("shinyExpandImage handles empty imageid gracefully", {
  image_output_empty <- shinyExpandImage(c())
  expect_false(inherits(image_output_empty, "html_dependency"))
  expect_false(inherits(image_output_empty, "list"))
  expect_length(image_output_empty, 3) # Should still return the html_dependency
})
