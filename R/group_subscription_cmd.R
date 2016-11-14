#' Manage group subscriptions
#' 
#' \code{group_subscription_cmd} supports functions for managing a group's
#' subscribers. For the most part, you'll want to use
#' \code{\link{group_add_user}}, \code{\link{group_delete_user}},
#' \code{\link{group_enable_user}}, or \code{\link{group_disable_user}}.
#'
#' @param cmd The group subscription command to execute
#' @param ... Specific arguments for the given group subscription command
#'
#' @return An invisible list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{request}: unique request ID
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
group_subscription_cmd <- function(cmd, ...) {
    opt_args <- list(...)

    query_url <- sprintf("https://api.pushover.net/1/groups/%s/%s.json",
                         opt_args$group, cmd)

    response <- httr::POST(url = query_url, body = opt_args)
    stop_for_pushover_status(response)

    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")

    invisible(rval)
}
