

### 2.7. Plotting error bars (lattice way)

Honestly, ```lattice``` sucks at plotting error bars... Therefore, we will only explore one way of achieving this. In case you really want to explore this further, I refer you to Stackoverflow and other R related forums/lists, wehere you will find a solution, but I doubt that you will like it... Error bars are much easier plotted using ```ggplot2```.


```r
my_theme$dot.symbol$col <- "black"
my_theme$dot.symbol$cex <- 1.5
my_theme$plot.line$col <- "black"
my_theme$plot.line$lwd <- 1.5

dmod <- lm(price ~ cut, data = diamonds)
cuts <- data.frame(cut = unique(diamonds$cut), 
                   predict(dmod, data.frame(cut = unique(diamonds$cut)), 
                           se = TRUE)[c("fit", "se.fit")])

errbar_lattice <- Hmisc::Dotplot(cut ~ Cbind(fit, 
                                             fit + se.fit, 
                                             fit - se.fit),
                                 data = cuts, 
                                 par.settings = my_theme)

l_err <- errbar_lattice

print(l_err)
```

<figure><img src="../../book_figures/latt err.png"><figcaption>Figure 1: a basic dotplot with error bars produced with lattice</figcaption></figure>
