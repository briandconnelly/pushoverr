#' Send a message using Pushover
#'
#' `pushover()` sends a message (push notification) to a user or group.
#' Messages can be given different priorities, play different sounds, or require
#' acknowledgments.
#' `pushover_normal()`, `pushover_silent`, `pushover_quiet`, `pushover_high`,
#' and `pushover_emergency` functions send messages with those priorities.
#'
#' @param message The message to be sent (max. 1024 characters). Messages use
#' [glue::glue()] for formatting and interpolation.
#' @param title (optional) The message's title. Titles use [glue::glue()] for
#' formatting and interpolation.
#' @param priority Message priority (`-2`: silent, `-1`: quiet, `0`: normal
#' (default), `1`: high, `2`: emergency)
#' @param attachment Path of file attachment to include. File must be image
#' format (bmp, jpg, png, tif) and no larger than 2.6 MB.
#' @param user user/group key (see [`set_pushover_user()`])
#' @param app application token (see [`set_pushover_app()`])
#' @param device (optional) name of the device(s) to send message to. Defaults
#' to all devices.
#' @param sound (optional) name of the sound to play (see
#' <https://pushover.net/api#sounds>)
#' @param url (optional) supplementary URL to display with message
#' @param url_title (optional) title to show for supplementary URL
#' @param format Message formatting. If `html` (default), messages can include a
#' [limited subset](https://pushover.net/api#html) of HTML formatting. If
#' `monospace`, text is formatted using monospace font.
#' @param retry (optional) how often (in seconds) to repeat emergency priority
#' messages (min: 30 seconds; default: 60 seconds)
#' @param expire (optional) how long (in seconds) emergency priority messages
#' will be retried (max: 86400 seconds; default: 3600 seconds)
#' @param callback (optional) callback URL to be visited (HTTP POST) once an
#' emergency priority message has been acknowledged
#' ([details](https://pushover.net/api#receipt))
#' @param timestamp (optional) a Unix timestamp containing the date and time to
#' display to the user instead of the time at which the message was received
#'
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item `status`: request status (1 = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#'     \item `receipt`: a receipt ID (only for emergency priority messages)
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
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
                     attachment = NULL,
                     user = get_pushover_user(),
                     app = get_pushover_app(),
                     device = NULL,
                     sound = NULL,
                     url = NULL,
                     url_title = NULL,
                     format = c("html", "monospace"),
                     retry = 60,
                     expire = 3600,
                     callback = NULL,
                     timestamp = NULL) {
  checkmate::assert_string(message, min.chars = 1)
  checkmate::assert_true(nchar(message) <= 1024)
  format <- arg_match(format)
  checkmate::assert(retry <= expire)

  params <- list(
    "token" = assert_valid_app(app),
    "user" = assert_valid_user(user),
    "message" = glue(message),
    "priority" = checkmate::assert_choice(priority, -2:2),
    "retry" = checkmate::assert_integerish(
      retry,
      lower = 30,
      any.missing = FALSE
    ),
    "expire" = checkmate::assert_integerish(
      expire,
      upper = 10800,
      any.missing = FALSE
    )
  )

  if (!is.null(attachment)) {
    checkmate::assert_file_exists(
      attachment,
      access = "r",
      extension = c("bmp", "gif", "jpg", "jpeg", "png", "tif", "tiff")
    )
    checkmate::check_true(file.size(attachment) <= 2621440)

    params$attachment <- httr::upload_file(attachment)
  }

  if (format == "html") {
    params$html <- 1
  } else if (format == "monospace") {
    params$monospace <- 1
  }

  if (!is.null(device)) {
    # TODO: handle >1 device
    assert_valid_device(device)
    params["device"] <- paste0(device, collapse = ",")
  }

  if (!is.null(title)) {
    checkmate::assert_string(title, min.chars = 1)
    checkmate::assert_true(nchar(title) <= 250)
    params$title <- glue(title)
  }

  if (!is.null(url)) {
    checkmate::assert_string(url, min.chars = 1)
    checkmate::assert_true(nchar(url) <= 512)
    params$url <- url
  }

  if (!is.null(url_title)) {
    checkmate::assert_string(url_title, min.chars = 1)
    checkmate::assert_true(nchar(url_title) <= 100)
    params$url_title <- url_title
  }

  if (!is.null(timestamp)) {
    params$timestamp <- checkmate::assert_count(timestamp)
  }

  if (!is.null(sound)) {
    params$sound <- assert_valid_sound(sound)
  }

  if (!is.null(callback)) {
    # Docs don't say what character limit is
    checkmate::assert_string(callback, min.chars = 1)
    params$callback <- callback
  }

  invisible(
    pushover_api(
      verb = "POST",
      url = "https://api.pushover.net/1/messages.json",
      body = params
    )
  )
}


#' @rdname pushover
#' @param ... Additional arguments to pass to `pushover()`
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
