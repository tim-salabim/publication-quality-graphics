

### 1.1. sub-setting our data

As a final introductory note I would like to draw your attention to the fact that for the sake of reproducibility, this workshop will make use of the diamonds data set (which comes with ggplot2) in all the provided examples


```r
### here's a rather handy way of loading all packages that you need
### for your code to work in one go
libs <- c('ggplot2', 'latticeExtra', 'gridExtra', 'MASS', 
          'colorspace', 'plyr', 'Hmisc', 'scales')
lapply(libs, require, character.only = T)

### load the diamonds data set (comes with ggplot2)
data(diamonds)
```

The diamonds data set is structured as follows


```r
str(diamonds)
```

```
'data.frame':	53940 obs. of  10 variables:
 $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
 $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
 $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
 $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
 $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
 $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
 $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```

The ```str()``` command is probably the most useful command in all of R. It shows the complete structure of our data set and provides a 'road map' of how to access certain parts of the data.   

For example
```
diamonds$carat
```
is a numerical vector of length 53940

and

```
diamonds$cut
```

is an ordered factor with the ordered levels Fair, Good, Very Good, Premium, Ideal

Suppose we're a stingy person and don't want to spend too much money on the wedding ring for our loved one, we could create a data set only including diamonds that cost less than 1000 US$ (though 1000 US$ does still seem very generous to me).


```r
diamonds_cheap <- subset(diamonds, price < 1000)
```

Then our new data set would look like this


```r
str(diamonds_cheap)
```

```
'data.frame':	14499 obs. of  10 variables:
 $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
 $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
 $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
 $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
 $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
 $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
 $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```

Now the new ```diamonds_cheap``` subset is a reduced data set of the original ```diamonds``` data set only having 14499 entries instead of the original 53940 entries.

In case we were interested in a subset only including all diamonds of quality (cut) 'Premium' the command would be


```r
diamonds_premium <- subset(diamonds, cut == "Premium")
str(diamonds_premium)
```

```
'data.frame':	13791 obs. of  10 variables:
 $ carat  : num  0.21 0.29 0.22 0.2 0.32 0.24 0.29 0.22 0.22 0.3 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 4 4 4 4 4 4 4 4 4 4 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 6 3 2 2 6 3 2 1 7 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 3 4 3 2 1 5 3 4 4 2 ...
 $ depth  : num  59.8 62.4 60.4 60.2 60.9 62.5 62.4 61.6 59.3 59.3 ...
 $ table  : num  61 58 61 62 58 57 58 58 62 61 ...
 $ price  : int  326 334 342 345 345 355 403 404 404 405 ...
 $ x      : num  3.89 4.2 3.88 3.79 4.38 3.97 4.24 3.93 3.91 4.43 ...
 $ y      : num  3.84 4.23 3.84 3.75 4.42 3.94 4.26 3.89 3.88 4.38 ...
 $ z      : num  2.31 2.63 2.33 2.27 2.68 2.47 2.65 2.41 2.31 2.61 ...
```

Note the **two** equal signs in order to specify our selection (this stems from an effort to be consistent with selection criteria such as *smaller than* ```<=``` or *not equal* ```!=``` and basically translates to *is equal*)!!

Any combinations of these subset commands are valid, e.g.


```r
diamonds_premium_and_cheap <- subset(diamonds, cut == "Premium" & 
                                   price <= 1000)
```

produces a rather strict subset only allowing diamonds of premium quality that cost less than 1000 US$

In case we want **ANY** of these, meaning all diamonds of premium quality **OR** cheaper than 1000 US$, we would use the **|** operator to combine the two specifications


```r
diamonds_premium_or_cheap <- subset(diamonds, cut == "Premium" | 
                                   price <= 1000)
```

The **OR** specification is much less rigid than the **AND** specification which will result in a larger data set:

* `diamonds_premium_and_cheap` has 3204 rows, while
* `diamonds_premium_or_cheap` has 25111 rows


```r
str(diamonds_premium_and_cheap)
```

```
'data.frame':	3204 obs. of  10 variables:
 $ carat  : num  0.21 0.29 0.22 0.2 0.32 0.24 0.29 0.22 0.22 0.3 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 4 4 4 4 4 4 4 4 4 4 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 6 3 2 2 6 3 2 1 7 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 3 4 3 2 1 5 3 4 4 2 ...
 $ depth  : num  59.8 62.4 60.4 60.2 60.9 62.5 62.4 61.6 59.3 59.3 ...
 $ table  : num  61 58 61 62 58 57 58 58 62 61 ...
 $ price  : int  326 334 342 345 345 355 403 404 404 405 ...
 $ x      : num  3.89 4.2 3.88 3.79 4.38 3.97 4.24 3.93 3.91 4.43 ...
 $ y      : num  3.84 4.23 3.84 3.75 4.42 3.94 4.26 3.89 3.88 4.38 ...
 $ z      : num  2.31 2.63 2.33 2.27 2.68 2.47 2.65 2.41 2.31 2.61 ...
```

```r
str(diamonds_premium_or_cheap)
```

```
'data.frame':	25111 obs. of  10 variables:
 $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
 $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
 $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
 $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
 $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
 $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
 $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```

There is, in principle, no limitation to the combination of these so-called Boolean operators (and, or, equal to, not equal to, greater than, less than). I guess you get the idea...
