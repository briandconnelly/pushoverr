#' Set, get, and unset the Pushover user/group key
#'
#' `set_pushover_user()` sets the Pushover user or group key to be used in
#' subsequent commands, `get_pushover_user()` gets the user or group key
#' that is currently set, and `unset_pushover_user()` unsets the key.
#'
#' `set_pushover_group()`, `get_pushover_group()`, and
#' `unset_pushover_group()` are aliases for these functions.
#'
#' `set_pushover_user()` only sets the Pushover user or group for the current
#' session. If a different value is specified in `.Renviron`, that value will be
#' used in future sessions. Similarly, `unset_pushover_user()` will only
#' unset the user or group for the current session.
#'
#' @details User keys can be found within the settings of the Pushover app or
#' by logging in to <https://pushover.net>. Group keys can be found after
#' creating a delivery group in your account on <https://pushover.net>.
#'
#' @param user The user or group key to be used. If none is provided, a prompt
#' will request the key.
#' @param ask Whether or not to ask for the key if none is provided. Note that
#' this only works for interactive sessions.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' set_pushover_user(user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#' }
set_pushover_user <- function(user = NULL, ask = is_interactive()) {
  if (is.null(user)) {
    if (ask && is_interactive()) {
      cli::cli_alert_info("{.envvar PUSHOVER_USER} is not set, and user/group key not provided (see {.code ?pushoverr} for details)")
      in_user <- readline("Please enter your user/group key: ")
      Sys.setenv("PUSHOVER_USER" = in_user)
    } else {
      cli::cli_abort("Set Pushover user key by providing value for argument {.arg user} or setting {.envvar PUSHOVER_USER}. See {.code pushoverr} for details.")
    }
  } else {
    if (identical(Sys.getenv("PUSHOVER_USER"), user)) {
      cli::cli_alert_info("Pushover user was already set to {.code {user}}")
    }
    Sys.setenv("PUSHOVER_USER" = user)
  }
}


#' @rdname set_pushover_user
#' @return `get_pushover_user()` returns a string containing the current
#' user or group key or an empty string if not set. If the user is not set but
#' `ask` is `TRUE`, the user will be prompted for a key.
#' @export
get_pushover_user <- function(ask = is_interactive()) {
  if (!pushover_user.isset()) {
    set_pushover_user(ask = ask)
  }

  Sys.getenv("PUSHOVER_USER")
}


#' @rdname set_pushover_user
#' @export
unset_pushover_user <- function() {
  if (!pushover_user.isset()) {
    cli::cli_alert_info("{.envvar PUSHOVER_USER} is not set")
  }
  Sys.unsetenv("PUSHOVER_USER")
}


#' @noRd
#' @rdname set_pushover_user
#' @return `pushover_user.isset()` returns a logical value indicating whether
#' or not the user/group is set.
pushover_user.isset <- function() {
  !is.na(Sys.getenv("PUSHOVER_USER", NA_character_))
}


#' @rdname set_pushover_user
#' @export
set_pushover_group <- set_pushover_user


#' @rdname set_pushover_user
#' @export
get_pushover_group <- get_pushover_user


#' @rdname set_pushover_user
#' @export
unset_pushover_group <- unset_pushover_user
