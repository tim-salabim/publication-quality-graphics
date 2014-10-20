

## 3. Manipulating plots with the grid package

Ok, so now we have seen how to produce a variety of widely used plot types using both ```lattice``` and ```ggplot2```. I hope that, apart from the specifics, you also obtained a general idea of how these two packages work and how you may use the various things we've touched upon here in scenarios other than the ones provided here.

Now, we're moving on to a more basic and much more flexible level of modifying, constructing and arranging graphs. Both, ```lattice``` and ```ggplot2``` are based upon the ```grid``` package. This means that we can use this package to fundamentally modify whatever we've produced (remember, we're always storing our plots in objects) in a much more flexible way that provided by any pf these packages.

With his ```grid``` package, Paul Murrell has achieved nothing less than a, in my opinion, much more flexible and powerful plotting framework for R. As a side note, this has already been 'officially' recognised as he is now member of the core team (at least I think so) and his ```grid``` package is now shipped with the base version of R. This means that we don't have to install the package anymore (however, we still have to load it via ```library(grid)```.

In order to fully appreciate the possibilities of the ```grid``` package, it helps to think of this package as a package for **drawing** things. Yes, we're not producing statistical plots as such (for this we have ```lattice``` and ```ggplot2```), we're actually *drawing** things!

The fundamental features of the ```grid``` package are the ```viewports```. By default, the whole plotting area, may it be the standard R plotting device or the png plotting device, is considered as the root viewport (basically like the ```home/<username>``` folder on your linux system or the ```Users\<username>``` folder in windows). In this viewport we now have the possibility to specify other viewports which are relative to the root viewport (just like the ```Users<username>\Documents``` folder in windows or - to provide a different example - the ```home/<username>/Downloads``` folder in linux). 

The very very important thing to realise here is that in order to do anything in this folder (be it creating another sub-folder or simply saving a file or whatever), we need to first **create** the folder and then we also need to **navigate/change/go** into the folder. If you keep this in mind, you will quickly understand the fundamental principle of ```grid```.

When we start using the ```grid``` package, we always start with the 'root' viewport. This is already available, it is created for us, we don't need to do anything. This is our starting point. The really neat thing about ```grid``` is that each viewport is, by default, defined as both x and y ranging from 0 - 1. In the lower left corner x = 0 and y = 0. The lower right corner is x = 1 & y = 0, the upper right corner x = 1 & y = 1 and so on... It is, however, possible to specify a myriad of different unit systems (type, with the ```grid``` package loaded, ```?unit``` to get an overview of what is available). I usually stick to these default settings called ```npc - natural parent coordinates``` which range from 0 - 1 in each direction, as this makes setting up viewports very intuitive.

A viewport needs some basic specifications for it to be located somewhere in the plotting area (the current viewport). These are:

* x - the location along the x-axis
* y - the location along the y -axis
* width - the width of the viewport
* height - the height of the viewport
* just - the justification of the viewport in both x and y directions

`width` and `height` should be rather self-explanatory.   
`x`, `y` and `just` are a bit more mind-bending. As default, `x` and `y` are 0.5 and `just` is `c(centre, centre)`. This means that the new viewport will be positioned at `x = 0.5` and `y = 0.5`. As the default of `just` is `centre` this means that a new viewport will be created at the midpoint of the current viewport (0.5 & 0.5) and it will be centered on this point. It helps to think of the `just` specification in the same way that you provide your text justification in Word (left, right, centre & justified). Let us try a first example which should highlight the way this works




```r
grid.newpage()
```


```r
grid.rect()
grid.text("this is the root vp", x = 0.5, y = 1, 
          just = c("centre", "top"))

our_first_vp <- viewport(x = 0.5, y = 0.5, 
                         height = 0.5, width = 0.5,
                         just = c("centre", "centre"))

pushViewport(our_first_vp)

grid.rect(gp = gpar(fill = "pink"))
grid.text("this is our first vp", x = 0.5, y = 1, 
          just = c("centre", "top"))
```

<figure><img src="../../book_figures/grid first vp.png"><figcaption>Figure 1: producing a standard viewport using grid</figcaption></figure>

Ok, so now we have created a viewport in the middle of the `root` viewport at `x = 0.5` and `y = 0.5` - `just = c("centre", "centre")` that is half the height and half the width of the original viewport - `height = 0.5` and `width = 0.5`.

Afterwards we navigated into this viewport - `pushViewport(our_first_vp)` and then we have drawn a rectangle that fills the entire viewport and filled it in pink colour - `grid.rect(gp = gpar(fill = "pink"))`

Note that we didn't leave the viewport yet. This means, whatever we do now, will happen in the currently active viewport (the pink one). To illustrate this, we will simply repeat the exact same code from above once more.


```r
our_first_vp <- viewport(x = 0.5, y = 0.5, 
                         height = 0.5, width = 0.5,
                         just = c("centre", "centre"))

pushViewport(our_first_vp)

grid.rect(gp = gpar(fill = "cornflowerblue"))
```

<figure><img src="../../book_figures/grid second vp.png"><figcaption>Figure 2: producing a second viewport using grid</figcaption></figure>

This means, that whatever viewport we are currently in, this defines our reference system (0 - 1). In case you don't believe me, we can repeat this 10 times more...


```r
for (i in 1:10) {
  our_first_vp <- viewport(x = 0.5, y = 0.5, 
                           height = 0.5, width = 0.5,
                           just = c("centre", "centre"))
  
  pushViewport(our_first_vp)
  
  grid.circle(gp = gpar(fill = colors()[i*3]))
}
```

<figure><img src="../../book_figures/grid several vps.png"><figcaption>Figure 3: producing several viewports using grid</figcaption></figure>

I hope this is proof enough now! We are cascading down viewports always creating a rectangle that fills half the 'mother' viewport each time. Yet, as the 'mother' viewport becomes smaller and smaller, our rectangles also become smaller at each step along the way (programmers would actually call these steps iterations, but we won't be bothered here...)

So, how do we navigate back?

If I counted correctly, we went down 12 rabbit holes. In order to get out of these again, we need to `upViewport(12)` and in order to see whether we are correct, we ask ```grid``` what viewport we are currently in.



```r
upViewport(12)

current.viewport()
```

```
viewport[ROOT] 
```

Sweet, we're back in the 'root' viewport...

Now, let's see how this `just` parameter works. As you have seen we are now in the `root` viewport. Let's try to draw another rectangle that sits right at the top left corner of the pink one. In theory the lower right corner of this viewport should be located at `x = 0.25` and `y = 0.75`. If we specify it like this, we need to adjust the justification, because we do not want to centre it on these coordinates. If these coordinates are the point of origin, this viewport should be justified right horizontally and bottom vertically. And the space we have to plot should be `0.25` vertically and `0.25` horizontally. Let's try this...


```r
top_left_vp <- viewport(x = 0.25, y = 0.75, 
                        height = 0.25, width = 0.25,
                        just = c("right", "bottom"))

pushViewport(top_left_vp)

grid.rect(gp = gpar(fill = "grey", alpha = 0.5))
```

<figure><img src="../../book_figures/grid top left vp.png"><figcaption>Figure 4: producing a yet another viewport using grid</figcaption></figure>



I hope that you have understood 2 things now:

1. how to create and navigate between viewports
2. why I said earlier that `grid` is a package for drawing...

Assuming that you have understood these two points, lets make use of the first one and use this incredibly flexible plotting framework for arranging multiple plots on one page.
