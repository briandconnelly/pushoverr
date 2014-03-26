# pushoverr

Got some R code that takes a while to complete? Enough time to take a little
walk or go get a coffee, but not long enough to go home for the day?  pushoverr
is an R package that allows you to send push notifications via
[Pushover](https://pushover.net/) to your iOS or Android devices. Now you'll be
able to let yourself know when it's done (or whenever else you want to send
yourself or your group a message).


## Prerequisites

You'll need a free account with [Pushover](https://pushover.net/). Once you
have that, log in and [register an
application](https://pushover.net/apps/build). You should now have two
codes---a **user key** and an **API token/key**. These are what identify you
and your app(s) to Pushover. You'll pass these along to pushoverr whenever you
send a message.


## Installation

pushoverr hasn't yet been submitted to CRAN. Once that's been done, it'll be as
easy as running:

    install.packages('pushoverr')

Until then, see below for how to install via GitHub.


### Latest and Greatest (Fingers Crossed) via GitHub

If you like living on the edge, you can use
[devtools](http://cran.r-project.org/web/packages/devtools/index.html) to
install the latest and greatest version of pushoverr from GitHub. To do so:

    library(devtools)
    install_github('briandconnelly/pushoverr')

You'll also need to make sure that you have the the excellent
[httr](http://cran.r-project.org/web/packages/httr/index.html) package, which
makes working with web connections easy.  For an up-to-date R setup, this can
be done by running `install.packages('httpr')`.

## Using pushoverr

Now that pushoverr's been installed, you're ready to start pushing some
notifications. To begin using pushoverr, you'll need to first load the library.
To do this, run:

    library(pushoverr)
    
### Example 1: Send Yourself A Message

TODO


## Feature Requests and Bug Reports For all feature requests and bug reports,
please visit [pushoverr on
GitHub](https://github.com/briandconnelly/pushoverr/issues).


## Related Links
* [Pushover](https://pushover.net)
    * [Terms of Service](https://pushover.net/terms)
    * [FAQ](https://pushover.net/faq)
    * [API](https://pushover.net/api)
* [NotifyR](http://cran.r-project.org/web/packages/notifyR/index.html), an
alternate Pushover tool for R

## Disclaimer
This package and its author are not affiliated with
[Superblock](http://superblock.net), creators of Pushover.
