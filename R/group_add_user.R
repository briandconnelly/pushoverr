#' Manage group memberships
#' 
#' @description \code{group_add_user} adds a user to a group. Optionally, a
#' device can be specified on which that user will receive notifications.
#'
#' @param group group key
#' @param user user key
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) device name to receive messages (defaults to all devices)
#' @param memo (optional) memo about the user
#'
#' @return An invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' group_add_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG",
#'                device = "phone")
#' }
group_add_user <- function(group, user, app = get_pushover_app(), device = NULL,
                           memo = NULL) {
    group_subscription_cmd(cmd = "add_user", group = group, user = user,
                           token = app, device = device, memo = memo)
}


#' @rdname group_add_user
#' @description \code{group_delete_user} removes a user from a group 
#' @export
#' @examples
#' \dontrun{
#' group_delete_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
group_delete_user <- function(group, user, app = get_pushover_app(),
                              device = NULL, memo = NULL) {
    group_subscription_cmd(cmd = "delete_user", group = group, user = user,
                           token = app, device = device, memo = memo)
}


#' @rdname group_add_user
#' @description \code{group_disable_user} temporarily disables a user from
#' receiving group notifications. 
#' @export
#' @examples
#' \dontrun{
#' group_disable_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                    user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
group_disable_user <- function(group, user, app = get_pushover_app(),
                               device = NULL, memo = NULL) {
    group_subscription_cmd(cmd = "disable_user", group = group, user = user,
                           token = app, device = device, memo = memo)
}


#' @rdname group_add_user
#' @description \code{group_enable_user} re-enables a user to receive group
#' notifications for a group
#' @export
#' @examples
#' \dontrun{
#' group_enable_user(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'                   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
group_enable_user <- function(group, user, app = get_pushover_app(),
                              device = NULL, memo = NULL) {
    group_subscription_cmd(cmd = "enable_user", group = group, user = user,
                           token = app, device = device, memo = memo)
}
