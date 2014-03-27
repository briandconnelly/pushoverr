# devices.R
# Functions that deal with querying/validating/etc. user devices

#' Get a list of the user's registered devices
#'
#' \code{get_user_devices} queries Pushover to receive a list of the devices
#' given by the user (specified by their user key)
#'
#' @export
#' @param token The application token
#' @param user The user's identifier
#' @return A vector of device names
#' @examples
#' available_devs <- get_user_devices(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                                    user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
get_user_devices <- function(token, user)
{
    if(missing(token)) stop("Must provide application token")
    if(missing(user)) stop("Must provide user/group key")
    
    response <- validate_key(token=token, user=user)
    return(response@content$devices)
}


#' Determine whether or not a given device is registered for a user
#'
#' \code{is.user_device} queries Pushover to determine whether or not a given
#' device name is registered to the given user (specified by their user key)
#'
#' @export
#' @param token The application token
#' @param user The user's identifier
#' @param device A device name (e.g., 'phone')
#' @return A boolean value indicating if the device is registered (\code{TRUE})
#' or not (\code{FALSE})
#' @seealso \code{\link{get_user_devices}}
#' @examples
#' is.user_device(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG',
#'                device='phone')
#'                
is.user_device <- function(token, user, device)
{
    if(missing(device)) stop("Must provide device name")
    return(device %in% get_user_devices(token, user))
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
#' is.valid_device(device='phone')
#' 
is.valid_device <- function(device)
{
    return(grepl('^[a-zA-Z0-9_-]{1,25}$', device))
}
