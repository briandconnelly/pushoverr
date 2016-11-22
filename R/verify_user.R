#' User and group verification
#' 
#' @description \code{verify_user} determines whether or not the given user or
#' group is registered with Pushover, returning information about that user.
#'
#' @param user user/group key to verify
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) device to verify If supplied the device must be registered to the given user's account.
#'
#' @return \code{verify_user} and \code{verify_group} return a list containing
#' the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{devices}: a list of the user's devices
#'     \item \code{request}: unique request ID
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @seealso \code{\link{is.valid_user}} and \code{\link{is.valid_group}} to
#' determine whether or not a user key has valid formatting, but is not
#' necessarily registered.
#' @export
#'
#' @examples
#' \dontrun{
#' verify_user(user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
verify_user <- function(user, app = get_pushover_app(), device = NULL) {
    assertthat::assert_that(assertthat::is.scalar(user), is.valid_user(user))
    assertthat::assert_that(assertthat::is.scalar(app), is.valid_app(app))

    params <- list("token" = app, "user" = user)
    if (!is.null(device)) {
        assertthat::assert_that(assertthat::is.scalar(device),
                                is.valid_device(device))
        params$device <- device
    }

    pushover_api(verb = "POST",
                 url = "https://api.pushover.net/1/users/validate.json",
                 body = params)
}


#' @rdname verify_user
#' @description \code{is.registered_user} indicates whether or not a given user ID
#' is registered with Pushover
#' @return \code{is.registered_user} and \code{is.registered_group} return a
#' logical value indicating whether (\code{TRUE}) or not (\code{FALSE}) the
#' given user or group is registered.
#' @export
is.registered_user <- function(user, app = get_pushover_app(), device = NULL) {
    rval <- verify_user(user = user, app = app, device = device)
    rval$status == 1
}


#' @rdname verify_user
#' @description \code{verify_group} is an alias for \code{verify_user}
#' @export
verify_group <- verify_user


#' @rdname verify_user
#' @description \code{validate_key} is deprecated in favor of
#' \code{verify_user}
#' @param ... Additional arguments (no longer used)
#' @export
validate_key <- function(user, device = NA_character_, ...) {
    message("validate_key() is deprecated. Please use verify_user() or verify_group() instead.")

    opt_args <- list(...)
    app <- ifelse("token" %in% names(opt_args),
                  opt_args[["token"]],
                  get_pushover_app())

    if (is.na(device)) {
        device <- NULL
    }

    verify_user(user = user, app = app, device = device)
}


#' @rdname verify_user
#' @export
is.registered_group <- is.registered_user


#' @rdname verify_user
#' @description \code{is.valid_key} is deprecated in favor of \code{is.registered_user} or \code{is.registered_group}
#' @export
is.valid_key <- function(user, device = NA, ...) {
    message("is.valid_key() is deprecated. Please use is.registered_user() or is.registered_group() instead.")

    opt_args <- list(...)
    app <- ifelse("token" %in% names(opt_args),
                  opt_args[["token"]],
                  get_pushover_app())

    if (is.na(device)) {
        device <- NULL
    }

    is.registered_user(user = user, app = app, device = device)
}
