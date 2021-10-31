#' Rename a delivery group
#'
#' @param group group key
#' @param name new group name
#' @param app application token (see [`set_pushover_app()`])
#'
#' @return An invisible list containing the following fields:
#' \itemize{
#'     \item `status`: request status (`1` = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' group_rename(
#'   group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'   name = "Coffee Party"
#' )
#' }
group_rename <- function(group, name, app = get_pushover_app()) {
  assert_valid_group(group)
  checkmate::assert_string(name)
  assert_valid_app(app)

  invisible(
    pushover_api(
      verb = "POST",
      url = glue("https://api.pushover.net/1/groups/{group}/rename.json"),
      body = list("token" = app, "name" = name)
    )
  )
}
