

### 1.4. merging our data


```r
### here's a rather handy way of loading all packages that you need
### for your code to work in one go
libs <- c('ggplot2', 'latticeExtra', 'gridExtra', 'MASS', 
          'colorspace', 'plyr', 'Hmisc', 'scales')
lapply(libs, require, character.only = T)
```


```r
### load the diamonds data set (comes with ggplot2)
data(diamonds)

ave_price_cut <- aggregate(diamonds$price, by = list(diamonds$cut), 
                           FUN = mean)
ave_n_cut_color <- aggregate(diamonds$price, 
                             by = list(diamonds$cut,
                                       diamonds$color), 
                             FUN = length)
names(ave_n_cut_color) <- c("cut", "color", "n")
```

Often enough we end up with multiple data sets on our hard drive that contain useful data for the same analysis. In this case we might want to amalgamate our data sets so that we have all the data in one set.   
R provides a function called ```merge()``` that does just that


```r
ave_n_cut_color_price <- merge(ave_n_cut_color, ave_price_cut, 
                               by.x = "cut", by.y = "Group.1")
ave_n_cut_color_price
```

```
         cut color    n    x
1       Fair     D  163 4359
2       Fair     E  224 4359
3       Fair     F  312 4359
4       Fair     G  314 4359
5       Fair     H  303 4359
6       Fair     I  175 4359
7       Fair     J  119 4359
8       Good     F  909 3929
9       Good     G  871 3929
10      Good     D  662 3929
11      Good     E  933 3929
12      Good     J  307 3929
13      Good     H  702 3929
14      Good     I  522 3929
15     Ideal     D 2834 3458
16     Ideal     E 3903 3458
17     Ideal     F 3826 3458
18     Ideal     G 4884 3458
19     Ideal     H 3115 3458
20     Ideal     I 2093 3458
21     Ideal     J  896 3458
22   Premium     E 2337 4584
23   Premium     F 2331 4584
24   Premium     D 1603 4584
25   Premium     I 1428 4584
26   Premium     J  808 4584
27   Premium     G 2924 4584
28   Premium     H 2360 4584
29 Very Good     F 2164 3982
30 Very Good     E 2400 3982
31 Very Good     J  678 3982
32 Very Good     G 2299 3982
33 Very Good     D 1513 3982
34 Very Good     I 1204 3982
35 Very Good     H 1824 3982
```

As the variable names of our two data sets differ, we need to specifically provide the names for each by which the merging should be done (```by.x``` & ```by.y```). The default of ```merge()``` tries to find variable names which are identical.

Note, in order to merge more that two data frames at a time, we need to call a powerful higher order function called ```Reduce()```. This is one mighty function for doing all sorts of things iteratively.


```r
names(ave_price_cut) <- c("cut", "price")

set.seed(12)

df3 <- data.frame(cut = ave_price_cut$cut,
                  var1 = rnorm(nrow(ave_price_cut), 10, 2),
                  var2 = rnorm(nrow(ave_price_cut), 100, 20))

ave_n_cut_color_price <- Reduce(function(...) merge(..., all=T), 
                                list(ave_n_cut_color, 
                                     ave_price_cut,
                                     df3))
ave_n_cut_color_price
```

```
         cut color    n price   var1   var2
1       Fair     D  163  4359  7.039  94.55
2       Fair     E  224  4359  7.039  94.55
3       Fair     F  312  4359  7.039  94.55
4       Fair     G  314  4359  7.039  94.55
5       Fair     H  303  4359  7.039  94.55
6       Fair     I  175  4359  7.039  94.55
7       Fair     J  119  4359  7.039  94.55
8       Good     F  909  3929 13.154  93.69
9       Good     G  871  3929 13.154  93.69
10      Good     D  662  3929 13.154  93.69
11      Good     E  933  3929 13.154  93.69
12      Good     J  307  3929 13.154  93.69
13      Good     H  702  3929 13.154  93.69
14      Good     I  522  3929 13.154  93.69
15     Ideal     D 2834  3458  6.005 108.56
16     Ideal     E 3903  3458  6.005 108.56
17     Ideal     F 3826  3458  6.005 108.56
18     Ideal     G 4884  3458  6.005 108.56
19     Ideal     H 3115  3458  6.005 108.56
20     Ideal     I 2093  3458  6.005 108.56
21     Ideal     J  896  3458  6.005 108.56
22   Premium     E 2337  4584  8.160  97.87
23   Premium     F 2331  4584  8.160  97.87
24   Premium     D 1603  4584  8.160  97.87
25   Premium     I 1428  4584  8.160  97.87
26   Premium     J  808  4584  8.160  97.87
27   Premium     G 2924  4584  8.160  97.87
28   Premium     H 2360  4584  8.160  97.87
29 Very Good     F 2164  3982  8.087  87.43
30 Very Good     E 2400  3982  8.087  87.43
31 Very Good     J  678  3982  8.087  87.43
32 Very Good     G 2299  3982  8.087  87.43
33 Very Good     D 1513  3982  8.087  87.43
34 Very Good     I 1204  3982  8.087  87.43
35 Very Good     H 1824  3982  8.087  87.43
```

Obviously, setting proper names would be the next step now...

Ok, so now we have a few tools at hand to manipulate our data in a way that we should be able to produce some meaningful graphs which tell the story that we want to be heard, or better, seen...

So, let's start plotting stuff
