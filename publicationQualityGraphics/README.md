# Creating publication quality graphs in R
### Tim Appelhans


![](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)

This tutorial was developped as part of a one-day workshop held within the Ecosystem Informatics PhD-programme at the Philipps University of Marburg. The contents of this turtorial are published under the creatice commons license ['Attribution-ShareAlike CC BY-SA'](http://creativecommons.org/licenses/by-sa/3.0/).

The turorial was originally provided as one big document, but for easier digestion of the content, I have decided to break it into several smaller bits.

Further information about this PhD programme can be found [here](http://ecosysteminformatics.org/phd-programm-ecosystem-informatics/)

To see what we are usually up to I refer the interested reader to our homepage at http://www.environmentalinformatics-marburg.de

Another resource for creating visualisations using R, more focussed on climatological/atmospheric applications can be found at http://metvurst.wordpress.com

I hope you find parts of this tutorial, if not all of it useful.

Comments, feedback, suggestions and bug reports should be directed to [tim.appelhans {at} staff.uni-marburg.de](http://umweltinformatik-marburg.de/mitarbeiterinnen-und-mitarbeiter/tim-appelhans/)

**In this workshop we will**

* learn a few things about handling and preparing our data for the creation of meaningful graphs
* quickly introduce the two main ways of plot creation in R - base graphics and grid graphics
* concentrate on plot production using grid graphics
* become familiar with the two main packages for highly flexible data visualisation in R - lattice & ggplot2 (biased towards lattice I have to admit)
* learn how to modify the default options of these packages in order to really get what we want 
* learn even more flexibility using the grid package to create visualisations comprising multiple plots on one page and manipulate existing plots to suit our needs
* see how spatial data can be represented using the spatial packages available in R
* learn how to save our visualisations in different formats that comply with general publication standards of most academic journals

TIP: if you study the code provided in this tutorial closely, you will likely find some additional programming gems here and there which are not specifically introduced in this workshop... (such as the first two lines of code ;-))

**In this workshop it is assumed that you**

* already know how to get your data into R (```read.table()``` etc)
* have a basic understanding how particular parts of your data can be assessed (```$```, ```[``` - in case you do not know what these special characters mean in an R sense, you might want to start at a more basic level, e.g. [here](http://tryr.codeschool.com/))
* are familiar the notion of object creation/assignment ( ```<-``` )

**Note, howerver, that this workshop is not about statistics (we will only be marginally exposed to very basic statistical principles)**

_Before we start, I would like to highlight a few useful web resources for finding help in case you get stuck with a particular task:_

* [google is your friend](http://www.google.com) - for R related questions just type something like this 'r lattice how to change plot background color' The crux here is that you provide both the programming language - R - and the name of the package your question is related to - lattice. This way you will very likely find useful answers (the web is full of knowledgeable geeks)
* for quick reference on the most useful basic functionality of R use http://www.statmethods.net
* using google in the way outlined above, you will most likely end up at [Stackoverflow](http://www.stackoverflow.com) at some stage. This is a very helpful platform for all sorts of programming issues with an ever increasing contribution of the R community. To search directly at Stackoverflow for R related stuff, type 'r' in front of you search.
* [Rseek](http://www.rseek.org) is a search site dedicated exclusively to R-related stuff.
* [R-Bloggers](http://www.r-bloggers.com) is a nice site that provides access to all sorts of blog sites dedicated to R from all around the world (in fact, a lot of the material of this workshop is derived from posts found there).
* last, but not least, I am hopeful that [this site](http://www.teachpress.environmentalinformatics-marburg.de) will continue to grow and hence provide more and more useful tutorials closely related to issued in environmental sciences. So keep checking this site...
