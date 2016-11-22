#' Issue a command using the Pushover API
#' 
#' \code{pushover_api} allows commands to be issued using the Pushover API.
#' This is a generic function that is meant to be used by higher level
#' functions. In most instances, more specific functions should be used (e.g.,
#' \code{\link{pushover}}). 
#'
#' @param verb The http method to use
#' @param url The URL to visit
#' @param visible Whether or not the result should be visible (default: \code{TRUE})
#' @param ... Any additional parameters to be passed to \code{\link[httr]{VERB}}
#'
#' @return a list containing the following fields and any other fields related
#' to the specific API call:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
#' }
#' @export
#' @examples
#' \dontrun{
#' pushover_api(verb = "GET",
#'              url = "https://api.pushover.net/1/sounds.json",
#'              query = list(token = "azGDORePK8gMaC0QOYAMyEEuzJnyUi"))
#' }
pushover_api <- function(verb, url, visible = TRUE, ...) {
    response <- httr::VERB(verb = verb, url = url, ...)
    stop_for_pushover_status(response)

    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")

    if (visible) rval
    else invisible(rval)
}
