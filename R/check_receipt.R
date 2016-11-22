#' Check whether an emergency priority message was received
#'
#' \code{check_receipt} checks the status of an emergency priority message,
#' receiving information about whether and by whom it was acknowledged,
#' when the message was last delivered, whether a callback URL was visited,
#' and more.
#'
#' @param receipt receipt ID from sending an emergency message
#' @param app application token (see \code{\link{set_pushover_app}})
#'
#' @return a list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{acknowledged}: number indicating whether (\code{1}) or not (\code{0}) notification has been acknowledged
#'     \item \code{acknowledged_at}: Unix timestamp indicating when notification was acknowledged, or 0
#'     \item \code{acknowledged_by}: key of the user who first acknowledged the notification, or ""
#'     \item \code{acknowledged_by_device}: name of the device on which the first user acknowledged the notification
#'     \item \code{last_delivered_at}: Unix timestamp of when the notification was last acknowledged, or 0
#'     \item \code{expired}: whether (\code{1}) or not (\code{0}) the notification has expired
#'     \item \code{expires_at}: Unix timestamp indicating when the notificaion will no longer be retried
#'     \item \code{called_back}: whether (\code{1}) or not (\code{0}) the callback URL has been visited
#'     \item \code{called_back_at}: Unix timestamp indicating when the callback URL was visited
#'     \item \code{request}: unique request ID
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' msg1 <- pushover_emergency(message = "Test emergency message")
#' check_recepit(receipt = msg1$receipt)
#' is.acknowledged(receipt = msg1$receipt)
#' }
check_receipt <- function(receipt, app = get_pushover_app()) {
    assertthat::assert_that(assertthat::is.scalar(receipt),
                            is.valid_receipt(receipt = receipt))

    query_url <- sprintf("https://api.pushover.net/1/receipts/%s.json", receipt)
    pushover_api(verb = "GET", url = query_url, query = list(token = app))
}


#' @rdname check_receipt
#' @description \code{is.acknowledged} returns a logical value indicating whether the emergency message was acknowledged (\code{TRUE}) or not (\code{FALSE}).
#' @export
is.acknowledged <- function(receipt, app = get_pushover_app()) {
    rsp <- check_receipt(receipt = receipt, app = app)
    rsp$acknowledged == 1
}
