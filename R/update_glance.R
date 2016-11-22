#' Update a Pushover glance data
#'
#' Glances allow you to push small pieces of data to a frequently-updated screen
#' such as a smartwatch or a lock screen. At least one of the \code{title},
#' \code{text}, \code{subtext}, \code{count}, or \code{percent} arguments must
#' be specified.
#'
#' @note Glances are currently in beta, and features may change.
#' @param title (optional) a description of the data being shown, such as "Widgets Sold" (max. 100 characters)
#' @param text (optional) the main line of data, used on most screens (max. 100 characters)
#' @param subtext (optional) a second line of data (max. 100 characters)
#' @param count (optional) integer value shown on smaller screens; useful for simple counts
#' @param percent (optional) integer percent value (0..100) shown on some screens as a progress bar/circle
#' @param user user/group key (see \code{\link{set_pushover_user}})
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) name of the device(s) to send message to. Defaults
#' to all devices.
#'
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
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
        stop("Must provide at least one of the following arguments: title, text, subtext, count, percent", call. = FALSE)
    }
    assertthat::assert_that(assertthat::is.scalar(user), is.valid_user(user))
    assertthat::assert_that(assertthat::is.scalar(app), is.valid_app(app))

    params <- list("token" = app, "user" = user)

    if (!is.null(title)) {
        assertthat::assert_that(assertthat::is.scalar(title),
                                nchar(title) <= 100)
        params$title <- title
    }

    if (!is.null(text)) {
        assertthat::assert_that(assertthat::is.scalar(text),
                                nchar(text) <= 100)
        params$text <- text
    }

    if (!is.null(subtext)) {
        assertthat::assert_that(assertthat::is.scalar(subtext),
                                nchar(subtext) <= 100)
        params$subtext <- subtext
    }

    if (!is.null(count)) {
        assertthat::assert_that(assertthat::is.number(count))
        params$count <- count
    }

    if (!is.null(percent)) {
        assertthat::assert_that(assertthat::is.number(percent), percent >= 0, percent <= 100)
        params$percent <- percent
    }

    if (!is.null(device)) {
        assertthat::assert_that(assertthat::is.scalar(device),
                                is.valid_device(device))
        params$device <- device
    }

    pushover_api(verb = "POST",
                 url = "https://api.pushover.net/1/glances.json",
                 visible = FALSE,
                 body = params)
}
