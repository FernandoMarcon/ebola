# R Package Development

[source](https://www.prestevez.com/post/r-package-tutorial/#what-are-packages)

## Basic Setup

Install necessary packages

```R
install.packages(c("devtools", "roxygen2", "testthat", "knitr"))
```

Test if system is suitable for package development

```R
devtools::has_devel()
# #> Your system is ready to build packages!
```

Initialize the file projec

```R
create_package("~/projects/packages/toypackage") ## write the path to your WD
```

Load packages

```R
library(devtools)
```

Fill-up `DESCRIPTION`file

Add (MIT) license

```R
use_mit_license("Fernando Marcon Passos")
```

initialize version control

```R
use_git()
```

Check Status

```R
check()
```

## Functions

```R
use_r("hello")
load_all()
hello("Patricio")
```

Check Status

```R
check()
```

## Documentation

```R
document()  # generate documentation
check()     # check
install()   # install package locally
```

# Test

```R
usethis::use_testthat() # create tests for each function
use_test("hello")
```

Check Status

```R
check()
```

# Add Dependencies/External Packages

```R
use_package("stringr")
use_r("greetings")
document()
load_all()
greetings(c("Alice", "Bob"))
```

Use this command if you have SSH keys associated with Github

```R
use_github(protocol = "ssh")
```

Use this command if you don't

```R
use_github()
```

README

```R
use_readme_rmd()
build_readme()
```

check again

```R
test()
```

## Add package to Github

Commit and push the changes you made and visit your Github repository, it should look like this: prestevez/toypackage.

This package can now be installed from anywhere in the world using this command:

```R
devtools::install_github("prestevez/toypackage")
```
