

### 2.5. Box an whisker plots (ggplot2 way)

As much as I love ```lattice```, I always end up drawing box and whisker plots with ```ggplot2``` because they look so much nicer and there's no need to modify so many graphical parameter settings in order to get an acceptable result.

You will see what I mean when we plot a ```ggplot2``` version using the default settings.


```r
bw_ggplot <- ggplot(diamonds, aes(x = color, y = price))

g_bw <- bw_ggplot + geom_boxplot()

print(g_bw)
```

<figure><img src="../../book_figures/gg bw1.png"><figcaption>Figure 1: a basic ggplot2 bw-plot</figcaption></figure>

This is much much better straight away!!

And, as we've alrady seen, the facetting is also just one more line...


```r
bw_ggplot <- ggplot(diamonds, aes(x = color, y = price))

g_bw <- bw_ggplot + 
  geom_boxplot(fill = "grey90") +
  theme_bw() +
  facet_wrap(~ cut)

print(g_bw)
```

<figure><img src="../../book_figures/gg facet bw.png"><figcaption>Figure 2: ggplot2 panel bw-plot</figcaption></figure>

So far, you may have gotten the impression that pretty much everything is a little bit easier the ```ggplot2``` way. Well, a lot of things are, but some are not. If we wanted to highlight the relative sample sizes of the different colour levels like we did earlier in ```lattice``` (using ```varwidth = TRUE```) we have to put a little more effort into ```ggplot2```. Meaning, we have to calculate this ourselves. There is no built in functionality for this feature (yet), at least none that I am aware of.

But, it is not too complicated. The equation for this adjustment is rather straight forward, we simply take the square root of the counts for each colour and divide it by the overall number of observations. Then we standardise this relative to the maximum of this calculation. As a final step, we need to break this down to each of the panels of the plot. This is the toughest part of it. I won't go into any detail here, but the ```llply``` pat of the following code chunk is basically the equivalent of what is going on behind the scenes of ```lattice``` (though ```lattice``` most likely does not use ```llply```).

Anyway, it does not require too many lines of code to achive the box width adjustment in ```ggplot2```.


```r
w <- sqrt(table(diamonds$color)/nrow(diamonds))
### standardise w to maximum value
w <- w / max(w)

g_bw <- bw_ggplot + 
  facet_wrap(~ cut) +
  llply(unique(diamonds$color), 
        function(i) geom_boxplot(fill = clrs_hcl(7)[i],
                                 width = w[i], outlier.shape = "*",
                                 outlier.size = 3,
                                 data = subset(diamonds, color == i))) +
  theme_bw()

print(g_bw)
```

<figure><img src="../../book_figures/gg facet width bw.png"><figcaption>Figure 3: a ggplot2 panel bw-plot with box widths relative to number of observations and coloured boxes</figcaption></figure>

The result is very very similar to what we have achieved earlier with ```lattice```. In summary, lattice needs a little more care to adjust the standard graphical parameters, whereas ```ggplot2``` requires us to manually calculate the widht of the boxes. I leave it up to you, which way suits you better... I have already made my choice a few years ago ;-)

Boxplots are, as mentioned above, a brilliant way to visualise data distribution(s). Their strength lies in the comparability of different classes as they are plotted next to each other using a common scale. Another, more classical - as parametric - way are histograms (and densityplots).
