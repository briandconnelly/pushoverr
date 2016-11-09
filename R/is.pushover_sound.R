#' Test whether the given sound is supported for Pushover messages
#'
#' @param x a string containing a sound name
#'
#' @return A logical value indicating whether the given sound is supported
#' by Pushover (\code{TRUE}) or not (\code{FALSE})
#' @export
#'
#' @examples
#' is.pushover_sound("cosmic")
#'
is.pushover_sound <- function(x) {
    x %in% pushover_sounds
}
