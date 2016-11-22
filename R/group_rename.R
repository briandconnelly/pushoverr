#' Rename a delivery group
#'
#' @param group group key
#' @param name new group name
#' @param app application token (see \code{\link{set_pushover_app}})
#'
#' @return An invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' \dontrun{
#' group_rename(group = "gznej3rKEVAvPUxu9vvNnqpmZpokzF",
#'              name = "Coffee Party")
#' }
group_rename <- function(group, name, app = get_pushover_app()) {
    assertthat::assert_that(assertthat::is.scalar(group), is.valid_group(group))
    assertthat::assert_that(assertthat::is.scalar(name), is.character(name))
    assertthat::assert_that(assertthat::is.scalar(app), is.valid_app(app))

    query_url <- sprintf("https://api.pushover.net/1/groups/%s/rename.json",
                         group)

    pushover_api(verb = "POST", url = query_url, visible = FALSE,
                 body = list("token" = app, "name" = name))
}
