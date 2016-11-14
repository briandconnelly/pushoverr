#' Update a Pushover glance data
#'
#' Glances allow you to push small pieces of data to a frequently-updated screen
#' such as a smartwatch or a lock screen.
#'
#' @note Glances are currently in beta, and features may change.
#' @param user user/group key (see \code{\link{set_pushover_user}})
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) name of the device(s) to send message to. Defaults
#' to all devices.
#' @param ... Values for glance data fields. Must provide at least one of:
#' \itemize{
#'     \item \code{title}: a description of the data being shown, such as "Widgets Sold" (max. 100 characters)
#'     \item \code{text}: the main line of data, used on most screens (max. 100 characters)
#'     \item \code{subtext}: a second line of data (max. 100 characters)
#'     \item \code{count}: integer value shown on smaller screens; useful for simple counts
#'     \item \code{percent}: integer percent value (0..100) shown on some screens as a progress bar/circle
#' }
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
update_glance <- function(user = get_pushover_user(), app = get_pushover_app(),
                          device = NULL, ...) {

    assertthat::assert_that(assertthat::is.scalar(user))
    assertthat::assert_that(assertthat::is.scalar(app))

    params <- list("token" = app, "user" = user)
    if (!is.null(device)) {
        assertthat::assert_that(assertthat::is.scalar(device))
        params$device <- device
    }

    other_args <- list(...)
    glance_fields <- c("title", "text", "subtext", "count", "percent")
    assertthat::assert_that(any(glance_fields %in% names(other_args)))

    if ("title" %in% names(other_args)) {
        assertthat::assert_that(nchar(other_args[["title"]]) <= 100)
        params$title <- other_args[["title"]]
    }

    if ("text" %in% names(other_args)) {
        assertthat::assert_that(nchar(other_args[["text"]]) <= 100)
        params$text <- other_args[["text"]]
    }

    if ("subtext" %in% names(other_args)) {
        assertthat::assert_that(nchar(other_args[["subtext"]]) <= 100)
        params$subtext <- other_args[["subtext"]]
    }


    if ("count" %in% names(other_args)) {
        assertthat::assert_that(assertthat::is.number(other_args[["count"]]))
        params$count <- other_args[["count"]]
    }

    if ("percent" %in% names(other_args)) {
        assertthat::assert_that(assertthat::is.number(other_args[["percent"]]))
        params$percent <- other_args[["percent"]]
    }

    response <- httr::POST(url = "https://api.pushover.net/1/glances.json",
                           body = params)
    stop_for_pushover_status(response)

    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")

    invisible(rval)
}
