

### 2.1. A few notes on using colour

Before we start plotting our data, we need to spend some time to have a closer look at colour representation of certain variables. A careful study of colour-spaces (e.g., [here](http://statmath.wu.ac.at/~zeileis/papers/Zeileis+Hornik+Murrell-2009.pdf), [here](http://hclwizard.org/hcl-color-scheme/), [here](http://vis4.net/blog/posts/avoid-equidistant-hsv-colors/) or [here](https://en.wikipedia.org/wiki/HSL_and_HSV)) leads to the conclusion that the ```hcl``` colour space is preferable when mapping a variable to colour (be it factorial or continuous).

This colour space is readily available in R through the package ```colorspace``` and the function of interest is called ```hcl()```.

In the code chunk that follows we will create a colour palette that varies in both colour (hue) and also luminance (brightness) so that this can be distinguished even in grey-scale (printed) versions of the plot. As a reference colour palette we will use the 'Spectral' palette from clorobrewer.org which is also a multi-hue palette but represents a diverging colour palette. Hence, each end of the palette will look rather similar when converted to grey-scale. 


```r
clrs_spec <- colorRampPalette(rev(brewer.pal(11, "Spectral")))
clrs_hcl <- function(n) {
  hcl(h = seq(230, 0, length.out = n), 
      c = 60, l = seq(10, 90, length.out = n), 
      fixup = TRUE)
  }

### function to plot a colour palette
pal <- function(col, border = "transparent", ...)
{
 n <- length(col)
 plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
      axes = FALSE, xlab = "", ylab = "", ...)
 rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
}
```

So here's the Spectral palette from colorbrewer.org interpolated over 100 colours


```r
pal(clrs_spec(100))
```

<figure><img src="../../book_figures/spectr pal.png"><figcaption>Figure 1: a diverging rainbow colour palette from colorbrewer</figcaption></figure>

And this is what it looks like in grey-scale


```r
pal(desaturate(clrs_spec(100)))
```

<figure><img src="../../book_figures/spectr pal grey.png"><figcaption>Figure 2: same palette as above in grey-scale</figcaption></figure>

We see that this palette varies in lightness from a very bright centre to darker ends on each side. Note, that the red end is slightly darker than the blue end

This is quite ok in case we want to show some diverging data (deviations from a zero point - e.g. the mean). If we, however, are dealing with a sequential measure, such as temperature, or in our case the density of points plotted per some grid cell, we really need to use a sequential colour palette. There are two common problems with sequential palettes:

1. we need to create a palette that maps the data accurately. This means that the perceived distances between the different hues utilised needs to reflect the distances between our data points. AND this distance needs to be constant, no matter between which two point of the palette we want to estimate their distance. Let me give you an example. Consider the classic 'rainbow' palette (Matlab refers to this as 'jet colors')


```r
pal(rainbow(100))
```

<figure><img src="../../book_figures/rainb pal.png"><figcaption>Figure 3: the classic rainbow colour palette</figcaption></figure>

It becomes obvious that there are several thin bands in this colour palette (yellow, aquamarine, purple) which do not map the distances between variable values accurately. That is, the distance between two values located in/around the yellow region of the palette will seem to change faster than, for example somewhere in the green region (and red and blue).

When converted to grey-scale this palette produces a hell of a mess...


```r
pal(desaturate(rainbow(100)))
```

<figure><img src="../../book_figures/rainb pal grey.png"><figcaption>Figure 4: same palette as above in grey-scale</figcaption></figure>

Note, that this palette is maybe the most widely used colour coding palette for mapping a sequential continuous variable to colour. We will see further examples later on...

I hope you get the idea that this is not a good way of mapping a sequential variable to colour!

```hcl()``` produces so-called perceptually uniform colour palettes and is therefore much better suited to represent sequential data.


```r
pal(clrs_hcl(100))
```

<figure><img src="../../book_figures/hcl pal.png"><figcaption>Figure 5: an hcl based multi-hue colour palette with increasing luminence towards the red end</figcaption></figure>

We see that the different hues are spread constantly over the palette and therefore it is easy to estimate distances between data values from the changes in colour.   
The fact that we also vary luminance here means that we get a very light colour at one end (here the red end - which is a more of a pink tone than red). This might, at first sight, not seem very aesthetically pleasing, yet it enables us to encode our data even in grey-scale...


```r
pal(desaturate(clrs_hcl(100)))
```

<figure><img src="../../book_figures/hcl pal grey.png"><figcaption>Figure 6: same palette as above in grey-scale</figcaption></figure>

As a general suggestion I encourage you to make use of the hcl colour space whenever you can. But most importantly, it is essential to do some thinking before mapping data to colour. The most basic question you always need to ask yourself is **what is the nature of the data that I want to show? - sequential, diverging or qualitative?** Once you know this, it is easy to choose the appropriate colour palette for the mapping. A good place to start for choosing perceptually well thought through palettes is [the colorbrewer website](http://www.colorbrewer2.org).

Ok, so now let's start with the classic statistical plot, the scatterplot...
