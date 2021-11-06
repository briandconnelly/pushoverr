#' Check whether an emergency priority message was received
#'
#' `check_receipt()` checks the status of an emergency priority message,
#' receiving information about whether and by whom it was acknowledged,
#' when the message was last delivered, whether a callback URL was visited,
#' and more.
#'
#' @param receipt receipt ID from sending an emergency message
#' @param app application token (see [`set_pushover_app()`])
#'
#' @return a list containing the following fields:
#' \itemize{
#'     \item `status`: request status (`1` = success)
#'     \item `acknowledged`: number indicating whether (`1`) or not (`0`)
#'     notification has been acknowledged
#'     \item `acknowledged_at`: Unix timestamp indicating when notification was
#'     acknowledged, or 0
#'     \item `acknowledged_by`: key of the user who first acknowledged the
#'     notification, or `""`
#'     \item `acknowledged_by_device`: name of the device on which the first
#'     user acknowledged the notification
#'     \item `last_delivered_at`: Unix timestamp of when the notification was
#'     last acknowledged, or `0`
#'     \item `expired`: whether (`1`) or not (`0`) the notification has expired
#'     \item `expires_at`: Unix timestamp indicating when the notification will
#'     no longer be retried
#'     \item `called_back`: whether (`1`) or not (`0`) the callback URL has been
#'     visited
#'     \item `called_back_at`: Unix timestamp indicating when the callback URL
#'     was visited
#'     \item `request`: unique request ID
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
#'     \item `raw`: the raw [httr::response] object
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
  assert_valid_receipt(receipt)
  assert_valid_app(app)

  pushover_api(
    verb = "GET",
    url = glue("https://api.pushover.net/1/receipts/{receipt}.json"),
    query = list(token = app)
  )
}


#' @rdname check_receipt
#' @description `is.acknowledged()` returns a logical value indicating whether
#' or not the emergency message was acknowledged.
#' @export
is.acknowledged <- function(receipt, app = get_pushover_app()) {
  rsp <- check_receipt(receipt = receipt, app = app)
  rsp$acknowledged == 1
}
