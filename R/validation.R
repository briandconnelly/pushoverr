#' @rdname validation
#' @title Validate Pushover values
#'
#' @description `is.valid_app()` determines whether or not a given application
#' token is valid or not according to Pushover's specifications. It does not
#' determine whether or not the given token is associated with an application.
#'
#' @note To acquire an application token, create an app at
#' <https://pushover.net/apps>
#'
#' @param token A application token (e.g., `"azGDORePK8gMaC0QOYAMyEEuzJnyUi"`)
#' @return A logical value indicating whether or not the application token is
#' valid
#'
#' @export
#' @examples
#' is.valid_app(token = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
is.valid_app <- function(token) {
  grepl("^[a-zA-Z0-9]{30}$", token)
}

assertthat::on_failure(is.valid_app) <- function(call, env) {
  "Invalid Pushover application token. Tokens are 30 characters long and contain letters and numbers (e.g., 'azGDORePK8gMaC0QOYAMyEEuzJnyUi')."
}

#' @rdname validation
#'
#' @description `is.valid_device()` only determines whether a device name is
#' valid. Valid device names are strings up to 25 characters long and can
#' include letters, numbers, _, and -. It does not determine whether that device
#' is actually registered (see: [`is.device()`].
#'
#' @param device one or more device names (e.g., `"phone"`,
#' `c("phone", "tablet")`)
#'
#' @return `is.valid_device()` returns logical a value indicating whether or not
#' the corresponding device name is valid
#' @export
#'
#' @examples
#' is.valid_device("my_phone")
is.valid_device <- function(device) {
  grepl("^[a-zA-Z0-9_-]{1,25}$", device)
}

assertthat::on_failure(is.valid_device) <- function(call, env) {
  "Invalid Pushover devnice name. Valid names contain up to 25 characters, including letters, numbers, _, and -."
}


#' @rdname validation
#' @description `is.valid_receipt()` determines whether or not a given message
#' receipt is valid or not according to Pushover's specifications. It does not
#' determine whether or not the given receipt actually exists. Receipts are
#' 30-character strings containing letters and numbers (\[A-Za-z0-9\]).
#'
#' @export
#' @param receipt A message receipt (e.g., `"KAWXTswy4cekx6vZbHBKbCKk1c1fdf"`)
#' @return `is.valid_receipt()` returns a boolean value for each given message
#' receipt ID indicating whether or not that receipt ID is valid.
#' @examples
#' \dontrun{
#' is.valid_receipt(receipt = "KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
#' }
#'
is.valid_receipt <- function(receipt) {
  grepl("^[a-zA-Z0-9]{30}$", receipt)
}

assertthat::on_failure(is.valid_receipt) <- function(call, env) {
  "Invalid Pushover message receipt. Receipts are 30-character strings containing letters and numbers."
}


#' @rdname validation
#' 
#' @description `is.valid_user()` and `is.valid_group()` determine whether
#' or not a given user/group key is valid. They do not determine whether or not
#' the key is registered with Pushover.
#'
#' @param user user/group key to verify (e.g., `"uQiRzpo4DXghDmr9QzzfQu27cmVRsG"`)
#' @param group user/group key to verify (e.g., `"gznej3rKEVAvPUxu9vvNnqpmZpokzF"`)
#'
#' @return A logical value indicating whether or not the given user/group key is
#' valid.
#' @seealso [`verify_user()`] and [`verify_group()`] determine whether or not
#' the given user key is registered with Pushover
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
  "Invalid Pushover user/group key. Keys are 30 characters long and contain letters and numbers (e.g., 'uQiRzpo4DXghDmr9QzzfQu27cmVRsG')."
}


#' @rdname validation
#' @export
is.valid_group <- function(group) {
  grepl("^[a-zA-Z0-9]{30}$", group)
}

assertthat::on_failure(is.valid_group) <- function(call, env) {
  "Invalid Pushover user/group key. Keys are 30 characters long and contain letters and numbers (e.g., 'gznej3rKEVAvPUxu9vvNnqpmZpokzF')."
}