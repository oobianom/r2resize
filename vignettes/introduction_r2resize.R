## ----eval=TRUE,echo=TRUE------------------------------------------------------
r2resize::add.resizer(
  theme.color = "black",
  position = "top",
  font.size = "12px",
  font.color = "darkblue",
  tables = TRUE,
  images = TRUE,
  line.color = "orange",
  line.width = 150
)

## ----eval=TRUE,echo=TRUE------------------------------------------------------
library(r2symbols)
r2resize::emphasisCard("text1",symbol("ram","hippopotamus","alpha","beta",font.size=50), bg.color = "#f1f1f1")

