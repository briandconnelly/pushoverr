#' Determine whether or not a given message receipt is valid
#'
#' \code{is.valid_receipt} determines whether or not a given message receipt
#' is valid or not according to Pushover's specifications. It does not determine
#' whether or not the given receipt actually exists.
#' 
#' @description Receipts are 30-character strings containing letters and
#' numbers ([A-Za-z0-9])
#'
#' @export
#' @param receipt A message receipt (e.g., "KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
#' @return A boolean value for each given message receipt ID indicating whether
#' that receipt ID is valid (\code{TRUE}) or not (\code{FALSE})
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
