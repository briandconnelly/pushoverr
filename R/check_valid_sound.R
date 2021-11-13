#' @noRd
#' @rdname check_valid_sound
#' @title Validate Pushover sound values
#'
#' @description `check_valid_sound()` checks whether or not a given sound is
#' supported by Pushover. See `pushover_sounds` or
#' <https://pushover.net/api#sounds> for a complete list.
#'
#' @param x Value to check
#' @param ... Additional arguments passed to [checkmate::check_choice()]
#'
#' @return `check_valid_sound()` returns `TRUE` if the given value is a valid
#' Pushover sound or a string containing an error message otherwise.
#'
#' @examples
#' check_valid_sound("cosmic")
check_valid_sound <- function(x, ...) {
  checkmate::check_choice(x, choices = pushover_sounds, ...)
}


#' @noRd
#' @rdname check_valid_sound
#' @return `test_valid_sound()` returns a logical value indicating whether the
#' given value is a valid Pushover sound.
#' @examples
#' test_valid_sound("cashregister")
test_valid_sound <- checkmate::makeTestFunction(check_valid_sound)


#' @noRd
#' @rdname check_valid_sound
#' @return `assert_valid_sound()` returns `x`, invisibly if successful.
#' Otherwise an error is raised.
#' @examples
#' assert_valid_sound("spacealarm")
assert_valid_sound <- checkmate::makeAssertionFunction(check_valid_sound)
