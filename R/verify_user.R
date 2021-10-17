#' User and group verification
#'
#' @description `verify_user()` determines whether or not the given user or
#' group is registered with Pushover, returning information about that user.
#'
#' @param user user/group key to verify
#' @param app application token (see [`set_pushover_app`])
#' @param device (optional) device to verify If supplied the device must be registered to the given user's account.
#'
#' @return `verify_user()` and `verify_group()` return a list containing
#' the following fields:
#' \itemize{
#'     \item `status`: request status (`1` = success)
#'     \item `devices`: a list of the user's devices
#'     \item `request`: unique request ID
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
#'     \item `raw`: the raw [httr::response] object
#' }
#' @seealso [`is.valid_user`] and [`is.valid_group`] to
#' determine whether or not a user key has valid formatting, but is not
#' necessarily registered.
#' @export
#'
#' @examples
#' \dontrun{
#' verify_user(user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
verify_user <- function(user, app = get_pushover_app(), device = NULL) {
  assertthat::assert_that(
    assertthat::is.scalar(user),
    is.valid_user(user),
    assertthat::is.scalar(app),
    is.valid_app(app)
  )

  params <- list("token" = app, "user" = user)
  if (!is.null(device)) {
    assertthat::assert_that(
      assertthat::is.scalar(device),
      is.valid_device(device)
    )
    params$device <- device
  }

  pushover_api(
    verb = "POST",
    url = "https://api.pushover.net/1/users/validate.json",
    body = params
  )
}


#' @rdname verify_user
#' @description `verify_group()` is an alias for `verify_user()`
#' @export
verify_group <- verify_user


#' @rdname verify_user
#' @description `is.registered_user()` indicates whether or not a given user ID
#' is registered with Pushover
#' @return `is.registered_user()` and `is.registered_group()` return a logical
#' value indicating whether or not the given user or group is registered.
#' @export
is.registered_user <- function(user, app = get_pushover_app(), device = NULL) {
  rval <- verify_user(user = user, app = app, device = device)
  rval$status == 1
}


#' @rdname verify_user
#' @export
is.registered_group <- is.registered_user
