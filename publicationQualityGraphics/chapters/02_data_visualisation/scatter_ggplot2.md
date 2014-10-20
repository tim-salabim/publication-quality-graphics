

### 2.3. Scatter plots (ggplot2 way)

Now let's try to recreate what we have achieved with ```lattice``` using ```ggplot2```.

```ggplot2``` is radically different from the way that ```lattice``` works. ```lattice``` is much closer to the traditional way of plotting in R. There are different functions for different types of plots. In ```ggplot2``` this is diffrent. Every plot we want to draw, is, at a fundamental level, created in exactly the same way. What differs are the subsequent calls on how to represent the individual plot components (basically ```x``` and ```y```). This means a much more consistent way of *building* visualisations, but it also means that things are rather different from what you might have learned about syntax and structure of (plotting) objects in R. But not to worry, even I managed to understand how thing are done in ```ggplot2``` (and prior to writing this I had almost never used it before).

Before I get carried away too much let's jump right into our first plot using ```ggplot2```


```r
scatter_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds)

g_sc <- scatter_ggplot + geom_point()

print(g_sc)
```

<figure><img src="../../book_figures/gg scat.png"><figcaption>Figure 1: a basic scatter plot created with ggplot2</figcaption></figure>

Similar to ```lattice```, plots are (usually) stored in objects. But that is about all the similarity there is.

Lets's look at the above code in a little more detail. The first line is the fundamental definition of **what** we want to plot. We provide the 'aesthetics' for the plot (```aes()```) We state that we want the values on the x-axis to represent carat and the y-values are price. The data set to take these variables from is the diamonds data set. That's basically it, and this will not change a hell of a lot in the subsequent plotting routines.

What will change in the plotting code chunks that follow is **how** we want the relatioship between these variables to be represented in our plot. This is done by defining so-called geometries (```geom_...()```). In this first case we stated that we want the relationship between ```x``` and ```y``` to be rpresented as points, hence we used ```geom_point()```.

If we wanted to provide a plot showing the relationship between price and carat in panels representing the quality of the diamonds, we need what in ```gglot2``` is called facetting (panels in ```lattice```). To achive this, we simply repeat our plotting call from earlier and add another layer to the call which does the facetting.


```r
g_sc <- scatter_ggplot + 
  geom_point() +
  facet_wrap(~ cut)

print(g_sc)
```

<figure><img src="../../book_figures/gg facet scat.png"><figcaption>Figure 2: ggplot2 version of a facetted plot</figcaption></figure>

One thing that some people dislaike about the default settings in ```ggplot2``` is the grey background of the plots. This grey background is, in my opinion, a good idea when colors are involved as it tends to increase the contrast of the colours. If, however, the plot is a simple black-and-white scatter plot as in our case here, a white panel, or better facet background seems more reasonable. We can easily change this using a pre-defined theme called ```theme_bw()```.

In order to provide the regression line for each panel like we did in ```lattice```, we need a function called ```stat_smooth()```. This is fundamentally the same function that we used earlier, as the ```panel.smoother()``` in ```lattice``` is based on ```stat_smooth()```.

Putting this together we could do something like this (note that we also change the number of rows and columns into which the facets should be arranged):


```r
g_sc <- scatter_ggplot + 
  #geom_tile() +
  geom_point(colour = "grey60") +
  facet_wrap(~ cut, nrow = 2, ncol = 3) +
  theme_bw() +
  stat_smooth(method = "lm", se = TRUE, 
              fill = "black", colour = "black")

print(g_sc)
```

<figure><img src="../../book_figures/gg facet smooth scat.png"><figcaption>Figure 3: a ggplot2 panel plot with modified theme and added regression lines and confidence bands for each panel</figcaption></figure>

Simple and straight forward, and the result looks rather similar to the ```lattice``` version we created earlier.

Creating a point density scatter plot in ```ggplot2``` is actually a fair bit easier than in ```lattice```, as ```gglot2``` provides several predfined ```stat_...()``` function calls. One of these is designed to create 2 dimensional kernel density estimations, just what we want. However, this is where the syntax of ```ggplot2``` really becomes a bit abstract. he definition of the fill argument of this call is ```..density..```, which, at least to me, does not seem very intuitive. 

Furthermore, it is not quite sufficient to supply the stat function, we also need to state how to map the colours to that stat definition. Therefore, we need yet another layer which defines what colour palette to use. As we want a continuous variable (density) to be filled with a gradient of n colours, we need to use ```scale_fill_gradientn()``` in which we can define the colours we want to be used.


```r
g_sc <- scatter_ggplot + 
  geom_tile() +
  #geom_point(colour = "grey60") +
  facet_wrap(~ cut, nrow = 3, ncol = 2) +
  theme_bw() +
  stat_density2d(aes(fill = ..density..), n = 100,
                 geom = "tile", contour = FALSE) +
  scale_fill_gradientn(colours = c("white",
                                   rev(clrs_hcl(100)))) +
  stat_smooth(method = "lm", se = FALSE, colour = "black") +
  coord_fixed(ratio = 5/30000)

print(g_sc)
```

<figure><img src="../../book_figures/gg dens scat.png"><figcaption>Figure 4: ggplot2 version of a panel plot showing point densities in each panel</figcaption></figure>
