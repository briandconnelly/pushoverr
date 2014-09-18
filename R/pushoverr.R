#' pushoverr: Send push notifications using Pushover
#' 
#' \code{pushoverr} is package for sending push notifications to mobile devices
#' (iOS and Android) and the desktop using
#' \href{https://pushover.net}{Pushover}. Messages can be quickly sent using the
#' \code{\link{pushover}}, \code{\link{pushover_silent}},
#' \code{\link{pushover_quiet}}, \code{\link{pushover_normal}},
#' \code{\link{pushover_high}}, and \code{\link{pushover_emergency}} functions.
#' Behind the scenes, messages are created using \code{\link{PushoverMessage}}
#' objects, and responses are stored in \code{\link{PushoverResponse}} objects.
#' 
#' @docType package
#' @name pushoverr
#' @aliases pushoverr-package
#' @author Brian Connelly
#' @details For more information, browse the package index by following the link
#' at the bottom of this help page. For release information, run
#' \code{news(package='pushoverr')}.
#' @section Disclaimer: This package and its author are not affiliated with
#' \href{http://superblock.net}{Superblock, LLC}, creators of Pushover.
#' @seealso GitHub Repository: \url{https://github.com/briandconnelly/pushoverr}
#' @seealso Bug Reports and Feature Requests: \url{https://github.com/briandconnelly/pushoverr/issues}
#' @seealso Pushover: \url{https://pushover.net}
#' @seealso Pushover API: \url{https://pushover.net/api}
#' @import httr
NULL
