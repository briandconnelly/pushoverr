#' @noRd
#' @rdname check_valid_device
#' @title Validate Pushover device name values
#'
#' @description `check_valid_device()` determines whether a device name is
#' valid. Valid device names are strings up to 25 characters long and can
#' include letters, numbers, _, and -. It does not determine whether that device
#' is actually registered (see: [`is.registered_device()`].
#'
#' @param x Value to check
#' @param ... Additional arguments passed to [checkmate::check_string()]
#'
#' @return `check_valid_device()` returns `TRUE` if the given value is a valid
#' Pushover device name or a string containing an error message otherwise
#'
#' @examples
#' check_valid_device("phone")
check_valid_device <- function(x, ...) {
  res <- checkmate::check_string(
    x,
    min.chars = 1,
    ...
  )

  if (!isTRUE(res)) {
    res
  } else if (nchar(x) > 25) {
    "Must have fewer than 26 characters"
  } else {
    TRUE
  }
}


#' @noRd
#' @rdname check_valid_device
#' @return `test_valid_device()` returns a logical value indicating whether the
#' given value is a valid Pushover device name.
#' @examples
#' test_valid_device("tablet")
test_valid_device <- checkmate::makeTestFunction(check_valid_device)


#' @noRd
#' @rdname check_valid_device
#' @return `assert_valid_device()` returns `x`, invisibly if successful.
#' Otherwise an error is raised.
#' @examples
#' assert_valid_device("phone")
assert_valid_device <- checkmate::makeAssertionFunction(check_valid_device)
