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
    params <- list("token" = app, "name" = name)

    query_url <- sprintf("https://api.pushover.net/1/groups/%s/rename.json",
                         group)
    response <- httr::POST(query_url, body = params)
    stop_for_pushover_status(response)

    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")

    invisible(rval)
}
