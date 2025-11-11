library(testthat)
library(r2resize)
library(htmltools)

test_that("add.JQuery returns a script tag with html class", {
  jquery_output <- add.JQuery()
  expect_true(inherits(jquery_output, "html"))
  expect_true(inherits(jquery_output, "character"))
  expect_true(grepl("<script src=\"https://code.jquery.com/jquery-3.5.1.min.js\"", jquery_output))

  jquery_output_v370 <- add.JQuery("3.7.0")
  expect_true(grepl("<script src=\"https://code.jquery.com/jquery-3.7.0.min.js\"", jquery_output_v370))
})
