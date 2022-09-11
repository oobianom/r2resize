# r2resize: In-text resizing of images and tables in Rmarkdown and Quarto documents

## Installation 

```{r}
install.packages(r2resize)

```

## Use

### Load library

```{r}
library(r2resize)
```

### Include at the top of your Rmarkdown or Quarto document

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
  theme.color = "black",
  position = "top",
  font.size = "12px",
  font.color = "darkblue",
  tables = TRUE,
  images = TRUE,
  line.color = "orange",
  line.height = 5
)

```

# Images Examples


# Single image

Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Amet massa vitae tortor condimentum lacinia quis vel eros. 

```{r pressure1, echo=FALSE}

plot(mtcars)


```

# Two images

Ut ornare lectus sit amet est placerat in. Risus in hendrerit gravida rutrum quisque non tellus orci ac. Viverra justo nec ultrices dui sapien eget. Elit scelerisque mauris pellentesque pulvinar pellentesque. 

```{r pressure2, echo=FALSE}

plot(pressure)

plot(cars)

```


# Three images

Imperdiet nulla malesuada pellentesque elit eget gravida. Turpis massa sed elementum tempus egestas.

```{r pressure3, echo=FALSE}

plot(pressure)

plot(mtcars)

plot(cars)

```

# Table Examples

## Use with dataTable 

Libero id faucibus nisl tincidunt. Ultrices tincidunt arcu non sodales neque sodales ut etiam. Ut placerat orci nulla pellentesque dignissim enim sit amet. Tempus quam pellentesque nec nam. 

```{r}

library(DT)
datatable(iris)

```



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
