#' Issue a command using the Pushover API
#'
#' `pushover_api()` allows commands to be issued using the Pushover API.
#' This is a generic function that is meant to be used by higher level
#' functions. In most instances, more specific functions should be used (e.g.,
#' [`pushover()`]).
#'
#' @inheritParams httr::VERB
#' @inheritDotParams httr::VERB
#'
#' @return a list containing the following fields and any other fields related
#' to the specific API call:
#' \itemize{
#'     \item `status`: request status (`1` = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
#' }
#' @export
#' @examples
#' \dontrun{
#' pushover_api(
#'   verb = "GET",
#'   url = "https://api.pushover.net/1/sounds.json",
#'   query = list(token = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' )
#' }
pushover_api <- function(verb, url, ...) {
  response <- httr::VERB(verb = verb, url = url, ...)
  stop_for_pushover_status(response)

  rval <- httr::content(response)
  rval$raw <- response
  class(rval) <- c("pushover", "list")

  rval
}

#' @noRd
#' @description `stop_for_pushover_status()` examines a response from a Pushover
#' API call for errors. If there were errors, execution is stopped, and an error
#' message is shown.
#' @param x an [httr::response] object returned by an API call
#' @return `x` (invisibly) if successful
stop_for_pushover_status <- function(x) {
  code <- httr::status_code(x)
  response <- httr::content(x)

  if (response$status == 1 && floor(code / 100) == 2) {
    return(invisible(x))
  } else {
    cli::cli_abort("{httr::http_status(code)$message} - {paste0(response$errors, collapse = '; ')}")
  }
}
