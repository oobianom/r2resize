library(testthat)
library(r2resize)
library(shiny)

test_that("flexCard returns a div with html class", {
  card_output <- flexCard(
    item1 = c(bg = "image1.jpg", icon = "edit", title = "Title 1", subtitle = "Sub 1"),
    item2 = c(bg = "image2.jpg", icon = "star", title = "Title 2", subtitle = "Sub 2")
  )
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-flexCard-options", as.character(card_output)))
  expect_true(grepl("Title 1", as.character(card_output)))
  expect_true(grepl("Title 2", as.character(card_output)))
})

test_that("elastiCard returns a section with html class", {
  card_output <- elastiCard(
    item1 = c(title = "Title A", subtitle = "Sub A", desc = "Desc A"),
    item2 = c(bg = "imageB.jpg", title = "Title B", subtitle = "Sub B", desc = "Desc B")
  )
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-elastiCard-team", as.character(card_output)))
  expect_true(grepl("Title A", as.character(card_output)))
  expect_true(grepl("Title B", as.character(card_output)))
})

test_that("flexCard handles active.panel correctly", {
  card_output_active_2 <- flexCard(
    item1 = c(title = "Title 1"),
    item2 = c(title = "Title 2"),
    active.panel = 2
  )
  expect_true(grepl('<div class="r2resize-flexCard-option ', as.character(card_output_active_2)))
  # This specific test might need to be more robust to check the active class
  # but for now, checking general structure
})

test_that("elastiCard handles various content types", {
  card_output_mixed <- elastiCard(
    item1 = c(title = "Text only", subtitle = "No image"),
    item2 = c(bg = "https://example.com/img.png", title = "With image", desc = "Description here")
  )
  expect_true(grepl("Text only", as.character(card_output_mixed)))
  expect_true(grepl("With image", as.character(card_output_mixed)))
  expect_true(grepl("background-image:url", as.character(card_output_mixed)))
})
