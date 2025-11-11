library(testthat)
library(r2resize)

test_that("sample function returns a vector of correct length and class", {
  set.seed(123)
  x <- 1:10
  n <- 5
  result <- sample(x, n)
  expect_length(result, n)
  expect_type(result, "integer")
  expect_true(all(result %in% x))

  set.seed(123)
  y <- letters[1:5]
  m <- 3
  result_char <- sample(y, m)
  expect_length(result_char, m)
  expect_type(result_char, "character")
  expect_true(all(result_char %in% y))
})

test_that("sample function handles replace = TRUE", {
  set.seed(123)
  x <- 1:3
  n <- 5
  result_replace <- sample(x, n, replace = TRUE)
  expect_length(result_replace, n)
  expect_type(result_replace, "integer")
  expect_true(all(result_replace %in% x))
})

test_that("sample function handles probabilities", {
  set.seed(123)
  x <- c("A", "B", "C")
  probs <- c(0.1, 0.2, 0.7)
  n <- 100
  result_probs <- sample(x, n, replace = TRUE, prob = probs)
  expect_length(result_probs, n)
  expect_type(result_probs, "character")
  # A more robust test would involve chi-squared test for distribution
  # For now, just check that all samples are from x
  expect_true(all(result_probs %in% x))
})

test_that("sample function errors on invalid input", {
  expect_error(sample(1:5, 10, replace = FALSE)) # n > length(x) without replace
  expect_error(sample(1:5, 3, prob = c(0.1, 0.2))) # incorrect prob length
  expect_error(sample(1:5, 3, prob = c(0.1, -0.2, 0.3, 0.4, 0.5))) # negative probability
})
