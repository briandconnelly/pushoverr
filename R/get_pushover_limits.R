#' Get usage and limit information for Pushover applications
#' 
#' \code{get_pushover_limits} retrieves the message usage and limit information
#' for the given application.
#' 
#' @note This information can alternatively be gotten by examining the headers
#' in the response to previous API calls. Look for headers
#' \code{x-limit-app-limit}, \code{x-limit-app-remaining}, and
#' \code{x-limit-app-reset}. For example, if \code{x} stores the response from a
#' \code{\link{pushover}} call, \code{httr::headers(x$raw)} will return all of
#' the headers included in the response.
#'
#' @param app application token (see \code{\link{set_pushover_app}})
#'
#' @return A list containing messaging usage for the given app. Fields include:
#' \itemize{
#'     \item \code{limit}: Number of messages allowed per month
#'     \item \code{remaining}: Number of remaining messages in current month
#'     \item \code{reset}: Unix timestamp indicating when message count is reset
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' lims <- get_pushover_limits(app = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' }
get_pushover_limits <- function(app = get_pushover_app()) {
    assertthat::assert_that(assertthat::is.scalar(app), is.valid_app(app))
    pushover_api(verb = "GET",
                 url = "https://api.pushover.net/1/apps/limits.json",
                 query = list(token = app))
}
