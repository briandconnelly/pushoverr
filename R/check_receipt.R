# TODO: delete
# Sample receipt "rbf6q3da2hsbm3qunhh6w4u6bfzkvz"
# API Docs: https://pushover.net/api#receipt

#' Check whether an emergency priority message was received
#' 
#' \code{check_receipt} TODO.
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
    assertthat::assert_that(assertthat::is.scalar(receipt))
    # TODO: validate (regexp) receipt?
    
    query_url <- sprintf("https://api.pushover.net/1/receipts/%s.json", receipt)
    response <- httr::GET(url = query_url, query = list(token = app))
    httr::stop_for_status(response)

    rval <- httr::content(response)                                             
    rval$raw <- response                                                        
    class(rval) <- c("pushover", "list")
    rval
}


#' @rdname check_receipt
#' @description \code{is.acknowledged} returns a logical value indicating whether the emergency message was acknowledged (\code{TRUE}) or not (\code{FALSE}).
#' @export
is.acknowledged <- function(receipt, app = get_pushover_app()) {
    assertthat::assert_that(assertthat::is.scalar(receipt))
    rsp <- check_receipt(receipt = receipt, app = app)
    rsp$acknowledged == 1
}
