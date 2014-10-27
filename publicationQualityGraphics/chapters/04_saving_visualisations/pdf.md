

### 4.3. Protable Document Format


```r
p_lattice <- xyplot(price ~ carat, data = diamonds)
p_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point()
```

`pdf` basically works the same as `postscript`. Both produce vector graphics output. The default settings can be checked with:


```r
pdf.options()
```

```
$width
[1] 7

$height
[1] 7

$onefile
[1] TRUE

$family
[1] "Helvetica"

$title
[1] "R Graphics Output"

$fonts
NULL

$version
[1] "1.4"

$paper
[1] "special"

$encoding
[1] "default"

$bg
[1] "transparent"

$fg
[1] "black"

$pointsize
[1] 12

$pagecentre
[1] TRUE

$colormodel
[1] "srgb"

$useDingbats
[1] TRUE

$useKerning
[1] TRUE

$fillOddEven
[1] FALSE

$compress
[1] TRUE
```

However, there is no equivalent to `setEPS()`. Therefore, we need to provide all device specifications/changes of the default settings directly in the device setup:


```r
pdf("test_la_line.pdf", onefile = TRUE, bg = "white", 
    family = "Times", width = 6.83)

print(xyplot(1:10 ~ 1:10, type = "l", lwd = 96/72 * 2))

invisible(dev.off())
```

