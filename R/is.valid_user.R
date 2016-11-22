#' Determine whether a user or group key is valid
#'
#' @description \code{is.valid_user} and \code{is.valid_group} determine whether
#' or not a given user/group key is valid. They do not determine whether or not
#' the key is registered with Pushover.
#'
#' @param user user/group key to verify (e.g., "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' @param group user/group key to verify (e.g., "gznej3rKEVAvPUxu9vvNnqpmZpokzF")
#'
#' @return A logical value indicating whether (\code{TRUE}) or not
#' (\code{FALSE}) the given user/group key is valid.
#' @seealso \code{\link{verify_user}} and \code{\link{verify_group}} determine
#' whether or not the given user key is registered with Pushover
#' @export
#'
#' @examples
#' \dontrun{
#' is.valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
is.valid_user <- function(user) {
    grepl("^[a-zA-Z0-9]{30}$", user)
}

assertthat::on_failure(is.valid_user) <- function(call, env) {
    "Invalid Pushover user/group key. Keys are 30 characters long and contain letters and numbers (e.g., uQiRzpo4DXghDmr9QzzfQu27cmVRsG)."
}


#' @rdname is.valid_user
#' @description \code{is.valid_group} is an alias for \code{is.valid_user}
#' @export
is.valid_group <- function(group) {
    grepl("^[a-zA-Z0-9]{30}$", group)
}

assertthat::on_failure(is.valid_group) <- function(call, env) {
    "Invalid Pushover user/group key. Keys are 30 characters long and contain letters and numbers (e.g., gznej3rKEVAvPUxu9vvNnqpmZpokzF)."
}
