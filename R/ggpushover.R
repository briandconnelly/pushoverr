#' Send a message with an attached plot
#'
#' @description `ggpushover()` sends a \link[ggplot2]{ggplot2} plot and message to your
#' devices as a push notification
#'
#' @param plot Plot to save, defaults to last plot displayed
#' @inheritParams pushover
#' @inheritDotParams pushover
#' @return an invisible list containing the following fields:
#' \itemize{
#'     \item `status`: request status (1 = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#'     \item `receipt`: a receipt ID (only for emergency priority messages)
#'     \item `errors`: a list of error messages (only for unsuccessful requests)
#' }
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' p <- ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point()
#' ggpushover(p, message = "We're gonna need to shed some weight!")
ggpushover <- function(plot = ggplot2::last_plot(),
                       message,
                       ...) {
  check_installed(pkg = "ggplot2")
  checkmate::check_class(plot, "ggplot")

  tmpfile <- tempfile(fileext = ".png")
  ggplot2::ggsave(filename = tmpfile, plot = plot)

  result <- pushover(
    message = message,
    attachment = tmpfile,
    ...
  )

  unlink(tmpfile)
  invisible(result)
}
