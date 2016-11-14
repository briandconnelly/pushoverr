#' Get information about a Pushover group
#'
#' @param group group key
#' @param app application token (see \code{\link{set_pushover_app}})
#'
#' @return A list containing information for the given group. Fields include:
#' \itemize{
#'     \item \code{name}: the group's name
#'     \item \code{users}: list containing information about each user in the group
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' get_group_info(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF")
#' }
get_group_info <- function(group, app = get_pushover_app()) {
    query_url <- sprintf("https://api.pushover.net/1/groups/%s.json", group)
    response <- httr::GET(url = query_url, query = list(token = app))
    stop_for_pushover_status(response)

    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")

    rval
}
