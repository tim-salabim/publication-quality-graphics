

### 3.1. multiple plots on one page

**In order to succeed plotting several of our previoulsly created plots on one page, there's two things of importance:**

1. the `lattice/ggplot2` plot objects need to be printed using `print(latticeObject)/print(ggplot2Object)`
2. we need to set `newpage = FALSE` in the print call so that the previously drawn elements are not deleted

Let's try and plot some ```lattice``` and `ggplot2` plots next to each other on one page by setting up a suitable viewport structure. First of all we obviously need to produce plots. We will produce very basic plots here, but this should work with whatever `lattice` or `ggplot2` object you have created earlier.


```r
p1_lattice <- xyplot(price ~ carat, data = diamonds)
p2_lattice <- histogram(~ price, data = diamonds)

p1_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point()
p2_ggplot <- ggplot(diamonds, aes(x = price)) +
  geom_histogram()

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
print(p1_lattice, newpage = FALSE)

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
print(p2_lattice, newpage = FALSE)

### leave vp2
upViewport(1)


vp3 <- viewport(x = 0, y = 1, 
                height = 0.5, width = 0.5,
                just = c("left", "top"),
                name = "upper left")

pushViewport(vp3)

### show the plotting region (viewport extent)
grid.rect()

print(p1_ggplot, newpage = FALSE)

upViewport(1)


vp4 <- viewport(x = 1, y = 1, 
                height = 0.5, width = 0.5,
                just = c("right", "top"),
                name = "upper right")

pushViewport(vp4)

### show the plotting region (viewport extent)
grid.rect()

print(p2_ggplot, newpage = FALSE)

upViewport(1)
```

<figure><img src="../../book_figures/grid multiple.png"><figcaption>Figure 1: using the grid package to place multiple plots on one page</figcaption></figure>

So there we have it. Creating and navigating between viewports enables us to build a graphical layout in whatever way we want. In my opinion this is way better than saving all the plots to the hard drive and then using some sort of graphics software such as Photoshop or Inkscape to arrange the plots onto one page. After all, sometimes we may have several of these multi-plot-pages that we want to produce and now we know how to do this automatically and we won't need any post-production steps.
