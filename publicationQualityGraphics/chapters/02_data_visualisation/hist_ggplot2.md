

### 2.7. Histograms and densityplots (ggplot2 way)

Much like with the box and whicker plot, the default settings of ```ggplot2``` are quite a bit nicer for both histogram and densityplot.


```r
hist_ggplot <- ggplot(diamonds, aes(x = price))

g_his <- hist_ggplot +
  geom_histogram()

print(g_his)
```

```
stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

<figure><img src="../../book_figures/gg hist.png"><figcaption>Figure 1: a basic histogram produced with ggplot2</figcaption></figure>

One thing that is really nice about the ```ggplot2``` densityplots that it is so easy to fill the area under the curve which really helps the visual represeantation of the data.


```r
dens_ggplot <- ggplot(diamonds, aes(x = price))

g_den <- dens_ggplot +
  geom_density(fill = "black", alpha = 0.5)

print(g_den)
```

<figure><img src="../../book_figures/gg dens.png"><figcaption>Figure 2: a basic density plot produced with ggplot2</figcaption></figure>

Just as before, we are encountering again the rather peculiar way of ```ggplot2``` to adjust certain default settings to suit our needs (likes). In we wanted to show percentages instead of counts for the histograms, we again need to use the strange ```..something..``` syntax.

Anothr thing I want to highlight in the following code chunck is the way to achive binary conditioning in ```ggplot2```. This is done as follows:

```
facet_grid(g ~ f)
```

where, again, ```g``` and ```f``` are the two varibles used for the conditioning.


```r
g_his <- hist_ggplot +
  geom_histogram(aes(y = ..ncount..)) +
  scale_y_continuous(labels = percent_format()) +
  facet_grid(color ~ cut) + 
  ylab("Percent")

print(g_his)
```

<figure><img src="../../book_figures/gg facet hist.png"><figcaption>Figure 3: a ggplot2 panel histogram with y-axis labelled according to percentages</figcaption></figure>

Similar to our ```lattice``` approach we're going to rotate the x-axis labels by 45 degrees.


```r
dens.ggplot <- ggplot(diamonds, aes(x = price))

g_den <- dens_ggplot +
  geom_density(fill = "black", alpha = 0.5) +
  facet_grid(color ~ cut) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(g_den)
```

<figure><img src="../../book_figures/gg facet density.png"><figcaption>Figure 4: a ggplot2 panel density plot conditioned according to 2 variables</figcaption></figure>

Ok, antoher thing we might want to show is the value of a certain estimated value (like the mean of our sample) including error bars.
