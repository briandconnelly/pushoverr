#' Determine whether or not a given device name is valid
#' 
#' Valid device names are strings up to 25 characters long and can include
#' letters, numbers, _, and -.
#' 
#' @note \code{is.valid_device} only determines whether a device name is valid.
#' It does not determine whether that device is actually registered (see:
#' \code{\link{is.device}}).
#'
#' @param device one or more device names (e.g., "phone", c("phone", "tablet"))
#'
#' @return Logical value(s) indicating whether the corresponding device name is
#' valid (\code{TRUE}) or not (\code{FALSE})
#' @export
#'
#' @examples
#' is.valid_device("my_phone")
#'
is.valid_device <- function(device) {
    grepl("^[a-zA-Z0-9_-]{1,25}$", device)
}

assertthat::on_failure(is.valid_device) <- function(call, env) {
    "Invalid Pushover devnice name. Valid names contain up to 25 characters, including letters, numbers, _, and -."
}
