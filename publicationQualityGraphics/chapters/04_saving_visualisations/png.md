

### 4.2. Portable Network Graphics


```r
p_lattice <- xyplot(price ~ carat, data = diamonds)
p_ggplot <- ggplot(aes(x = carat, y = price), data = diamonds) +
  geom_point()
```

For `.png` files things are very similar to `.tiff` except that we don't need to specify a compression:


```r
png("test_gg.png", width = 17.35, height = 23.35, units = "cm", res = 300,
    colortype = "true", family = "Times")
theme_set(theme_bw(base_size = 10))
theme_update(axis.text = element_text(size = 17.5, face = "italic"))

print(p_ggplot)
invisible(dev.off())
```

