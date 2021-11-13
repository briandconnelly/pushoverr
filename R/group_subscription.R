#' @rdname group_subscription
#' @title Manage group subscriptions
#'
#' @description These functions manage a user's membership in a Pushover
#' delivery group
#'
#' @param group group key
#' @param user user key
#' @param app application token (see [`set_pushover_app()`])
#' @param device (optional) device name to receive messages (defaults to all
#' devices)
#' @param memo (optional) memo about the user
#'
#' @return An invisible list containing the following fields:
#' \itemize{
#'     \item `status`: request status (1 = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#' }
#'

#' @description `group_add_user()` adds a user to a group. Optionally, a
#' device can be specified on which that user will receive notifications
#' @export
#' @examples
#' \dontrun{
#' group_add_user(
#'   group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG",
#'   device = "phone"
#' )
#' }
group_add_user <- function(group, user, app = get_pushover_app(), device = NULL,
                           memo = NULL) {
  group_subscription(
    cmd = "add_user", group = group, user = user,
    token = app, device = device, memo = memo
  )
}


#' @rdname group_subscription
#' @description `group_delete_user()` removes a user from a group
#' @export
#' @examples
#' \dontrun{
#' group_delete_user(
#'   group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG"
#' )
#' }
group_delete_user <- function(group, user, app = get_pushover_app()) {
  group_subscription(
    cmd = "delete_user", group = group, user = user,
    token = app
  )
}


#' @rdname group_subscription
#' @description `group_disable_user()` temporarily disables a user from
#' receiving group notifications.
#' @export
#' @examples
#' \dontrun{
#' group_disable_user(
#'   group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG"
#' )
#' }
group_disable_user <- function(group, user, app = get_pushover_app()) {
  group_subscription(
    cmd = "disable_user", group = group, user = user,
    token = app
  )
}


#' @rdname group_subscription
#' @description `group_enable_user()` re-enables a user to receive group
#' notifications for a group
#' @export
#' @examples
#' \dontrun{
#' group_enable_user(
#'   group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG"
#' )
#' }
group_enable_user <- function(group, user, app = get_pushover_app()) {
  group_subscription(
    cmd = "enable_user", group = group, user = user,
    token = app
  )
}


group_subscription <- function(cmd, ...) {
  opt_args <- list(...)

  if ("group" %in% names(opt_args)) {
    assert_valid_group(opt_args[["group"]])
  }

  if ("user" %in% names(opt_args)) {
    assert_valid_user(opt_args[["user"]])
  }

  if ("token" %in% names(opt_args)) {
    assert_valid_app(opt_args[["token"]])
  }

  if ("device" %in% names(opt_args)) {
    assert_valid_device(opt_args[["device"]])
  }

  if ("memo" %in% names(opt_args)) {
    checkmate::assert_string(opt_args[["memo"]])
    checkmate::assert_true(nchar(opt_args[["memo"]]) <= 200)
  }

  invisible(
    pushover_api(
      verb = "POST",
      url = glue("https://api.pushover.net/1/groups/{opt_args$group}/{cmd}.json"),
      body = opt_args
    )
  )
}
