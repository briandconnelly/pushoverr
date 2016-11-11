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

assertthat::on_failure(is.pushover_sound) <- function(call, env) {
    "Sound not supported by Pushover"
}

pushover_sounds <- c("bike", "bugle", "cashregister", "classical", "cosmic",
                     "falling", "gamelan", "incoming", "intermission", "magic",
                     "mechanical", "pianobar", "siren", "spacealarm",
                     "tugboat", "alien", "climb", "persistent", "echo",
                     "updown", "pushover", "none")
