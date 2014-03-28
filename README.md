# pushoverr

Got some R code that takes a while to complete? Enough time to take a little
walk or go get a coffee, but maybe not long enough to go home for the day?
pushoverr is an R package that allows you to send push notifications via
[Pushover](https://pushover.net/) to your iOS or Android devices (or desktop in
the near future). Now you'll be able to easily let yourself know when it's done
(or whenever else you want to send yourself or your group a message).


## Prerequisites

You'll need a free account with [Pushover](https://pushover.net/). Once you
have that, log in and [register an
application](https://pushover.net/apps/build). You should now have two
codes---a **user key** and an **API token/key**. These are what identify you
and your app(s) to Pushover. You'll pass these along to pushoverr whenever you
send a message.


## Installation

pushoverr has been submitted to CRAN, but has not yet been approved. Once that's been done, it'll be as
easy as running:

    install.packages('pushoverr')

Until then, see below for notes on installing via GitHub.


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

In order to send a message, you'll need to have your user key and an app token.
Then:

    pushover(message='Mr. Watson--come here--I want to see you.', user=<YOUR USER KEY>, token=<YOUR APP TOKEN>)

Within just a few seconds, your phone/tablet/watch/whatever should be abuzz
with this historic message.


### Example 2: Send Yourself an Important Message

Pushoverr provides message different message priorities. Quiet messages arrive
without playing a sound, high priority messages arrive with a reddish
background, and emergency messages arrive and repeat until they've been
acknowledged. `pushoverr` provides easy methods for sending these:

    pushover_quiet(message='The kittens are sleeping', user=<YOUR USER KEY>, token=<YOUR APP TOKEN>)

Or more urgently:

    pushover_emergency(message='The kittens are awake, and they're angry!', user=<YOUR USER KEY>, token=<YOUR APP TOKEN>)

Emergency messages return a receipt token that can be checked with
`is.acknowledged()` to see whether or not it has been acknowledged.


### Example 3: Saving Your Credentials

Remembering to include your user key and app token every time you send a
message is a big hassle. You can set these once and use them for all subsequent
messages:

    set_pushover_app(token=<YOUR APP TOKEN>, user=<YOUR USER KEY>)
    pushover('I can now send so many more messages!')

And to temporarily use a different app token or user:

    pushover('You can get with this (app)')
    pushover('Or you can get with that (app)', token=<OTHER APP TOKEN>)



## Feature Requests and Bug Reports
For all feature requests and bug reports, visit [pushoverr on
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
[Superblock](http://superblock.net), developers of Pushover.

