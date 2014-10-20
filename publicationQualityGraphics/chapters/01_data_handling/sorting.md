

### 1.3. Sorting our data


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

ave_n_cut_color <- aggregate(diamonds$price, 
                             by = list(diamonds$cut,
                                       diamonds$color), 
                             FUN = length)
names(ave_n_cut_color) <- c("cut", "color", "n")
```

Sorting our data according to one (or more) of the variables in our data can also be very handy.   
Sorting of a vector can be achieved using ```sort()```


```r
sort(ave_n_cut_color$n)
```

```
 [1]  119  163  175  224  303  307  312  314  522  662  678  702  808  871
[15]  896  909  933 1204 1428 1513 1603 1824 2093 2164 2299 2331 2337 2360
[29] 2400 2834 2924 3115 3826 3903 4884
```

sorting of an entire dataframe is done using ```order()``` as follows

* for sorting according to one variable


```r
ave_n_cut_color <- ave_n_cut_color[order(ave_n_cut_color$cut), ]
ave_n_cut_color
```

```
         cut color    n
1       Fair     D  163
6       Fair     E  224
11      Fair     F  312
16      Fair     G  314
21      Fair     H  303
26      Fair     I  175
31      Fair     J  119
2       Good     D  662
7       Good     E  933
12      Good     F  909
17      Good     G  871
22      Good     H  702
27      Good     I  522
32      Good     J  307
3  Very Good     D 1513
8  Very Good     E 2400
13 Very Good     F 2164
18 Very Good     G 2299
23 Very Good     H 1824
28 Very Good     I 1204
33 Very Good     J  678
4    Premium     D 1603
9    Premium     E 2337
14   Premium     F 2331
19   Premium     G 2924
24   Premium     H 2360
29   Premium     I 1428
34   Premium     J  808
5      Ideal     D 2834
10     Ideal     E 3903
15     Ideal     F 3826
20     Ideal     G 4884
25     Ideal     H 3115
30     Ideal     I 2093
35     Ideal     J  896
```

* for sorting according to two variables


```r
ave_n_cut_color <- ave_n_cut_color[order(ave_n_cut_color$cut,
                                         ave_n_cut_color$n), ]
ave_n_cut_color
```

```
         cut color    n
31      Fair     J  119
1       Fair     D  163
26      Fair     I  175
6       Fair     E  224
21      Fair     H  303
11      Fair     F  312
16      Fair     G  314
32      Good     J  307
27      Good     I  522
2       Good     D  662
22      Good     H  702
17      Good     G  871
12      Good     F  909
7       Good     E  933
33 Very Good     J  678
28 Very Good     I 1204
3  Very Good     D 1513
23 Very Good     H 1824
13 Very Good     F 2164
18 Very Good     G 2299
8  Very Good     E 2400
34   Premium     J  808
29   Premium     I 1428
4    Premium     D 1603
14   Premium     F 2331
9    Premium     E 2337
24   Premium     H 2360
19   Premium     G 2924
35     Ideal     J  896
30     Ideal     I 2093
5      Ideal     D 2834
25     Ideal     H 3115
15     Ideal     F 3826
10     Ideal     E 3903
20     Ideal     G 4884
```
