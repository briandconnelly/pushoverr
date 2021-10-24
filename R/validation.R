#' @rdname validation
#' @title Validate Pushover values
#' 
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
  grepl("^[a-zA-Z0-9]{30}$", receipt %||% "")
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
  grepl("^[a-zA-Z0-9]{30}$", user %||% "")
}

assertthat::on_failure(is.valid_user) <- function(call, env) {
  "Invalid Pushover user/group key. Keys are 30 characters long and contain letters and numbers (e.g., 'uQiRzpo4DXghDmr9QzzfQu27cmVRsG')."
}


#' @rdname validation
#' @export
is.valid_group <- function(group) {
  grepl("^[a-zA-Z0-9]{30}$", group %||% "")
}

assertthat::on_failure(is.valid_group) <- function(call, env) {
  "Invalid Pushover user/group key. Keys are 30 characters long and contain letters and numbers (e.g., 'gznej3rKEVAvPUxu9vvNnqpmZpokzF')."
}


#' @rdname validation
#'
#' @description `is.valid_sound()` checks whether or not a given sound is
#' supported by Pushover. See <https://pushover.net/api#sounds> for a complete
#' list.
#' @param sound a string containing a sound name
#'
#' @return `is.valid_sound()` returns a logical value indicating whether or not
#' the given sound is supported by Pushover.
#' @export
#'
#' @examples
#' is.valid_sound("cosmic")
is.valid_sound <- function(sound) {
  (sound %||% "nosound") %in% pushover_sounds
}

assertthat::on_failure(is.valid_sound) <- function(call, env) {
  "Sound not supported by Pushover"
}
