#' Set, get, and unset the Pushover application token
#'
#' `set_pushover_app()` sets the Pushover application token to be used in
#' subsequent commands, `get_pushover_app()` gets the application token
#' that is currently set, and `unset_pushover_app()` unsets the token.
#'
#' `set_pushover_app()` only sets the Pushover app token for the current
#' session. If a different value is specified in `.Renviron`, that value will be
#' used in future sessions. Similarly, `unset_pushover_app()` will only
#' unset the app token for the current session.
#'
#' @details To receive an application token, register a new application after
#' logging in to your account at <https://pushover.net/apps>.
#'
#' @param token The application token to be used. If none is provided, a prompt
#' will request the token (interactive sessions only).
#' @param ask Whether or not to ask for the token if none is provided. Note
#' that this option only works in interactive sessions.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' set_pushover_app(token = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' }
set_pushover_app <- function(token = NULL, ask = is_interactive()) {
  if (is.null(token)) {
    if (ask && is_interactive()) {
      cli::cli_alert_info("{.envvar PUSHOVER_APP} is not set, and application token not provided (see {.code ?pushoverr} for details)")
      in_token <- readline("Please enter your application token: ")
      Sys.setenv("PUSHOVER_APP" = in_token)
    } else {
      cli::cli_abort("Set Pushover application token by providing value for argument {.arg app} or setting {.envvar PUSHOVER_APP}. See {.code pushoverr} for details.")
    }
  } else {
    if (identical(Sys.getenv("PUSHOVER_APP"), token)) {
      cli::cli_alert_info("Pushover app was already set to {.code {token}}")
    }
    Sys.setenv("PUSHOVER_APP" = token)
  }
}


#' @rdname set_pushover_app
#' @return `get_pushover_app()` returns a string containing the current
#' application token. If the token is not set but `ask` is `TRUE`,
#' the user will be prompted for a token.
#' @export
get_pushover_app <- function(ask = is_interactive()) {
  if (!pushover_app.isset()) {
    set_pushover_app(ask = ask)
  }

  Sys.getenv("PUSHOVER_APP")
}


#' @rdname set_pushover_app
#' @export
unset_pushover_app <- function() {
  if (!pushover_app.isset()) {
    cli::cli_alert_info("{.envvar PUSHOVER_APP} is not set")
  }
  Sys.unsetenv("PUSHOVER_APP")
}


#' @noRd
#' @rdname set_pushover_app
#' @return `pushover_user.isset()` returns a logical value indicating whether
#' or not the application token is set.
pushover_app.isset <- function() {
  !is.na(Sys.getenv("PUSHOVER_APP", NA_character_))
}
