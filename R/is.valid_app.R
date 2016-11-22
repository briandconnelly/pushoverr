#' Determine whether or not a given application token is valid
#'
#' \code{is.valid_app} determines whether or not a given application token
#' is valid or not according to Pushover's specifications. It does not determine
#' whether or not the given token is associated with an application.
#' 
#' @note To acquire an application token, create an app at
#' \url{https://pushover.net/apps}
#'
#' @param token A application token (e.g., "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' @return A logical value indicating whether the application token is valid
#' (\code{TRUE}) or not (\code{FALSE})
#'
#' @export
#' @examples
#' is.valid_app(token = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' 
is.valid_app <- function(token) {
    grepl("^[a-zA-Z0-9]{30}$", token)
}

assertthat::on_failure(is.valid_app) <- function(call, env) {
    "Invalid Pushover application token. Tokens are 30 characters long and contain letters and numbers (e.g., azGDORePK8gMaC0QOYAMyEEuzJnyUi)."
}


#' @rdname is.valid_app
#' @description \code{is.valid_token} is deprecated in favor of \code{is.valid_app}
#' @export
is.valid_token <- function(token) {
    message("is.valid_token() is deprecated. Please use is.valid_app() instead.")
    is.valid_app(token)
}
