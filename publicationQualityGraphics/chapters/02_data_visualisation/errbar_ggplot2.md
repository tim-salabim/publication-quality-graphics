

### 2.8. Plotting error bars (ggplot2 way)

As mentioned above, when plotting error bars ```ggplot2``` is much easier. Whether this is because of the genereal ongoing discussion about the usefulness of these plots I do not want to judge.

Anyway, plotting error bars in ```gglplot2``` is as easy as everything else...


```r
errbar_ggplot <- ggplot(cuts, aes(cut, fit, ymin = fit - se.fit, 
                                  ymax=fit + se.fit))
g_err <- errbar_ggplot + 
  geom_pointrange() +
  coord_flip() +
  theme_classic()

print(g_err)
```

<figure><img src="../../book_figures/gg err.png"><figcaption>Figure 1: a basic dotplot with error bars produced with ggplot2</figcaption></figure>

Especially, when plotting them as part of a bar plot.


```r
g_err <- errbar_ggplot + 
  geom_bar(fill = "grey80") +
  geom_errorbar(width = 0.2) +
  coord_flip() +
  theme_classic()

print(g_err)
```

<figure><img src="../../book_figures/gg err bar.png"><figcaption>Figure 2: a ggplot2 bar plot with error bars</figcaption></figure>

Just as before (with the box wdths) though, applying this to each panel is a little more complicated...


```r
errbar_ggplot_facets <- ggplot(diamonds, aes(x = color, y = price))

### function to calculate the standard error of the mean
se <- function(x) sd(x)/sqrt(length(x))

### function to be applied to each panel/facet
myFun <- function(x) {
  data.frame(ymin = mean(x) - se(x), 
             ymax = mean(x) + se(x), 
             y = mean(x))
  }

g_err_f <- errbar_ggplot_facets + 
  stat_summary(fun.y = mean, geom = "bar", 
               fill = clrs_hcl(7)) + 
  stat_summary(fun.data = myFun, geom = "linerange") + 
  facet_wrap(~ cut) +
  theme_bw()

print(g_err_f)
```

<figure><img src="../../book_figures/gg facet err bar.png"><figcaption>Figure 3: a ggplot2 panel bar plot with error bars and modified fill colours</figcaption></figure>

Still, trust me on this, much much easier than to achieve the same result in ```lattice```.
