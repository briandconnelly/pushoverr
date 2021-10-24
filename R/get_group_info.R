#' Get information about a Pushover group
#'
#' @param group group key
#' @param app application token (see [`set_pushover_app()`])
#'
#' @return A list containing information for the given group. Fields include:
#' \itemize{
#'     \item `name`: the group's name
#'     \item `users`: list containing information about each user in the group
#'     \item `status`: request status (`1` = success)
#'     \item `request`: unique request ID
#'     \item `raw`: the raw [httr::response] object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' get_group_info(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF")
#' }
get_group_info <- function(group, app = get_pushover_app()) {
  assert_valid_group(group)

  pushover_api(
    verb = "GET",
    url = glue("https://api.pushover.net/1/groups/{group}.json"),
    query = list(token = app)
  )
}
