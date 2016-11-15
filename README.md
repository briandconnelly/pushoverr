# pushoverr

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![BSD License](https://img.shields.io/badge/license-BSD-brightgreen.svg)](https://opensource.org/licenses/BSD-2-Clause)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/pushoverr)](https://cran.r-project.org/package=pushoverr)

Got some R code that takes a while to complete?
Enough time to take a little walk or go get a coffee, but maybe not long enough to go home for the day?
pushoverr is an R package that allows you to send push notifications via [Pushover](https://pushover.net/) to your mobile devices (iOS or Android) or desktop.
Now you'll be able to easily let yourself or your group know when it's done.


## Prerequisites

You'll need an account with [Pushover](https://pushover.net/).
Once you have that, log in and [register an application](https://pushover.net/apps/build).
You should now have two codes---a **user key** and an **API token/key**.
These are what identify you and your app(s) to Pushover.
You'll pass these along to pushoverr whenever you send a message.
You'll also need the Pushover app for [iOS](https://pushover.net/clients/ios), [Android](https://pushover.net/clients/android), or your [desktop](https://pushover.net/clients/desktop).


## Installation

Installing pushoverr is as easy as running:

    install.packages("pushoverr")


### Latest and Greatest (Fingers Crossed) via GitHub

If you like living on the edge (or need a previous version), you can use [devtools](http://cran.r-project.org/web/packages/devtools/index.html) to install the latest and greatest version of pushoverr from GitHub.
To do so:

    if(!require("devtools")) install.packages("devtools")
    devtools::install_github("briandconnelly/pushoverr")

You'll also need to make sure that you have the excellent [httr](http://cran.r-project.org/web/packages/httr/index.html) package, which makes working with web connections easy.
For an up-to-date R setup, this can be done by running `install.packages("httr")`.


## Using pushoverr

Now that pushoverr's been installed, you're ready to start pushing some notifications.
To begin using pushoverr, you'll need to first load the library.
To do this, run:

    library(pushoverr)


### Example 1: Send Yourself A Message

In order to send a message, you'll need to have your user key and an app token.
Then:

    pushover(message = "Mr. Watson--come here--I want to see you.", user = <YOUR USER KEY>, app = <YOUR APP TOKEN>)

Within just a few seconds, your phone/tablet/watch/whatever should be abuzz with this historic message.
Using other arguments to `pushover`, you can configure other aspects of your message, including sounds, links, and message priorities.


### Example 2: Send Yourself an Important Message

Pushoverr provides message different message priorities.
Quiet messages arrive without playing a sound, high priority messages arrive with a reddish background, and emergency messages arrive and repeat until they've been acknowledged.
`pushoverr` provides easy methods for sending these:

    pushover_quiet(message = "The kittens are sleeping", user = <YOUR USER KEY>, app = <YOUR APP TOKEN>)

Or more urgently:

    pushover_emergency(message = "The kittens are awake, and they are ANGRY!", user = <YOUR USER KEY>, app = <YOUR APP TOKEN>)

Emergency messages return a receipt token that can be checked with `is.acknowledged()` to see whether or not it has been seen.


### Example 3: Saving Your Credentials

By default, pushoverr will prompt you for your key and app token when needed and save them for all subsequent commands.
You can directly tell pushoverr your key and token using `set_pushover_user` and `set_pushover_app`:

    set_pushover_user(user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
    set_pushover_app(token = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")

pushoverr will forget these as soon as you end your session, so you'll have to re-run these commands each time you restart R.

Alternatively, you can store your keys in your `.Renviron` (see `?.Renviron` for details).

    PUSHOVER_USER = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG"
    PUSHOVER_APP= "azGDORePK8gMaC0QOYAMyEEuzJnyUi"

With this approach, your keys will be set whenever you use R.
pushoverr will use these keys by default, but they can easily be overridden by supplying different values as arguments.


### Example 4: Sending to a Specific Device

If you have more than one device using Pushover, you can also send messages to a specific device:

    pushover(message = "If you pretend like this is important, you can walk out of the boring meeting", device = "Phone")


### Example 5: Results on your Wrist

Pushover can now show data on constantly-updated screens like your smartwatch or lock screen (where supported).
Using `update_glance`, you can push short text messages, numbers, and percentages to your watch right from within R.

    update_glance(count = 88)


## Feature Requests and Bug Reports
For all feature requests and bug reports, visit [pushoverr on GitHub](https://github.com/briandconnelly/pushoverr/issues).


## Related Links
* [Pushover](https://pushover.net)
    * [FAQ](https://pushover.net/faq)
    * [API](https://pushover.net/api)
    * [Terms of Service](https://pushover.net/terms)
* [NotifyR](http://cran.r-project.org/web/packages/notifyR/index.html), an alternate Pushover tool for R (no longer maintained?)
* [CRAN Info for pushoverr](https://cran.r-project.org/web/packages/pushoverr/index.html)
* [RPushbullet](https://github.com/eddelbuettel/rpushbullet), an R interface for [Pushbullet](https://www.pushbullet.com), a similar (and larger) service.


Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.


## Disclaimer
This package and its author are not affiliated with [Superblock](https://superblock.net), developers of Pushover.

