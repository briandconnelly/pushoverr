#' Get usage and limit information for Pushover applications
#'
#' `get_pushover_limits()` retrieves the message usage and limit information
#' for the given application.
#'
#' @note This information can alternatively be gotten by examining the headers
#' in the response to previous API calls. Look for headers
#' `x-limit-app-limit`, `x-limit-app-remaining`, and
#' `x-limit-app-reset`. For example, if `x` stores the response from a
#' [`pushover()`] call, `httr::headers(x$raw)` will return all of
#' the headers included in the response.
#'
#' @param app application token (see [`set_pushover_app()`])
#'
#' @return A list containing messaging usage for the given app. Fields include:
#' \itemize{
#'     \item `limit`: Number of messages allowed per month
#'     \item `remaining`: Number of remaining messages in current month
#'     \item `reset`: Unix timestamp indicating when message count is reset
#'     \item `status}: request status (`1` = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' lims <- get_pushover_limits(app = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' }
get_pushover_limits <- function(app = get_pushover_app()) {
  pushover_api(
    verb = "GET",
    url = "https://api.pushover.net/1/apps/limits.json",
    query = list(token = assert_valid_app(app))
  )
}
