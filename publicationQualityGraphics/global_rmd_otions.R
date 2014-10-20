
opts_knit$set(base.dir='./', out.format='md')
opts_chunk$set(prompt=FALSE, comment='', results='markup', cache = TRUE, cache.path = '../../book_cache/', fig.path = '../../book_figures/', fig.align = 'center')


knit_hooks$set(plot = function(x, options) {
  paste('<figure><img src="',
        opts_knit$get('base.url'), paste(x, collapse = '.'),
        '"><figcaption>', options$fig.cap, '</figcaption></figure>',
        sep = '')
})

fn = local({
  i = 0
  function(x) {
    i <<- i + 1
    paste('Figure ', i, ': ', x, sep = '')
  }
})
# See yihui.name/knitr/options for more Knitr options.
##### Put other setup R code here
clrs_hcl <- function(n) {
  hcl(h = seq(230, 0, length.out = n), 
      c = 60, l = seq(10, 90, length.out = n), 
      fixup = TRUE)
}

