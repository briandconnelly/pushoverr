#' Cancel retries for an emergency priority notification
#'
#' \code{cancel_retries} stops Pushover from sending repeat messages for
#' un-acknowledged emergency priority notifications.
#'
#' @param receipt The receipt from sending an emergency message
#' @param app application token (see \code{\link{set_pushover_app}})
#'
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' msg1 <- pushover_emergency(message = "Test emergency message")
#' cancel_retries(receipt = msg1$receipt)
#' }
cancel_retries <- function(receipt, app = get_pushover_app()) {
    assertthat::assert_that(assertthat::is.scalar(receipt),
                            is.valid_receipt(receipt))

    query_url <- sprintf("https://api.pushover.net/1/receipts/%s/cancel.json",
                         receipt)
    pushover_api(verb = "POST", url = query_url, visible = FALSE,
                 body = list("token" = app))

}

#' @rdname cancel_retries
#' @description \code{cancel_receipt} is deprecated in favor of \code{cancel_retries}
#' @param ... Additional arguments (no longer used)
#' @export
cancel_receipt <- function(receipt, ...) {
    message("cancel_receipt() is deprecated. Please use cancel_retries() instead.")
    assertthat::assert_that(is.valid_receipt(receipt))

    opt_args <- list(...)
    app <- ifelse("token" %in% names(opt_args),
                  opt_args[["token"]],
                  get_pushover_app())

    cancel_retries(receipt = receipt, app = app)
}
