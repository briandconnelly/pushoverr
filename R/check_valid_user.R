#' @noRd
#' @rdname check_valid_user
#' @title Validate Pushover user and group values
#'
#' @description `check_valid_user()` and `check_valid_group()` determine whether
#' or not a given user/group key is valid. They do not determine whether or not
#' the key is registered with Pushover.
#'
#' @seealso [`verify_user()`] and [`verify_group()`] determine whether or not
#' the given user/group key is registered with Pushover
#'
#' @param x Value to check
#' @param ... Additional arguments passed to [checkmate::check_string()]
#'
#' @return `check_valid_user()` returns `TRUE` if the given value is a valid
#' Pushover receipt ID or a string containing an error message otherwise.
#'
#' @examples
#' check_valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
check_valid_user <- function(x, ...) {
  checkmate::check_string(
    x,
    min.chars = 30,
    pattern = "^[a-zA-Z0-9]{30}$",
    ...
  )
}


#' @noRd
#' @rdname check_valid_user
#' @examples
#' check_valid_user("gznej3rKEVAvPUxu9vvNnqpmZpokzF")
check_valid_group <- check_valid_user


#' @noRd
#' @rdname check_valid_user
#' @return `test_valid_user()` and `test_valid_group()` return a logical value
#' indicating whether the given value is a valid user/group key.
#' @examples
#' test_valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
test_valid_user <- checkmate::makeTestFunction(check_valid_user)


#' @noRd
#' @rdname check_valid_user
#' @examples
#' test_valid_group("gznej3rKEVAvPUxu9vvNnqpmZpokzF")
test_valid_group <- test_valid_user


#' @noRd
#' @rdname check_valid_user
#' @return `assert_valid_user()` returns `x`, invisibly if successful.
#' Otherwise an error is raised.
#' @examples
#' assert_valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
assert_valid_user <- checkmate::makeAssertionFunction(check_valid_user)

assert_valid_group <- assert_valid_user
