#' Determine whether or not a given user/group key is valid
#' 
#' \code{validate_user} determines whether or not the given user or group is
#' valid (i.e., an actual user or group). \code{validate_group} is an alias.
#' 
#' \code{validate_token} is deprecated in favor of \code{validate_user}, and
#' \code{is.valid_key} is deprecated in favor of \code{is.valid_user}.
#'
#' @param user user/group key to validate
#' @param app application token (see \code{\link{set_pushover_app}})
#' @param device (optional) device to validate. If supplied the device must be registered to the given user's account.
#'
#' @return a list containing the following fields:
#' \itemize{
#'     \item \code{status}: request status (1 = success)
#'     \item \code{devices}: a list of the user's devices
#'     \item \code{request}: unique request ID
#'     \item \code{errors}: a list of error messages (only for unsuccessful requests)
#'     \item \code{raw}: the raw \code{\link[httr]{response}} object
#' }
#' @export
#'
#' @examples
#' validate_user(user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
#'
validate_user <- function(user, app = get_pushover_app(), device = NULL) {
    assertthat::assert_that(assertthat::is.scalar(user))
    assertthat::assert_that(assertthat::is.scalar(app))

    params <- list("token" = app, "user" = user)
    if (!is.null(device)) {
        assertthat::assert_that(assertthat::is.scalar(device))
        params$device <- device
    }

    response <- httr::POST(url = "https://api.pushover.net/1/users/validate.json",
                           body = params)
    httr::stop_for_status(response)

    # TODO: check the status of the response, handle errors appropriately.
    
    rval <- httr::content(response)
    rval$raw <- response
    class(rval) <- c("pushover", "list")
    
    rval
}


#' @rdname validate_user
#' @export
validate_group <- validate_user


#' @rdname validate_user
#' @export
validate_key <- function(user, device = NA_character_, ...) {
    message("validate_key() is deprecated. Please use validate_user() or validate_group() instead.")
    
    opt_args <- list(...)
    app <- ifelse("token" %in% names(opt_args),
                  opt_args[["token"]],
                  get_pushover_app())
    
    if (is.na(device)) {
        device = NULL
    }
    
    validate_user(user = user, app = app, device = device)
}


#' @rdname validate_user
#' @export
is.valid_user <- function(user, app = get_pushover_app(), device = NULL) {
    rval <- validate_user(user = user, app = app, device = device)
    rval$status == 1
}


#' @rdname validate_user
#' @export
is.valid_group <- is.valid_user


#' @rdname validate_user
#' @export
is.valid_key <- function(user, device = NA, ...) {
    message("is.valid_key() is deprecated. Please use is.valid_user() or is.valid_group() instead.")
    
    opt_args <- list(...)
    app <- ifelse("token" %in% names(opt_args),
                  opt_args[["token"]],
                  get_pushover_app())
    
    if (is.na(device)) {
        device = NULL
    }   
    
    is.valid_user(user = user, app = app, device = device)
}


# TODO is.valid_device?
