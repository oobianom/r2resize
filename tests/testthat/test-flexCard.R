test_that("Simple test for flexcard function", {
  r2resize::flexCard(
    item1 = c(
    bg = "https://r2resize.obi.obianom.com/m/image1.jpg",
    icon = "edit",
    title="Sample text 1",
    subtitle="A cool subtitle"),
    item2 = c(
    bg = "https://r2resize.obi.obianom.com/m/image2.jpg",
    icon = "edit",
    title="Sample text 2",
    subtitle="A cool subtitle",
    icon.color = "blue",
    text.color = "brown"
    )
  )
})
