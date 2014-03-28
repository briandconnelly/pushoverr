# devices.R
# Functions that deal with querying/validating/etc. user devices

#' Get a list of the user's registered devices
#'
#' \code{get_devices} queries Pushover to receive a list of the devices
#' given by the user (specified by their user key)
#'
#' @export
#' @param ... An app token and/or user key can be specified with the
#' \code{token} and \code{user} aguments, respectively
#' @note The token and user arguments are necessary, however they do not need
#' to be given if they have been set with \code{\link{set_pushover_user}} and
#' \code{\link{set_pushover_app}}, respectively.
#' @return \code{get_devices} returns a vector of device names
#' @examples
#' \dontrun{
#' available_devs <- get_devices(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                               user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' }
#'
get_devices <- function(...)
{
    opt_args <- list(...)
    token <- NA
    user <- NA
    
    if('token' %in% names(opt_args))
    {
        token <- opt_args[['token']]
    }
    else if(pushover_app.isset())
    {
        token <- get_pushover_app()
    }
    else
    {
        stop('Must provide application token')
    }
    
    if('user' %in% names(opt_args))
    {
        user <- opt_args[['user']]
    }
    else if(pushover_user.isset())
    {
        user <- get_pushover_user()
    }
    else
    {
        stop('Must provide user key')
    }
    
    response <- validate_key(token=token, user=user)
    return(response@content$devices)
}


#' Determine whether or not a given device is registered for a user
#'
#' \code{is.device} determines whether or not a given device name is registered
#' to the given user (specified by their user key)
#'
#' @export
#' @rdname get_devices
#' @param device A device name (e.g., 'phone')
#' @return \code{is.device} returns a boolean value indicating if the device is
#' registered (\code{TRUE}) or not (\code{FALSE})
#' @note The token and user arguments are necessary, however they do not need
#' to be given if they have been set with \code{\link{set_pushover_user}} and
#' \code{\link{set_pushover_app}}, respectively.
#' @examples
#' \dontrun{
#' is.device(device='phone',
#'           token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'           user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' }
#'                
is.device <- function(device, ...)
{
    if(missing(device)) stop("Must provide device name")
    
    opt_args <- list(...)
    token <- NA
    user <- NA
    
    if('token' %in% names(opt_args))
    {
        token <- opt_args[['token']]
    }
    else if(pushover_app.isset())
    {
        token <- get_pushover_app()
    }
    else
    {
        stop('Must provide application token')
    }
    
    if('user' %in% names(opt_args))
    {
        user <- opt_args[['user']]
    }
    else if(pushover_user.isset())
    {
        user <- get_pushover_user()
    }
    else
    {
        stop('Must provide user key')
    }
    
    return(device %in% get_devices(token, user))
}


#' Determine whether or not a given device name is valid
#'
#' \code{is.valid_device} determines whether or not a given device name is valid
#' or not according to Pushover's specifications. It does not determine whether
#' or not the given device is registered to a user.
#'
#' @export
#' @param device A device name (e.g., 'phone')
#' @return A boolean value indicating if the device name is valid (\code{TRUE})
#' or not (\code{FALSE})
#' @examples
#' \dontrun{
#' is.valid_device(device='phone')
#' }
#' 
is.valid_device <- function(device)
{
    return(grepl('^[a-zA-Z0-9_-]{1,25}$', device))
}
