#' @rdname validation
#' @title Validate Pushover values
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
