\docType{package}
\name{pushoverr-package}
\alias{pushoverr}
\alias{pushoverr-package}
\title{pushoverr: Send push notifications to iOS and Android devices using Pushover}
\description{
\code{pushoverr} is package for sending push notifications
to iOS and Android devices using
\href{https://pushover.net}{Pushover}.
Messages can be quickly sent using the
\code{\link{pushover}}, \code{\link{pushover_quiet}},
\code{\link{pushover_normal}}, \code{\link{pushover_high}},
and \code{\link{pushover_emergency}} functions.
Behind the scenes, messages are
created using \code{\link{PushoverMessage}} objects, and
responses are stored in \code{\link{PushoverResponse}}
objects.
}
\details{
For more information, browse the package index by following
the link at the bottom of this help page. For release
information, run \code{news(package=='pushoverr')}.
}
\section{Disclaimer}{
  This package and its author are not affiliated with
  \href{http://superblock.net}{Superblock, LLC}, creators
  of Pushover.
}
\author{
Brian Connelly
}
\seealso{
GitHub Repository:
\url{https://github.com/briandconnelly/pushoverr}

Bug Reports and Feature Requests:
\url{https://github.com/briandconnelly/pushoverr/issues}

Pushover: \url{https://pushover.net}

Pushover API: \url{https://pushover.net/api}
}

