
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pushoverr

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/briandconnelly/pushoverr/branch/master/graph/badge.svg)](https://app.codecov.io/gh/briandconnelly/pushoverr?branch=master)
[![R-CMD-check](https://github.com/briandconnelly/pushoverr/workflows/R-CMD-check/badge.svg)](https://github.com/briandconnelly/pushoverr/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/pushoverr)](https://CRAN.R-project.org/package=pushoverr)
<!-- badges: end -->

pushoverr allows you to send push notifications from R to mobile
devices, web browsers, or even your watch using
[Pushover](https://pushover.net/). These notifications can display job
status, results, scraped web data, or any other text or numeric data.
Got some R code that takes a while to complete? Enough time to take a
little walk or go get a coffee, but maybe not long enough to go home for
the day? Now you’ll be able to easily let yourself or your group know
when it’s done.

## Installation

Installing pushoverr is as easy as running:

``` r
install.packages("pushoverr")
```

Alternately, you can install the development version of pushoverr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("briandconnelly/pushoverr")
```

That’s it! See the [Getting
Started](https://briandconnelly.github.io/pushoverr/articles/getting_started.html)
vignette to start sending messages.

## Features Not Supported

pushoverr currently does not support
[subscriptions](https://pushover.net/api/subscriptions/),
[licensing](https://pushover.net/api/licensing/) (I don’t use Pushover
in this context, so I can’t test these features), or the [open client
API](https://pushover.net/api/client/). If you’d like to see these
features supported, please submit an
[issue](https://github.com/briandconnelly/pushoverr/issues) or a pull
request.

## Related Links

-   [Pushover](https://pushover.net/)
    -   [Support](https://support.pushover.net/)
    -   [API](https://pushover.net/api/)
    -   [Terms of Service](https://pushover.net/terms/)
-   [R Phone Home: Notifications with
    pushoverr](http://bconnelly.net/2016/11/R-phone-home/), blog post
    about using pushoverr
-   [NotifyR](https://cran.r-project.org/package=notifyR), an alternate
    Pushover tool for R (no longer maintained?)
-   [RPushbullet](https://eddelbuettel.github.io/rpushbullet/), an R
    interface for [Pushbullet](https://www.pushbullet.com/), a similar
    push notification service.

## Code of Conduct

Please note that the pushoverr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Disclaimer

This package and its author are not affiliated with Pushover, LLC.
