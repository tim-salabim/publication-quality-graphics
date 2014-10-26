

### 4.1. Tagged Image File Format

In all of the following chapters we will first create very basic `lattice` and `ggplot2` plot objects:


```r
p_lattice <- xyplot(price ~ carat, data = diamonds)
p_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point()
```

Ok, so we have our basic plot objects that we want to export as `tiff` images. Note that for graphics of points and lines it is usually preferred to export them using a vector graphics device (`eps` or `pdf`) but for the sake of demonstration, we will not care about this right now and export our scatter plot as `tiff` anyway (`eps` and `pdf` examples follow). In all the examples that follow, we will produce figures that are maximum width (17.35 cm) and maximum height (23.35 cm) accroding to PLOS ONE specifications. Furthermore, we will always first see how this is done with lattice, then with ggplot2.

For `tiff` the default settings are as follows (PLOS ONE requirements in brackets):

* width and heigth: 480 (max 2049 / 2758)
* units: "px" - pixels (n.a.)
* pointsize: 12 (6 - 12)
* compression: "none" (LZW)
* bg (background): "white" (white)
* res (resolution): NA - this basically means 72 ppi (300 - 600 ppi)
* type: system dependent (check with `getOption("bitmapType")`)
* family: system dependent - on Linux X11 it is "Helvetica" (Arial, Times, Symbol)

If we want to use units different from pixels for our width and height specifications, we need to supply a resolution to be used through `res`. 

So, the first thing to do is open the `tiff` device. In order to comply with PLOS ONE we set:

* width to 17.35
* height to 23.35
* res to 300
* compression to "lzw"
* family to "Times"
* we also set `colortype = "true"` to comply with 24-bit RGB color mode


```r
tiff("test_la.tif", width = 17.35, height = 23.35, units = "cm", res = 300,
     compression = "lzw", colortype = "true", family = "Times")
```

then, we render our plot object:


```r
print(p_lattice)
```

and finally we close our device:


```r
invisible(dev.off()) # dev.off() is sufficient. Invisible suppresses text.
```

This will create a `tiff` image of our plot with a text pointsize of 12 for the axis labels, a pointsize of 10 for the axis tick labels and a pointsize of 14 for the plot title (iff supplied). As we have seen, both `lattice` and `ggplot2` ignore any paramter passed to the device via `pointsize`. Therefore, in case we want to change the pointsize of the text in our plot, we need to achieve this in another way. 

In the following setup we will change the default fontsize to 20 pt and the axis tick labels to _italic_.


```r
# tiff("test_la.tif", width = 17.35, height = 23.35, units = "cm", res = 300,
#      compression = "lzw")

tiff_theme <- trellis.par.get()
tiff_theme$fontsize$text <- 20
tiff_theme$axis.text$font <- 3

print(update(p_lattice, par.settings = tiff_theme))
```

<figure><img src="../../book_figures/change pointsize tiff.png"><figcaption></figcaption></figure>

```r
# invisible(dev.off())
```

In order to export the graphic we simply wrap the above between the `tiff(...)` and the `dev.off()` calls (note, here we change the default font family to "Times" - check the exported image):


```r
tiff("test_la.tif", width = 17.35, height = 23.35, units = "cm", res = 300,
     compression = "lzw", colortype = "true", family = "Times")

tiff_theme <- trellis.par.get()
tiff_theme$fontsize$text <- 20
tiff_theme$axis.text$font <- 3

print(update(p_lattice, par.settings = tiff_theme))

invisible(dev.off())
```

This, however, does change the axis label text to a pointsize of `20`, but the axis ticks are labelled with a pointsize of `16`. This is because `lattice` uses so-called `character expansion (short cex)` factors for different regions of the plot. Axis tick labels have `cex = 0.8` and the title has `cex = 1.2`. Therefore, the tick labels will be `fontsize * cex` i.e. `20 * 0.8` in pointsize. We can, howver change this also. 

In the following we will change the axis font size to 10 and the axis tick label fotsize to 17.5:


```r
# tiff("test_la.tif", width = 17.35, height = 23.35, units = "cm", res = 300,
#      compression = "lzw", colortype = "true", family = "Times")

tiff_theme <- trellis.par.get()
tiff_theme$fontsize$text <- 12 # set back to base fontsize 12
expansion_axislabs <- 10/12
expansion_ticks <- 17.5/12
tiff_theme$par.xlab.text$cex <- expansion_axislabs
tiff_theme$par.ylab.text$cex <- expansion_axislabs
tiff_theme$axis.text$cex <- expansion_ticks

print(update(p_lattice, par.settings = tiff_theme))
```

<figure><img src="../../book_figures/change relative pointsize tiff.png"><figcaption></figcaption></figure>

```r
# invisible(dev.off())
```

The same also applies if you use `panel.text()` or `panel.key()`. Use the `cex` parameter to ajust to the font size you want your text to be.

Ok, so much for `lattice`. Let's see how we can change things in `ggplot2`.

The equivalent to the `par.settings = ` in `lattice` are the different `theme_`s in `ggplot2`. We have already seen this in the `ggplot2` queries of the text size in [Chapter 4](../04_saving_visualisations/SAVING.html). However, the way we set the font size is not at all equivalent. We are not allowed to assign a new value to the themes like e.g. `theme_bw()$text$size <- 5`. But ggplot2 provides funtionality to set the font size via `theme_set()` with the parameter `base_size`:


```r
theme_set(theme_bw(base_size = 25))

print(p_ggplot) +
  theme_bw()
```

<figure><img src="../../book_figures/change pointsize gg tiff.png"><figcaption></figcaption></figure>

```
NULL
```

Apart from `theme_set()` which changes the theme globally there is also a function called `theme_update()` which changes parameters for the current theme in use. Once you change to a different theme, these settings will be neglected. 

**Note, we need to supply the absolute pointsizes to these functions, not the relative expansion factors!**


```r
theme_set(theme_bw(base_size = 10))
theme_update(axis.text = element_text(size = 17.5, face = "italic",
                                      family = "Times"))

print(p_ggplot)
```

<figure><img src="../../book_figures/change themes gg tiff1.png"><figcaption></figcaption></figure>

```r
print(p_ggplot + theme_grey())
```

<figure><img src="../../book_figures/change themes gg tiff2.png"><figcaption></figcaption></figure>

The exporting will then be equivalent to before:


```r
tiff("test_gg.tif", width = 17.35, height = 23.35, units = "cm", res = 300,
     compression = "lzw", colortype = "true", family = "Times")
theme_set(theme_bw(base_size = 10))
theme_update(axis.text = element_text(size = 17.5, face = "italic"))

print(p_ggplot)
invisible(dev.off())
```

Right, so now we know how to modify the standard settings shipped with both `lattice` and `ggplot2`. This will be pretty much the same for the other devices...
