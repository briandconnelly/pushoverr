#' Cancel retries for an emergency priority notification
#'
#' `cancel_retries()` stops Pushover from sending repeat messages for
#' un-acknowledged emergency priority notifications.
#'
#' @param receipt The receipt from sending an emergency message
#' @param app application token (see [`set_pushover_app()`])
#'
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item `status`: request status (1 = success)
#'     \item `request`: unique request ID
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
#'     \item `raw`: the raw [httr::response] object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' msg1 <- pushover_emergency(message = "Test emergency message")
#' cancel_retries(receipt = msg1$receipt)
#' }
cancel_retries <- function(receipt, app = get_pushover_app()) {
  assert_valid_receipt(receipt)
  assert_valid_app(app)

  invisible(
    pushover_api(
      verb = "POST",
      url = glue("https://api.pushover.net/1/receipts/{receipt}/cancel.json"),
      body = list("token" = app)
    )
  )
}
