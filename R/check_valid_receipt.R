#' @noRd
#' @rdname check_valid_receipt
#' @title Validate Pushover receipt ID values
#'
#' @description `check_valid_receipt()` determines whether or not a given
#' message receipt is valid or not according to Pushover's specifications. It
#' does not determine whether or not the given receipt actually exists. Receipts
#' are 30-character strings containing letters and numbers (\[A-Za-z0-9\]).
#'
#' @param x Value to check
#' @param ... Additional arguments passed to [checkmate::check_string()]
#'
#' @return `check_valid_receipt()` returns `TRUE` if the given value is a valid
#' Pushover receipt ID or a string containing an error message otherwise.
#'
#' @examples
#' check_valid_receipt("KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
check_valid_receipt <- function(x, ...) {
  checkmate::check_string(
    x,
    min.chars = 30,
    pattern = "^[a-zA-Z0-9]{30}$",
    ...
  )
}


#' @noRd
#' @rdname check_valid_receipt
#' @return `test_valid_receipt()` returns a logical value indicating whether the
#' given value is a valid Pushover receipt ID.
#' @examples
#' test_valid_receipt("KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
test_valid_receipt <- checkmate::makeTestFunction(check_valid_receipt)


#' @noRd
#' @rdname check_valid_receipt
#' @return `assert_valid_receipt()` returns `x`, invisibly if successful.
#' Otherwise an error is raised.
#' @examples
#' assert_valid_receipt("KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
assert_valid_receipt <- checkmate::makeAssertionFunction(check_valid_receipt)
