

### 3.2. manipulating existing plots

Another application of `grid` is to manipulate an existing plot object. You may have noted that our version of the 2D density scatter plot produced with `lattice` lacks a colour key. This can be easily added using `grid`. As `lattice` is built upon `grid`, it produces a lot of viewports in the creation of the plots (like our scatter plot). We can, after they have been set up, navigate to each of these and edit them or delete them or add new stuff. Looking at the `ggplot2` version of the density scatter, we see that this has a colour key which is placed to right of the main plot. Given that we have 5 panels, we actually have some 'white' space that we could use for the colour key placement, thus making better use of the available space...

In order to do so, we need to know into which of the viewports created by `lattice` we need to navigate. Therefore, we need to know their names. `lattice` provides a function for this. We can use `trellis.vpname()` to extract the name(s) of the viewport(s) we are interested in. `lattice` provides a structured naming convention for its viewports. We can use this to specify what viewport name(s) we want to extract. As we are interested in the viewport that comprises the main figure, we will tell `lattice` to extract this name (see below in the code). Then we can navigate into this viewport `downViewport()` and set up a new viewport in the main plotting area (the figure viewport) to make use of the existing 'white' space. Remember that the default units of `grid` are 0 - 1. This means that we can easily calculate the necessary viewport dimensions. Let's see how this is done (Note, we are actually creating 2 new viewports in the figure area, one for the colour key and another one for the colour key label).


```r
my_theme <- trellis.par.get()
my_theme$strip.background$col <- "grey80"
my_theme$plot.symbol$pch <- 16
my_theme$plot.symbol$col <- "grey60"
my_theme$plot.polygon$col <- "grey90"

scatter_lattice <- xyplot(price ~ carat | cut, 
                          data = diamonds, 
                          panel = function(x, y, ...) {
                            panel.xyplot(x, y, ...)
                            lm1 <- lm(y ~ x)
                            lm1sum <- summary(lm1)
                            r2 <- lm1sum$adj.r.squared
                            panel.text(labels = 
                                         bquote(italic(R)^2 == 
                                                  .(format(r2, 
                                                           digits = 3))),
                                       x = 4, y = 1000)
                            panel.smoother(x, y, method = "lm", 
                                           col = "black", 
                                           col.se = "black",
                                           alpha.se = 0.3)
                            },
                          xscale.components = xscale.components.subticks,
                          yscale.components = yscale.components.subticks,
                          as.table = TRUE)

l_sc <- update(scatter_lattice, par.settings = my_theme)
xy <- kde2d(x = diamonds$carat, y = diamonds$price, n = 100) 
xy_tr <- con2tr(xy)
offset <- max(xy_tr$z) * 0.2
z_range <- seq(min(xy_tr$z), max(xy_tr$z) + offset, offset * 0.01)

l_sc <- update(scatter_lattice, aspect = 1, par.settings = my_theme, 
               between = list(x = 0.3, y = 0.3),
               panel=function(x,y) {
                 xy <- kde2d(x,y, n = 100) 
                 xy_tr <- con2tr(xy)                 
                 panel.levelplot(xy_tr$x, xy_tr$y, xy_tr$z, asp = 1,
                                 subscripts = seq(nrow(xy_tr)), 
                                 contour = FALSE, region = TRUE, 
                                 col.regions = c("white", 
                                                 rev(clrs_hcl(10000))),
                                 at = z_range)
                 lm1 <- lm(y ~ x)
                 lm1sum <- summary(lm1)
                 r2 <- lm1sum$adj.r.squared
                 panel.abline(a = lm1$coefficients[1], 
                              b = lm1$coefficients[2])
                 panel.text(labels = 
                              bquote(italic(R)^2 == 
                                       .(format(r2, digits = 3))),
                            x = 4, y = 1000)
                 #panel.xyplot(x,y) 
                 } 
               ) 


grid.newpage()
#grid.rect()
print(l_sc, newpage = FALSE)
#grid.rect()
downViewport(trellis.vpname(name = "figure"))
#grid.rect()
vp1 <- viewport(x = 1, y = 0, 
                height = 0.5, width = 0.3,
                just = c("right", "bottom"),
                name = "legend.vp")

pushViewport(vp1)
#grid.rect()

vp1_1 <- viewport(x = 0.2, y = 0.5, 
                  height = 0.7, width = 0.5,
                  just = c("left", "centre"),
                  name = "legend.key")

pushViewport(vp1_1)
#grid.rect()

key <- draw.colorkey(key = list(col = c("white", rev(clrs_hcl(10000))),
                                at = z_range), draw = TRUE)

seekViewport("legend.vp")
#grid.rect()
vp1_2 <- viewport(x = 1, y = 0.5, 
                  height = 1, width = 0.3,
                  just = c("right", "centre"),
                  name = "legend.text", angle = 0)

pushViewport(vp1_2)
#grid.rect()

grid.text("estimated point density", 
          x = 0, y = 0.5, rot = 270, 
          just = c("centre", "bottom"))

upViewport(3)
```

<figure><img src="../../book_figures/grid manipulate.png"><figcaption>Figure 1: using the grid package to add a color key to an existing lattice plot object</figcaption></figure>

Not too complicated, ey. And, in comparison to the `ggplot2` version, we are utilising the available space a bit more efficiently. Though, obviously, we could also manipulate the `ggplot2` density scatter plot (or any other plot) in a similar manner. 

I hope it became clear just how useful `grid` can be and how it provides us with tools which enable us to produce individual graphics that satisfy our needs. 

So far, we have put our efforts into plot creation. I think, by now, we have a few tools handy to achieve what we want, so let's see how we can save our graphics to our hard drive.
