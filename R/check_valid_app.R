#' @noRd
#' @rdname check_valid_app
#' @title Validate Pushover app token values
#'
#' @description `check_valid_app()` determines whether or not a given
#' application token is valid or not according to Pushover's specifications. It
#' does not determine whether or not the given token is associated with an
#' application.
#'
#' @param x Value to check
#' @param ... Additional arguments passed to [checkmate::check_string()]
#'
#' @return `check_valid_app()` returns `TRUE` if the given value is a valid
#' Pushover app token or a string containing an error message otherwise
#'
#' @examples
#' check_valid_app("azGDORePK8gMaC0QOYAMyEEuzJnyUi")
check_valid_app <- function(x, ...) {
  checkmate::check_string(
    x,
    min.chars = 30,
    pattern = "^[a-zA-Z0-9]{30}$",
    ...
  )
}


#' @noRd
#' @rdname check_valid_app
#' @return `test_valid_app()` returns a logical value indicating whether the
#' given value is a valid Pushover app token
#' @examples
#' test_valid_app("azGDORePK8gMaC0QOYAMyEEuzJnyUi")
test_valid_app <- checkmate::makeTestFunction(check_valid_app)


#' @noRd
#' @rdname check_valid_app
#' @return `assert_valid_app()` returns `x`, invisibly if successful. Otherwise
#' an error is raised.
#' @examples
#' assert_valid_app("my_app")
assert_valid_app <- checkmate::makeAssertionFunction(check_valid_app)
