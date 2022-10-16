# r2resize: In-text resizing of containers, images and tables in Rmarkdown and Quarto documents <img src="https://r2resize.obi.obianom.com/r2resize_logo.png" width="200" align="right"/>

### Official site: https://r2resize.obi.obianom.com

### Quick demo: https://r2resize.obi.obianom.com/r2resize-package.gif

[![CRAN\_Status\_Badge](https://img.shields.io/badge/rPkgNet-published-orange)](https://rnetwork.obi.obianom.com/package/r2resize) [![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/r2resize)](https://cran.r-project.org/package=r2resize) [![](https://cranlogs.r-pkg.org/badges/r2resize)](https://cran.r-project.org/package=r2resize) [![](https://cranlogs.r-pkg.org/badges/grand-total/r2resize)](https://cran.r-project.org/package=r2resize)

__The recommendation is that you download the latest version of this package from CRAN, as I am constantly updating this repository. If you do download from here, know that things may break sometimes__

## Installation 

```{r}
# From CRAN
install.packages(r2resize)

# OR from Github
library(devtools)
install_github("oobianom/r2resize")
```
## Use in Rmarkdown or Quarto document

### Load library

```{r}
library(r2resize)
```
### Include at the top of your documet

![](https://obianom.com/r2resize_card.png)

## Example of Rmarkdown inclusion

```
---
title: "r2resize example"
author: "Name"
date: "09/10/2022"
output:
  html_document:
    theme: default
    toc: true
    toc_depth: 3
    toc_float: true
---

# Theme setting

```{r,echo=TRUE}
r2resize::add.resizer(
  theme.color = "blue",
  position = "top",
  tables = TRUE,
  images = TRUE,
  line.color = "orange",
  line.height = 5
)

``

# Images Examples


# Single image

Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Amet massa vitae tortor condimentum lacinia quis vel eros. 

```{r pressure1, echo=FALSE}

plot(mtcars)

``

# Two images

Ut ornare lectus sit amet est placerat in. Risus in hendrerit gravida rutrum quisque non tellus orci ac. Viverra justo nec ultrices dui sapien eget. Elit scelerisque mauris pellentesque pulvinar pellentesque. 

```{r pressure2, echo=FALSE}

plot(pressure)

plot(cars)

``


# Three images

Imperdiet nulla malesuada pellentesque elit eget gravida. Turpis massa sed elementum tempus egestas.

```{r pressure3, echo=FALSE}

plot(pressure)

plot(mtcars)

plot(cars)

``

# Table Examples

## Use with dataTable 

Libero id faucibus nisl tincidunt. Ultrices tincidunt arcu non sodales neque sodales ut etiam. Ut placerat orci nulla pellentesque dignissim enim sit amet. Tempus quam pellentesque nec nam. 

```{r}

library(DT)
datatable(iris)

``



## Regular Markdown Table 1 and 2

Egestas purus viverra accumsan in. Eu ultrices vitae auctor eu augue ut lectus. Leo integer malesuada nunc vel risus commodo.

| Column 1 | Column 2 | Column 3 | Column 4 | Column 5 |
|----------|----------|----------|----------|----------|
| 1        | 23       | 1        | 45       | 6 - 12   |
| 3        | 4        | 5        | NA       | 4 - 5.5  |
| 7        | 7        | 5        | 0        | 5 - 34   |

| head1 | head2 | head3 | head4 | head5 |
|-------|-------|-------|-------|-------|
| 1     | 23    | 1     | A     | AA    |
| 3     | 4     | 5     | B     | BB    |
| 7     | 7     | 5     | C     | CC    |



## Single Markdown Table

| head1 | head2 | head3 | head4 | head5 |
|-------|-------|-------|-------|-------|
| 1     | 23    | 1     | A     | AA    |
| 3     | 4     | 5     | B     | BB    |
| 7     | 7     | 5     | C     | CC    |

```

### Example of the output document after inclusion

![](https://obianom.com/r2resize_card3.png)
