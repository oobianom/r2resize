library(testthat)
library(r2resize)
library(shiny)

test_that("splitCard returns a div with html class", {
  card_output <- splitCard("Left content", "Right content")
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-resizablediv-panel", as.character(card_output)))
})

test_that("splitCard2 returns a div with html class", {
  card_output <- splitCard2(h1("Question 1"), h1("Answer 1"))
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2rsC2", as.character(card_output)))
})

test_that("sizeableCard returns a div with html class", {
  card_output <- sizeableCard("Sample text")
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-rezconcard-holder", as.character(card_output)))
})

test_that("windowCard returns a div with html class", {
  card_output <- windowCard("Sample text")
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-windowcard-pane", as.character(card_output)))
})

test_that("empahsisCard returns a div with html class", {
  card_output <- empahsisCard("Sample text")
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-emphasizeDiv", as.character(card_output)))
})

test_that("emphasisCard alias works", {
  card_output <- emphasisCard("Sample text")
  expect_true(inherits(card_output, "shiny.tag"))
  expect_true(grepl("r2resize-emphasizeDiv", as.character(card_output)))
})
