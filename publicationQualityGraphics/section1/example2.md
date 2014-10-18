

### 1.2. aggregating our data

Suppose we wanted to calculate the average price of the diamonds for each level of ```cut```, i.e. the average price for all diamonds of "Ideal" quality, for all diamonds of "Premium" quality and so on, this would be done like this


```r
ave_price_cut <- aggregate(diamonds$price, by = list(diamonds$cut), 
                           FUN = mean)
### by = ... needs a list, even if there is only one entry
```

and will look like this


```r
ave_price_cut
```

```
    Group.1    x
1      Fair 4359
2      Good 3929
3 Very Good 3982
4   Premium 4584
5     Ideal 3458
```

Note, that the original column names are not carried over to the newly created table of averaged values. Instead these get the generic names ```Group.1``` and ```x```

The ```Group.1``` already indicates that we are not limited to aggregate just over one factorial variable, more are also possible. Furthermore, any  function to compute the summary statistics which can be applied to all data subsets is allowed, e.g. to compute the number of items per category we could use ```length```


```r
ave_n_cut_color <- aggregate(diamonds$price, 
                             by = list(diamonds$cut,
                                       diamonds$color), 
                             FUN = length)
ave_n_cut_color
```

```
     Group.1 Group.2    x
1       Fair       D  163
2       Good       D  662
3  Very Good       D 1513
4    Premium       D 1603
5      Ideal       D 2834
6       Fair       E  224
7       Good       E  933
8  Very Good       E 2400
9    Premium       E 2337
10     Ideal       E 3903
11      Fair       F  312
12      Good       F  909
13 Very Good       F 2164
14   Premium       F 2331
15     Ideal       F 3826
16      Fair       G  314
17      Good       G  871
18 Very Good       G 2299
19   Premium       G 2924
20     Ideal       G 4884
21      Fair       H  303
22      Good       H  702
23 Very Good       H 1824
24   Premium       H 2360
25     Ideal       H 3115
26      Fair       I  175
27      Good       I  522
28 Very Good       I 1204
29   Premium       I 1428
30     Ideal       I 2093
31      Fair       J  119
32      Good       J  307
33 Very Good       J  678
34   Premium       J  808
35     Ideal       J  896
```

Given that as a result of aggregating this way we loose our variable names, it makes sense to set them afterwards, so that we can easily refer to them later


```r
names(ave_n_cut_color) <- c("cut", "color", "n")
str(ave_n_cut_color)
```

```
'data.frame':	35 obs. of  3 variables:
 $ cut  : Ord.factor w/ 5 levels "Fair"<"Good"<..: 1 2 3 4 5 1 2 3 4 5 ...
 $ color: Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 1 1 1 1 1 2 2 2 2 2 ...
 $ n    : int  163 662 1513 1603 2834 224 933 2400 2337 3903 ...
```

So, I hope you see how useful ```aggregate()``` is for calculating summary statistics of your data.
