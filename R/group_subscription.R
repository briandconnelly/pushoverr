#' Manage group subscriptions
#' 
#' These functions manage a user's membershop in a Pushover delivery group
#'
#' @param cmd The group subscription command to execute
#' @param group group key
#' @param user user key
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) device name to receive messages (defaults to all devices)
#' @param memo (optional) memo about the user
#' @param ... Specific arguments for the given group subscription command
#'
#' @return An invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
group_subscription <- function(cmd, ...) {
    opt_args <- list(...)

    if ("group" %in% names(opt_args)) {
        assertthat::assert_that(assertthat::is.scalar(opt_args[["group"]]),
                                is.valid_group(opt_args[["group"]]))
    }

    if ("user" %in% names(opt_args)) {
        assertthat::assert_that(assertthat::is.scalar(opt_args[["user"]]),
                                is.valid_user(opt_args[["user"]]))
    }

    if ("token" %in% names(opt_args)) {
        assertthat::assert_that(assertthat::is.scalar(opt_args[["token"]]),
                                is.valid_app(opt_args[["token"]]))
    }

    if ("device" %in% names(opt_args)) {
        assertthat::assert_that(assertthat::is.scalar(opt_args[["device"]]),
                                is.valid_device(opt_args[["device"]]))
    }

    if ("memo" %in% names(opt_args)) {
        assertthat::assert_that(assertthat::is.scalar(opt_args[["memo"]]),
                                nchar(opt_args[["memo"]]) <= 200)
    }

    query_url <- sprintf("https://api.pushover.net/1/groups/%s/%s.json",
                         opt_args$group, cmd)
    pushover_api(verb = "POST", url = query_url, visible = FALSE,
                 body = opt_args)
}

#' @rdname group_subscription
#' @description \code{group_add_user} adds a user to a group. Optionally, a
#' device can be specified on which that user will receive notifications
#' @export
#' @examples
#' \dontrun{
#' group_add_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG",
#'                device = "phone")
#' }
group_add_user <- function(group, user, app = get_pushover_app(), device = NULL,
                           memo = NULL) {
    group_subscription(cmd = "add_user", group = group, user = user,
                       token = app, device = device, memo = memo)
}


#' @rdname group_subscription
#' @description \code{group_delete_user} removes a user from a group 
#' @export
#' @examples
#' \dontrun{
#' group_delete_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
group_delete_user <- function(group, user, app = get_pushover_app()) {
    group_subscription(cmd = "delete_user", group = group, user = user,
                       token = app)
}


#' @rdname group_subscription
#' @description \code{group_disable_user} temporarily disables a user from
#' receiving group notifications. 
#' @export
#' @examples
#' \dontrun{
#' group_disable_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                    user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
group_disable_user <- function(group, user, app = get_pushover_app()) {
    group_subscription(cmd = "disable_user", group = group, user = user,
                       token = app)
}


#' @rdname group_subscription
#' @description \code{group_enable_user} re-enables a user to receive group
#' notifications for a group
#' @export
#' @examples
#' \dontrun{
#' group_enable_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
group_enable_user <- function(group, user, app = get_pushover_app()) {
    group_subscription(cmd = "enable_user", group = group, user = user,
                       token = app)
}
