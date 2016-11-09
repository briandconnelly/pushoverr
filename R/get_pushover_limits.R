#' Get usage and limit information for Pushover applications
#' 
#' \code{get_pushover_limits} retrieves the message usage and limit information
#' for the given application.
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
    response <- httr::GET(url = "https://api.pushover.net/1/apps/limits.json",
                          query = list(token = app))
    httr::stop_for_status(response)
    
    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")
    
    rval
}
