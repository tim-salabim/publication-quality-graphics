

### 2.4. Box an whisker plots (lattice way)

I honestly don't have a lot to say about box and whisker plots. They are probably the most useful plots for showing the nature/distribution of your data and allow for some easy comparisons between different levels of a factor for example.

see http://upload.wikimedia.org/wikipedia/commons/1/1a/Boxplot_vs_PDF.svg for a visual representation of the standard R settings of BW plots in relation to mean and standard deviation of a normal distribution.

So without further ado, here's a basic lattice box and whisker plot.


```r
bw_lattice <- bwplot(price ~ color, data = diamonds)

bw_lattice
```

<figure><img src="../../book_figures/latt bw1.png"><figcaption>Figure 1: a basic box-whisker-plot produced with lattice</figcaption></figure>

Not so very beautiful... So, let's again modify the standard ```par.settings``` so that we get an acceptable box and whisker plot.


```r
bw_theme <- trellis.par.get()
bw_theme$box.dot$pch <- "|"
bw_theme$box.rectangle$col <- "black"
bw_theme$box.rectangle$lwd <- 2
bw_theme$box.rectangle$fill <- "grey90"
bw_theme$box.umbrella$lty <- 1
bw_theme$box.umbrella$col <- "black"
bw_theme$plot.symbol$col <- "grey40"
bw_theme$plot.symbol$pch <- "*"
bw_theme$plot.symbol$cex <- 2
bw_theme$strip.background$col <- "grey80"

l_bw <- update(bw_lattice, par.settings = bw_theme)

print(l_bw)
```

<figure><img src="../../book_figures/latt bw2.png"><figcaption>Figure 2: lattice bw-plot with modified graphical parameter settings</figcaption></figure>

Much better, isn't it?


```r
bw_lattice <- bwplot(price ~ color | cut, data = diamonds,
                     asp = 1, as.table = TRUE, varwidth = TRUE)
l_bw <- update(bw_lattice, par.settings = bw_theme, xlab = "color", 
               fill = clrs_hcl(7),
               xscale.components = xscale.components.subticks,
               yscale.components = yscale.components.subticks)

print(l_bw)
```

<figure><img src="../../book_figures/latt panel bw.png"><figcaption>Figure 3: a lattice panel bw-plot with box widths relative to number of observations and coloured boxes</figcaption></figure>

In addition to the rather obvious provision of a color palette to to fill the boxes, in this final box & whisker plot we have also told ```lattice``` to adjust the widths of the boxes so that they reflect the relative sizes of the data samples for each of the factors (colours). This is a rather handy way of providing insight into the data distribution along the factor of the x-axis. We can show this withiout having to provide any additional plot to highlight that some of the factor levels (i.e. colours) are much less represented than others ('J' compared to 'G', for example, especially for the 'Ideal' quality class). 
