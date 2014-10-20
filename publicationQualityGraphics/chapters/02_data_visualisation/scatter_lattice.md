

### 2.1. Scatter plots (lattice way)

Even with all the enhancements & progress made in the field of computer based graphics in recent years/decades, the best (as most intuitive) way to show the relationship between two continous variables remains the scatter plot. Just like for the smoothest ride, the best shape of the wheel is still round.

If, from our original diamonds data set we wanted to see the relation between price and carat of the diamonds (or more precisely how price is influenced by carat), we would use a scatter plot.


```r
scatter_lattice <- xyplot(price ~ carat, data = diamonds)

scatter_lattice
```

<figure><img src="../../book_figures/scatter lattice.png"><figcaption>Figure 1: a basic scatter plot produced with lattice</figcaption></figure>

What we see is that generally lower carat values tend to be cheaper. 

However, there is, especially at the high price end, a lot of scatter, i.e. there are diamonds of 1 carat that cost just as much as diamonds of 4 or more carat. Maybe this is a function of the cut? Let's see...

Another thing that we might be interested in is the nature and strength of the relationship that we see in our scatter plot. These plots are still the fundamental way of visualising linear (and non-linear) statistics between 2 (or more) variables. In our case (and I said we will only be marginally touching statistics here) let's try to figure out what the linear relationship between x (cut) and y (price) is. Given that we are plotting cut on the y-axis and the general linear regrssion formula is ```y ~ a + b*x``` means that we are assuming that cut is influencing (determining) price, NOT the other way round!!

Lattice is a very powerful package that provides a lot of flexibility and power to create all sorts of taylor-made staistical plots. In particular, it is designed to provide an easy to use framework for the representation of some vraible(s) conditioned on some other variable(s). This means, that we can easily show the same relationship from figure 1, btu this time for each of the different quality levels (the variable ```cut``` in the diamonds data set) into which diamonds can be classified. These conditionla subsets are called panels in lattice.

This is done using the ```|``` character just after the formula expression. So the complete formula would read:

```
y ~ x | g
``` 

y is a function of x conditional to the values of g (where g is usually a factorial variable)

The code below shows how all of this is achieved.

* plot ```price ~ carat``` conditional to ```cut```
* draw the regression line for each panel
* also provide the _R^2_ value for each panel


```r
scatter_lattice <- xyplot(price ~ carat | cut, 
                          data = diamonds, 
                          panel = function(x, y, ...) {
                            panel.xyplot(x, y, ...)
                            lm1 <- lm(y ~ x)
                            lm1sum <- summary(lm1)
                            r2 <- lm1sum$adj.r.squared
                            panel.abline(a = lm1$coefficients[1], 
                                         b = lm1$coefficients[2])
                            panel.text(labels = 
                                         bquote(italic(R)^2 == 
                                                  .(format(r2, 
                                                           digits = 3))),
                                       x = 4, y = 1000)
                            },
                          xscale.components = xscale.components.subticks,
                          yscale.components = yscale.components.subticks,
                          as.table = TRUE)

scatter_lattice
```

<figure><img src="../../book_figures/scatter lattice with panels and line.png"><figcaption>Figure 2: a panel plot showing regression lines for each panel produced with lattice</figcaption></figure>

