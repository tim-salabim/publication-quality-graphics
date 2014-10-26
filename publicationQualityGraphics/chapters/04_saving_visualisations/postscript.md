

### 4.3. Encapsulated Postscript


```r
p_lattice <- xyplot(price ~ carat, data = diamonds)
p_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point()
```

As mentioned earlier, the proper way of saving vector based graphics (such as line graphs, point graphs or basically anything with nott too many graphical features, e.g. polygons) is using a vector graphics based device. Here, we will consider `(encapsulated) postscript - .eps` and `portable document format - .pdf`.

For R's `postscript` device the important default settings are as follows (PLOS ONE requirements in brackets):

* width and heigth: 0 inches (max 6.83 / 9.19)
* pointsize: 12 (6 - 12)
* bg (background): "transparent" (white)
* family: "Helvetica" (Arial, Times, Symbol)
* onefile: TRUE (n.a. - yet likely only one file is acceptable)
* horizontal: TRUE (accepting both)
* paper: "default" check via `getOption("papersize")` (n.a.)
* colormodel: "srgb" (RGB - so sRGB should be fine)

The full set of details can be retrieved using:


```r
ps.options()
```

```
$onefile
[1] FALSE

$family
[1] "Times"

$title
[1] "R Graphics Output"

$fonts
NULL

$encoding
[1] "default"

$bg
[1] "white"

$fg
[1] "black"

$width
[1] 6.83

$height
[1] 7

$horizontal
[1] FALSE

$pointsize
[1] 12

$paper
[1] "special"

$pagecentre
[1] TRUE

$print.it
[1] FALSE

$command
[1] "default"

$colormodel
[1] "srgb"

$useKerning
[1] TRUE

$fillOddEven
[1] FALSE
```

. Changing these is basically the way to handle device setup when printing to `eps`. These default settings can be changed using `setEPS()`. And here is where it gets a little awkward. If you run `setEPS()` wothout any arguments, the defaults listed above will change slightly


```r
setEPS()
ps.options()
```

```
$onefile
[1] FALSE

$family
[1] "Times"

$title
[1] "R Graphics Output"

$fonts
NULL

$encoding
[1] "default"

$bg
[1] "white"

$fg
[1] "black"

$width
[1] 7

$height
[1] 7

$horizontal
[1] FALSE

$pointsize
[1] 12

$paper
[1] "special"

$pagecentre
[1] TRUE

$print.it
[1] FALSE

$command
[1] "default"

$colormodel
[1] "srgb"

$useKerning
[1] TRUE

$fillOddEven
[1] FALSE
```

Notably, `onefile` is now `FALSE` as is `horizontal`, `paper` is now `special` and `height` and `width` are now 7. Apart from the `onefile` I think this is fine. Especially when utilising layered plotting approaches like we do here (i.e. `lattice` and `ggplot2`), `onefile` should be set to `TRUE` as otherwise we may well end up with `.eps` files with many pages. However, `setEPS()` will not let us change this. Therefore, we will need to set this for each device.

Hence, in order to coply to PLOS ONE we need:


```r
setEPS(bg = "white", family = "Times", width = 6.83)
postscript("test_la.eps", onefile = TRUE)

print(p_lattice)

invisible(dev.off())
```

All the tweaking of the plot layout applies here just the same (e.g. adjusting the axis tick labelling font sizes etc.). 

For vector graphics resolution is irrelevant as the elements are actual lines or points and not pixels. Therefore, we need to start thinking about lines and points now. And here things are again a little "special" in R. TZhe base size for points is 1/72 inch (standard) but for lines it is 1/96 inch. This means that when we specify a line width of 1 via `lwd = 1` we are really getting a line width of 0.75 as `72/96 = 0.75`. In light of the PLOS ONE requirements for lines to be at least 0.5 pt this will mean that when we set `lwd = 0.5` we are actually producing a line that is too thin (0.375 pt). On the other hand, setting `lwd = 2` means that we still adhere to the guidelines as the result will only be 1.5 pt in width. 

If, however, we want to address this issue we could do something like this (using a simple line plot as an example):


```r
setEPS(bg = "white", family = "Times", width = 6.83)
postscript("test_la_line.eps", onefile = TRUE)

print(xyplot(1:10 ~ 1:10, type = "l", lwd = 96/72 * 2))

invisible(dev.off())
```

As a final tweak, we will see how to change the white space around a plot in `lattice`:


```r
# setEPS(bg = "white", family = "Times", width = 6.83)
# postscript("test_la_line.eps", onefile = TRUE)

mar_theme <- lattice.options()
mar_theme$layout.widths$left.padding$x <- 2
mar_theme$layout.widths$left.padding$units <- "points"
mar_theme$layout.widths$right.padding$x <- 2
mar_theme$layout.widths$right.padding$units <- "points"
mar_theme$layout.heights$top.padding$x <- 2
mar_theme$layout.heights$top.padding$units <- "points"
mar_theme$layout.heights$bottom.padding$x <- 2
mar_theme$layout.heights$bottom.padding$units <- "points"

print(xyplot(1:10 ~ 1:10, type = "l", lwd = 96/72 * 2, 
             lattice.options = mar_theme))
```

<figure><img src="../../book_figures/seteps whitespace.png"><figcaption></figcaption></figure>

```r
# invisible(dev.off())
```

This will, however, only really provide a 2 pt white space on the left side of the plot. I found some indications as to some bugs in setting these layout parameters, so whether this is intended or not remains unclear for now. I will keep digging and update this tutorial as soon as I find a proper solution.

