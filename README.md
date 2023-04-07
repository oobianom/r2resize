# r2resize: In-text resizing of containers, images and tables in Rmarkdown documents and Shiny apps <img src="https://r2resize.obi.obianom.com/r2resize_logo.png" width="200" align="right"/>

### Official site: https://r2resize.obi.obianom.com

### Demo output: [View here](https://rstudio-pubs-static.s3.amazonaws.com/977399_37ed43a251fe493d87efe81c452b7f7d.html)

### Demo video: [View here](https://r2resize.obi.obianom.com/r2resize-package.gif)

### Sample R code to get started: [View here](https://github.com/oobianom/r2resize/blob/main/inst/examples/sample1.Rmd)

### Other packages required for r2resize: [View here](https://depends.rpkg.net/package/r2resize)

### RPKG.net package page for r2resize: [View here](https://rpkg.net/package/r2resize)

[![CRAN\_Status\_Badge](https://img.shields.io/badge/rPkgNet-published-orange)](https://rnetwork.obi.obianom.com/package/r2resize) [![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/r2resize)](https://cran.r-project.org/package=r2resize) [![](https://cranlogs.r-pkg.org/badges/r2resize)](https://cran.r-project.org/package=r2resize)
[![](https://cranlogs.r-pkg.org/badges/last-week/r2resize)](https://cran.r-project.org/package=r2resize)
[![](https://cranlogs.r-pkg.org/badges/grand-total/r2resize)](https://cran.r-project.org/package=r2resize)

_The recommendation is that you download the latest version of this package from CRAN, as I am constantly updating this repository. If you do download from here, know that things may break sometimes_


## Installation 

```{r}
# From CRAN
install.packages(r2resize)

# OR from Github
library(devtools)
install_github("oobianom/r2resize")
```

### Screenshots:

![](https://r2resize.obi.obianom.com/m/resizers.png)

Code:
```
r2resize::add.resizer(
  theme.color = "black",
  position = "top",
  font.size = "12px",
  font.color = "black",
  tables = TRUE,
  images = TRUE,
  line.color = "orange",
  line.height = 5,
  line.width = 200
)
```

### As of version 1.6, the flexCard() function

Output:

![](https://r2resize.obi.obianom.com/m/r2resize_flexcard_2.gif)

Code:
```
flexCard(
  image = c(bg = "image1.jpg", icon = "edit", title="Sample text 1",subtitle="A cool subtitle"),
  image = c(bg = "image2.jpg", icon = "fire", title="Another sample text",subtitle="Focused subt title"),
  image = c(bg = "image3.jpg", icon = "wifi", title="Sample text 2",subtitle="Color text",text.color="brown"),
  image = c(bg = "image4.jpg", icon = "user", title="Sample text 3",subtitle="Color text and icon",icon.color="blue",text.color="purple"),
  image = c(bg = "image5.jpg", icon = "folder", title="Sample text 3",subtitle="Sub it is"),
  image = c(bg = "image6.jpg", icon = "key", title="Sample text 4",subtitle="Sub it is"),
  image = c(bg = "image7.jpg", icon = "lock", title="Smaple",subtitle="Sub it is",text.color="green"),
  image = c(bg = "image8.jpg", icon = "plus",icon.color="red"),
  border.color = "gray",
  border.width.px = 0,
  active.panel = 2
)
```

### Also, the elastiCard() function

Output:

![](https://r2resize.obi.obianom.com/m/r2resize_elasticard_1.gif)

Code:
```
elastiCard(
  image = c(bg = "image1.jpg", title="Sample text 3",subtitle="Sub it is",descr="Sample description"),
  image = c(bg = "image2.jpg", icon = "key", title="Sample text 4",subtitle="Sub it is"),
  image = c(bg = "image3.jpg", icon = "lock", title="Smaple",subtitle="Sub it is",text.color="brown"),
  image = c(bg = "image4.jpg"),
  border.color = "black",
  border.width.px = 5
)

```

### Also, the splitCard2() function

Output:

![](https://r2resize.obi.obianom.com/m/r2resize_splitcard2_1.gif)

Code:
```
splitCard2(
  "question text 1",
  "answer text 2",
  bg.right.color = "black",
  bg.left.color = "red",
  text.left.color = "white",
  text.right.color = "white",
  slider.position = "95"
)

```

## And so many more cool features...

### windowCard()

![](https://r2resize.obi.obianom.com/m/r2resize_windowcard_1.gif)

### emphasisCard()

![](https://r2resize.obi.obianom.com/m/r2resize_emphasiscard_1.gif)


### sizeableCard()

![](https://r2resize.obi.obianom.com/m/r2resize_sizeablecard_1.gif)


### splitCard()

![](https://r2resize.obi.obianom.com/m/r2resize_splitcard_1.gif)



_NOTE: Please note that r2resize::add.resizer() should only be used in Rmarkdown or Quarto_

## Use in Shiny, Rmarkdown or Quarto document

### Load library and begin using functions

```{r}
library(r2resize)
```


