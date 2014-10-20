## 2. Data visualisation

In the next few sections, we will produce several varieties of *scatter plots*, *box & whisker plots*, *plots with error bars*, *histograms* and *density plots*. All of these will first be produced using the ```lattice``` package and then an attempt is made to recrate these in (pretty much) the exact same way in ```ggplot2```. First, the default versions are created and then we will see how they can be modified in order to produce plots that satisfy the requirements of most academic journals.    

We will see that some things are easier to achive using ```lattice```, some other things are easier in ```ggplot2```, so it is good to learn how to use both of them...

Before we start, we need to load the necessary packages and data set again


```r
### here's a rather handy way of loading all packages that you need
### for your code to work in one go
libs <- c('ggplot2', 'latticeExtra', 'gridExtra', 'MASS', 
          'colorspace', 'plyr', 'Hmisc', 'scales')
lapply(libs, require, character.only = TRUE)

### load the diamonds data set (comes with ggplot2)
data(diamonds)
```