This is where ```lattice``` becomes a bit more challenging, yet how do they say: with great power comes great complexity... (maybe I didn't get this quote completely correct, but it certainly reflects the nature of ```lattice's``` flexibility. A lot of things are possible, but they need a bit more effort than accepting the default settings.

Basically, what we have done here is to provide a so-called panel function (actually, we have provided 3 of them).

But let's look at this step-by-step... 

As ```lattice``` is geared towards providing plots in small multiples (as E. Tufte calls them) or panels it provides a ```panel = ``` argument to which we can assign certain functions that will be evaluated separately for each of the panels. There's a variety of pre-defined panel functions (such as the ones we used here - panel.xplot, panel.abline, panel.text & many more) but we can also define out own panel funtions. This is why ```lattice``` is so versatile and powerful. Basicall, writing panel functions is just like writing any other function in R (though some limitations do exist).

The important thing to note here is that ```x``` and ```y``` in the context of panel functions refer to the ```x``` and ```y``` variables we define in the plot definition, i.e. ```x = carat``` and ```y = price```. So, for the panel functions we can use these shorthands, like as we are doing in defining our linear model ```lm1 <- lm(y ~ x)```. This linear model will be calculated separately for each of the panels, which are basically nothing else than subsets of our data corresponding to the different levels of cut. Maybe it helps to think of this as a certain type of for loop:

```
for (level in levels(cut)) lm1 <- lm(price ~ carat)
```

This then enables us to access the outcome of this linear model separately for each panel and we can use ```panel.abline``` to draw a line in each panel corresponding to the calculated model coefficients ```a = Intercept``` and ```b = slope```. Hence, we are drawing the regression line which represents the line of least squares for each panel searately.

The same holds true for the calculation and plotting of the adjusted _R^2_ value for each linear model per panel. In this case we use the ```panel.text``` function to 'write' the corresponding value into each of the panel boxes. The location of the text is determined by the ```x = ``` and ```y = ``` arguments. This is where some car needs to be taken, as in the ```panel.text``` call ```x``` and ```y``` don't refer to the ```x``` and ```y``` variables of the global plot function (```xyplot```) anymore, but rather represent the locations of where to position the text within each of the panel boxes in the units used for each of the axes (in our case ```x = 4``` and ```y = 1000```).

There's two more things to note with regard to panel functions

1. In order to draw what we originally intended to draw, i.e. the scatterplot, we need to provide a panel function that represents our initial intention. In our case this is the rather blank call ```panel.xyplot(x, y, ...)```. Without this, the points of our plot will not be drawn and we will get a plot that only shows the regression line and the text (feel free to try it!). This seems like a good place to introduce one of the most awkward (from a programming point of view) but at the same time most awesome (from a users point of view) things in the R language. The ```...``` are a shorthand for 'everything else that is possible in a certain function'. This is both a very lazy and at the same time a very convenient way of passing arguments to a function. Bascially, this enables us to provide any additional argument that the function maight be able to understand. Any argument that ```xyplot``` is able to evaluate (understand) can be passed in addition to ```x``` and ```y```. Try ot yourself by, for example specifying ```col = "red"```. If we had not included ```, ...``` in the ```panel = function(x, y, ...)``` argumnt, the ```col = ``` definition would not be possible. Anyway, this is only a side note that is not really related to the topic at hand, so let's move on....

2. the order in which panel functions are supplied does matter. This means that the first panel function will be evaluated (and drawn) first, then the second, then the third and so on. Hence, if we were to plot the points of our plot on top of everything else, we would need to provide the ```panel.xyplot``` function as the last of the panel functions.

Right, so now we have seen how to use pnael functions to calculate and draw things specific to each panel. One thing I really dislike about ```lattice``` is the default graphical parameter settings (such as colours etc). However, changing these is rather straight forward. We can easily create our own themes by replacing the default values for each of the graphical parameters individually and saving these as our own themes. The function that let's us access the default (or already modified) graphical parameter settings is called ```trellis.par.get()```. Assigning this to a new object, we can modify every entry of the default settings to our liking (remember ```str()``` provides a 'road map' for accessing individual bits of an object).


```r
my_theme <- trellis.par.get()
my_theme$strip.background$col <- "grey80"
my_theme$plot.symbol$pch <- 16
my_theme$plot.symbol$col <- "grey60"
my_theme$plot.polygon$col <- "grey90"

l_sc <- update(scatter_lattice, par.settings = my_theme, 
               layout = c(3, 2),
               between = list(x = 0.3, y = 0.3))

print(l_sc)
```

<figure><img src="../../book_figures/latt panel scat2.png"><figcaption>Figure 3: a panel plot with modified settings of the lattice layout</figcaption></figure>

Apart from showing us how to change the graphical parameter settings, the above code chunk also highlights one of the very handy properties of ```lattice``` (which is also true for ```ggplot2```). We are able to store any plot we create in an object and can refer to this object later. This enables us to simply ```update``` the object rather than having to define it over (and over) again.

Lika many other packages, ```lattice``` has a companion called ```latticeExtra```. This package provides several additions/extensions to the core functionality of ```lattice```. One of the very handy additions is a panel function called ```panel.smoother``` which enables us to evaluate several linear and non-linear models for each panel individually. This means taht we actually don't need to calculate these models 'by hand' for each panel, but can use this pre-defined function to evaluate them. This is demonstrated in the next code chunk.

Note that we are still calcualting the linear model in order to be able to provide the _R^2_ value for each panel. We don't need the ```panel.abline``` anymore to draw the regeression line anymore. Actually, this is done using ```panel.smoother``` which also provides us with an estiation of the standard error related to the mean estimation of ```y``` for each ```x```. This may be hard to see, but there is a confidence band of the standard error plotted around the regression line in each panel. Note, unfortunately, the the confidence intervals are very narrow so that they are hard to see in the plot below.

For an overview of possible models to be specified using ```panel.smoother``` see ```?panel.smoother``` (in library ```latticeExtra```)


```r
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

print(l_sc)
```

<figure><img src="../../book_figures/latt panel smooth scat.png"><figcaption>Figure 4: a panel plot showing regression lines  and confidence intervals for each panel produced with lattice</figcaption></figure>

Having a look at the scatter plots we have produced so far, there is an obvious problem. There are so many points that it is impossible to determine their actual distribution. One way to address this problem could be to plot each point in a semi-transpatent manner. I have tried this potential solution and found that it does not help a great deal (but please feel free, and I highly encourage, to try ot yourself).

Hence, we need another way to address the over-plotting of points.

A potential remedy is to map the 2 dimensional space in which we plot to a grid and estimate the point density in each of the grid cells. This can be done using a so-called 2 dimensional kernel density estimator. We won't have the time to go into much detail about this method here, but we will see how this can be done...

To do this we need a so-called '2 dimensional kernel density estimator'. I won't go into much detail about the density estimation here. What is important for our purpose is that we actually need to estimate this twice. Once globally, meaning for the whole data set, in order to find the absolute extremes (minimum and maximum) of our data distribution. This is important for the colour mapping, because the values of each panel need to be mapped to a common scale in order to interpret them. In other words, this way we are making sure that the similar values of our data are represented by similar shades of, let's say red.

However, in order to be able to estimate the density for each of our panels we also need to do the same calculation in our panel function. 

Essentially what we are creating is a gridded data set (like a photo) of the density of points within each of the defined pixels. The ```lattice``` function for plotting gridded data is called ```levelplot()```.

Here's the code


```r
xy <- kde2d(x = diamonds$carat, y = diamonds$price, n = 100) 
xy_tr <- con2tr(xy)
offset <- max(xy_tr$z) * 0.2
z_range <- seq(min(xy_tr$z), max(xy_tr$z) + offset, offset * 0.01)

l_sc <- update(scatter_lattice, aspect = 1, par.settings = my_theme, 
               between = list(x = 0.3, y = 0.3),
               panel=function(x,y) {
                 xy <- kde2d(x,y, n = 100) 
                 xy.tr <- con2tr(xy)                 
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

print(l_sc)
```

<figure><img src="../../book_figures/latt dens scat.png"><figcaption>Figure 5: a lattice panel plot showing the point density within each panel</figcaption></figure>

It should not go unnoted that there is a panel function in ```lattice``` that does this for you. The function is called ```panel.smoothScatter()``` and unless we need to specify a custom colour palette, this is more than sufficient.

As a hint, if you want to use this panel function with your own colour palette you need to make sure that your pallette starts with white as otherwise things will look really weird...


```r
l_sc_smooth <- update(scatter_lattice, aspect = 1, 
                      par.settings = my_theme, 
                      between = list(x = 0.3, y = 0.3),
                      panel = panel.smoothScatter)

print(l_sc_smooth)
```

```
(loaded the KernSmooth namespace)
```

<figure><img src="../../book_figures/latt smooth scat.png"><figcaption>Figure 6: a lattice panel plot showing the point density within each panel using the panel function smoothScatter()</figcaption></figure>

This representation of our data basically adds another dimension to our plot which enables us to see that no matter what the quality of the diamond, most of the diamonds are actually of low carat and low price. Whether this is good or bad news, depends on your interpretation (and the size of your wallet, of course).
