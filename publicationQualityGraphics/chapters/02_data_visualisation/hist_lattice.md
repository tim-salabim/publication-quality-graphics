

### 2.6. Histograms and densityplots (lattice way)

The classic way to visualise the distrbution of any data are histograms. They are closely related to density plots, where the individual data points are not binned into certain classes but a ontinuous density function is calculated to show the distribution. Both approaches reflect a certain level of abstraction (binning vs. functional representation), therefore a general formulation of which of them is more accepted is hard. In any case, the both achieve exactly the same result, they will show us the distribution of our data.

As is to be expected with ```lattice```, the default plotting routine does not really satisfy the (or maybe better my) aesthetic expectations.


```r
hist_lattice <- histogram(~ price, data = diamonds)
hist_lattice
```

<figure><img src="../../book_figures/altt hist.png"><figcaption>Figure 1: a basic histogram produced with lattice</figcaption></figure>

This is even worse for the default density plot...


```r
dens_lattice <- densityplot(~ price, data = diamonds)
dens_lattice
```

<figure><img src="../../book_figures/latt dens.png"><figcaption>Figure 2: a basic density plot produced with lattice</figcaption></figure>

Yet, as we've already adjusted our global graphical parameter settings, we can now easily modify this.


```r
hist_lattice <- histogram(~ price | color, 
                          data = diamonds,
                          as.table = TRUE,
                          par.settings = my_theme)

l_his <- hist_lattice

print(l_his)
```

<figure><img src="../../book_figures/latt panel hist.png"><figcaption>Figure 3: a panel histogram with modofied graphical parameter settings</figcaption></figure>

Now, this is a plot that every journal editor will very likely accept.

Until now, we have seen how to condition our plots according to one factorial variable (```diamonds$cut```). It is, in theory, possible to condition plots on any number of factorial variable, though more than two is seldom advisable. Two, however, is definitely acceptable and still easy enough to perceive and interpret. In ```lattice``` this is generally done as follows.

```
y ~ x | g + f
```

where ```g``` and ```f``` are the factorial variables used for the conditioning.

In the below code chunck we are first creating out plot object and the we are using a funtion called ```useOuterStrips()``` which makes sure that the strips that correspond to the conditioning variables are plotted on both the top and the left side of our plot. The default ```lattice``` setting is to plot both at the top, which makes the navigation through the plot by the viewer a little more difficult.

Another default setting for densityplots in ```lattice``` is to plot a point (circle) for each observation of our variable (price) at the bottom of the plot along the x--axis. In our case, as we have a lot of data points, this is not desirable, so we set the argument ```plot.points``` to ```FALSE```.


```r
dens_lattice <- densityplot(~ price | cut + color, 
                            data = diamonds,
                            as.table = TRUE,
                            par.settings = my_theme,
                            plot.points = FALSE,
                            between = list(x = 0.2, y = 0.2),
                            scales = list(x = list(rot = 45)))

l_den <- useOuterStrips(dens_lattice)

print(l_den)
```

<figure><img src="../../book_figures/latt panel dens.png"><figcaption>Figure 4: a panel density plot conditioned according to 2 variables using lattice</figcaption></figure>

You may have noticed that the lines of the densityplot are plotted in a light shade of blue (cornflowerblue to be precise). I it up to you to change this yourself...

Another thing you may notice when looking at the above plot is that the x-axis labels are rotated by 45 degrees. This one I also leave up to you to figure out... ;-)
