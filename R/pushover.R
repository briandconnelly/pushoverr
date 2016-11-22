#' Send a message using Pushover
#'
#' \code{pushover} sends a message (push notification) to a user or group.
#' Messages can be given different priorities, play different sounds, or require
#' acknowledgments. The \code{pushover_normal}, \code{pushover_silent},
#' \code{pushover_quiet}, \code{pushover_high}, and \code{pushover_emergency}
#' functions send messages with those priorities.
#'
#' @param message The message to be sent (max. 1024 characters)
#' @param title (optional) The message's title
#' @param priority Message priority (-2: silent, -1: quiet, 0: normal (default), 1: high, 2: emergency)
#' @param user user/group key (see \code{\link{set_pushover_user}})
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) name of the device(s) to send message to. Defaults to all devices.
#' @param sound (optional) name of the sound to play (see \url{https://pushover.net/api#sounds})
#' @param url (optional) supplementary URL to display with message
#' @param url_title (optional) title to show for supplementary URL
#' @param retry (optional) how often (in seconds) to repeat emergency priority messages (min: 30 seconds; default: 60 seconds)
#' @param expire (optional) how long (in seconds) emergency priority messages will be retried (max: 86400 seconds; default: 3600 seconds)
#' @param callback (optional) callback URL to be visited (HTTP POST) once an emergency priority message has been acknowledged (\href{https://pushover.net/api#receipt}{details})
#' @param timestamp (optional) a Unix timestamp containing the date and time to display to the user instead of the time at which the message was received
#'
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#'     \item \code{receipt}: a receipt ID (only for emergency priority messages)
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' pushover(message = "Hola Mundo!")
#' }
pushover <- function(message,
                     title = NULL,
                     priority = 0,
                     user = get_pushover_user(),
                     app = get_pushover_app(),
                     device = NULL,
                     sound = NULL,
                     url = NULL,
                     url_title = NULL,
                     retry = 60,
                     expire = 3600,
                     callback = NULL,
                     timestamp = NULL) {

    assertthat::assert_that(nchar(message) <= 1024)
    assertthat::assert_that(assertthat::is.scalar(user), is.valid_user(user))
    assertthat::assert_that(assertthat::is.scalar(app), is.valid_app(app))
    assertthat::assert_that(assertthat::is.number(priority),
                            priority %in% c(-2, -1, 0, 1, 2))
    assertthat::assert_that(assertthat::is.count(retry), retry >= 30)
    assertthat::assert_that(assertthat::is.count(expire), expire <= 86400)

    params <- list("token" = app,
                   "user" = user,
                   "message" = message,
                   "priority" = priority,
                   "retry" = retry,
                   "expire" = expire)

    if (!is.null(device)) {
        assertthat::assert_that(all(is.valid_device(device)))
        params["device"] <- paste0(device, collapse = ",")
    }

    if (!is.null(title)) {
        assertthat::assert_that(nchar(title) <= 250)
        params$title <- title
    }

    if (!is.null(url_title)) {
        assertthat::assert_that(nchar(url_title) <= 100)
        params$url_title <- url_title
    }

    if (!is.null(timestamp)) {
        assertthat::assert_that(assertthat::is.count(timestamp))
        params$timestamp <- timestamp
    }

    if (!is.null(sound)) {
        assertthat::assert_that(assertthat::is.scalar(sound),
                                is.pushover_sound(sound))
        params$sound <- sound
    }

    if (!is.null(callback)) {
        # Docs don't say what character limit is, so not validating
        params$callback <- callback
    }

    pushover_api(verb = "POST",
                 url = "https://api.pushover.net/1/messages.json",
                 visible = FALSE,
                 body = params)
}


#' @rdname pushover
#' @param ... Additional arguments to pass to \code{pushover()}
#' @export
pushover_silent <- function(message, ...) {
    pushover(message = message, priority = -2, ...)
}


#' @rdname pushover
#' @export
pushover_quiet <- function(message, ...) {
    pushover(message = message, priority = -1, ...)
}


#' @rdname pushover
#' @export
pushover_normal <- function(message, ...) {
    pushover(message = message, priority = 0, ...)
}


#' @rdname pushover
#' @export
pushover_high <- function(message, ...) {
    pushover(message = message, priority = 1, ...)
}


#' @rdname pushover
#' @export
pushover_emergency <- function(message, ...) {
    pushover(message = message, priority = 2, ...)
}
