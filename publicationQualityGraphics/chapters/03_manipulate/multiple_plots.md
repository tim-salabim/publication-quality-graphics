

### 3.1. multiple plots on one page

**In order to succeed plotting several of our previoulsly created plots on one page, there's two things of importance:**

1. the `lattice/ggplot2` plot objects need to be printed using `print(latticeObject)/print(ggplot2Object)`
2. we need to set `newpage = FALSE` in the print call so that the previously drawn elements are not deleted

Let's try and plot the ```lattice``` and `ggplot2` versions of our box and whisker plots and scatter plots next to each other on one page by setting up a suitable viewport structure.


```r
### clear plot area
grid.newpage()

### define first plotting region (viewport)
vp1 <- viewport(x = 0, y = 0, 
                height = 0.5, width = 0.5,
                just = c("left", "bottom"),
                name = "lower left")

### enter vp1 
pushViewport(vp1)

### show the plotting region (viewport extent)
grid.rect()

### plot a plot - needs to be printed (and newpage set to FALSE)!!!
print(l_bw, newpage = FALSE)
```

```
Error: object 'l_bw' not found
```

```r
### leave vp1 - up one level (into root vieport)
upViewport(1)

### define second plot area
vp2 <- viewport(x = 1, y = 0, 
                height = 0.5, width = 0.5,
                just = c("right", "bottom"),
                name = "lower right")

### enter vp2
pushViewport(vp2)

### show the plotting region (viewport extent)
grid.rect()

### plot another plot
print(g_bw, newpage = FALSE)
```

```
Error: object 'g_bw' not found
```

```r
### leave vp2
upViewport(1)


vp3 <- viewport(x = 0, y = 1, 
                height = 0.5, width = 0.5,
                just = c("left", "top"),
                name = "upper left")

pushViewport(vp3)

### show the plotting region (viewport extent)
grid.rect()

print(l_sc, newpage = FALSE)
```

```
Error: object 'l_sc' not found
```

```r
upViewport(1)


vp4 <- viewport(x = 1, y = 1, 
                height = 0.5, width = 0.5,
                just = c("right", "top"),
                name = "upper right")

pushViewport(vp4)

### show the plotting region (viewport extent)
grid.rect()

print(g_sc, newpage = FALSE)
```

```
Error: object 'g_sc' not found
```

```r
upViewport(1)
```

<figure><img src="../../book_figures/grid multiple.png"><figcaption>Figure 1: using the grid package to place multiple plots on one page</figcaption></figure>

So there we have it. Creating and navigating between viewports enables us to build a graphical layout in whatever way we want. In my opinion this is way better than saving all the plots to the hard drive and then using some sort of graphics software such as Photoshop or Inkscape to arrange the plots onto one page. After all, sometimes we may have several of these multi-plot-pages that we want to produce and now we know how to do this automatically and we won't need any post-production steps.
