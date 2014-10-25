

In all of the following chapters we will first create very basic `lattice` and `ggplot2` plot objects:


```r
p_lattice <- xyplot(price ~ carat, data = diamonds)
p_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point() + 
  theme_bw()
```

Ok, so we have our basic plot objects that we want to export as `tiff` images. Note that for graphics of points and lines it is usually preferred to export them using a vector graphics device (`eps` or `pdf`) but for the sake of demonstration, we will not care about this right now and export our scatter plot as `tiff` anyway (`eps` and `pdf` examples follow). In all the examples that follow, we will produce figures that are maximum width (17.35 cm) and maximum height (23.35 cm) accroding to PLOS ONE specifications. Furthermore, we will always first see how this is done with lattice, then with ggplot2.

So, the first thing to do is open the `tiff` device:


```r
tiff("test.tif", width = 17.35, height = 23.35, units = "cm")
```

then, we render our plot object:


```r
print(p_lattice)
```

and finally we close our device:


```r
invisible(dev.off()) # dev.off() is sufficient. Invisible suppresses text.
```
