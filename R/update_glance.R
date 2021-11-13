#' Update a Pushover glance data
#'
#' Glances allow you to push small pieces of data to a frequently-updated screen
#' such as a smartwatch or a lock screen. At least one of the `title`,
#' `text`, `subtext`, `count`, or `percent` arguments must
#' be specified.
#'
#' @note Glances are currently in beta, and features may change.
#' @param title (optional) a description of the data being shown, such as
#' "Widgets Sold" (max. 100 characters)
#' @param text (optional) the main line of data, used on most screens (max. 100
#' characters)
#' @param subtext (optional) a second line of data (max. 100 characters)
#' @param count (optional) integer value shown on smaller screens; useful for
#' simple counts
#' @param percent (optional) integer percent value (0..100) shown on some
#' screens as a progress bar/circle
#' @param user user/group key (see [`set_pushover_user()`])
#' @param app application token (see [`set_pushover_app()`])
#' @param device (optional) name of the device(s) to send message to. Defaults
#' to all devices.
#'
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item `status`: request status (`1` = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' update_glance(count = 37)
#' }
update_glance <- function(title = NULL, text = NULL, subtext = NULL,
                          count = NULL, percent = NULL,
                          user = get_pushover_user(), app = get_pushover_app(),
                          device = NULL) {
  if (is.null(c(title, text, subtext, count, percent))) {
    cli::cli_abort("Must provide at least one of the following arguments: {.arg title}, {.arg text}, {.arg subtext}, {.arg count}, {.arg percent}")
  }

  assert_valid_user(user)
  assert_valid_app(app)

  params <- list("token" = app, "user" = user)

  if (!is.null(title)) {
    checkmate::assert_string(title)
    checkmate::assert_true(nchar(title) <= 100)
    params$title <- title
  }

  if (!is.null(text)) {
    checkmate::assert_string(text)
    checkmate::assert_true(nchar(text) <= 100)
    params$text <- text
  }

  if (!is.null(subtext)) {
    checkmate::assert_string(subtext)
    checkmate::assert_true(nchar(subtext) <= 100)
    params$subtext <- subtext
  }

  if (!is.null(count)) {
    checkmate::check_integerish(count)
    params$count <- as.integer(count)
  }

  if (!is.null(percent)) {
    checkmate::check_number(percent, lower = 0, upper = 100)
    checkmate::check_integerish(percent)
    params$percent <- as.integer(percent)
  }

  if (!is.null(device)) {
    assert_valid_device(device)
    params$device <- device
  }

  invisible(
    pushover_api(
      verb = "POST",
      url = "https://api.pushover.net/1/glances.json",
      body = params
    )
  )
}
