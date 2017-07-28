[![Build Status](https://travis-ci.org/markvanderloo/dircreate.svg?branch=master)](https://travis-ci.org/markvanderloo/dircreate)
[![CRAN](http://www.r-pkg.org/badges/version/dircreate)](http://cran.r-project.org/package=dircreate/)
[![Downloads](http://cranlogs.r-pkg.org/badges/dircreate)](http://www.r-pkg.org/pkg/dircreate) 

### dircreate: drop-in replacement for base::dir.create

#### Why this package?

Because for some time, `dir.create` with `recursive=TRUE` fails on Windows
Network drives if you don't have write permission on each and every preexisting
subdirectory. 

For example, suppose you want to create a directory `foo/bar/baz` under
`//companynet/generaldir/yourhome/`. Normally you'd do this:

```r
## this fails on Windows with dir.create
dir.create("//companynet/generaldir/yourhome/foo/bar/baz", recursive=TRUE)
```

But that won't work on Windoze since you don't have write permission on
`//companynet` and also not on `/generaldir`. Thing is: you don't need write
permission there since they already exist. 



The failure is caused by some change in Windows since R's code hasn't changed
since 2008: see
[here](https://bugs.r-project.org/bugzilla/show_bug.cgi?id=17159) and the mail
thread
[here](http://r.789695.n4.nabble.com/Recursive-dir-create-on-Windows-shares-td4725108.html). Bad, bad Microsoft (but hey, what'd y'all expect?) 


#### I want it! how to install?

It is not on `CRAN` (yet). First install
[drat](https://CRAN.R-project.org/package=drat) if you don't have it.
```r
# in case of no 'drat':
install.packages('drat')

# then:
drat::addRepo('markvanderloo')
install.packages('dircreate')
```


#### What does it do?
On loading the package the original `dir.create` from base R is replaced
with (technically 'masked by') a new version that more thorougly checks
whether a directory actually needs to be created.

```r
suppressPackageStartupMessages(library(dircreate))
dir.create("//companynet/generaldir/yourhome/foo/bar/baz", recursive=TRUE)
```

And there was much rejoicing.


#### Great! Can I make this permanent?
Yes, if you add the following line to your `Rprofile.site` file (you find it
under `//<your R installation dir>/etc/`) the package will be loaded invisibly.

```r
suppressPackageStartupMessages(library(dircreate))
```
You can also add it to your own `.Rprofile` file so it only affects you and not
all users.


#### But, I need the original!
No problem, just use

```r
base::dir.create
```








