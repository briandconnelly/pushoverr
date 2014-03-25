#' Determine whether or not a given API token is valid
#'
#' \code{is.valid_token} determines whether or not a given application token
#' is valid or not according to Pushover's specifications. It does not determine
#' whether or not the given token is associated with an application.
#' 
#' @note To acquire an application token, register your token at \link{https://pushover.net/apps}
#'
#' @export
#' @param token A application token (e.g., 'KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' @return A boolean value indicating if the application token is valid (\code{TRUE})
#' or not (\code{FALSE})
#' @examples
#' is.valid_token(token='KzGDORePK8gMaC0QOYAMyEEuzJnyU')
#' 
is.valid_token <- function(token)
{
    return(grepl('^[a-zA-Z0-9]{30}$', token))
}


#' Query Pushover to determine whether or not a given user key is valid
#'
#' \code{validate_key} issues a query to Pushover to determine whether or not a
#' given user (or group) key is valid. If a \code{device} is specified, the
#' query will also see if the given device is registered to that user.
#' 
#' \code{is.valid_key} performs the same check and returns a boolean value
#' indicating whether the user/device is valid (\code{TRUE}) of not
#' (\code{FALSE}).
#' 
#' @note To acquire a user key, create an account at \link{https://pushover.net}
#'
#' @export
#' @param token A application token (e.g., 'KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' @param user A user or group key (e.g., 'uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' @param device A device name (e.g., 'phone')
#' @return A \code{\link{PushoverResponse}} object containing the response from
#' the server
#' @aliases is.valid_key
#' @importFrom httr POST content
#' @examples
#' response <- validate_key(token='KzGDORePK8gMaC0QOYAMyEEuzJnyU',
#'                          user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' response_dev <- validate_key(token='KzGDORePK8gMaC0QOYAMyEEuzJnyU',
#'                              user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG',
#'                              device='phone')
#'                              
#' if(is.valid_key(token='KzGDORePK8gMaC0QOYAMyEEuzJnyU',
#'                 user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG',
#'                 device='phone'))
#' {
#'      cat('I can send to this device!')
#' }
#'
validate_key <- function(token, user, device=NA_character_)
{
    if(missing(token)) stop("Must provide application token")
    if(missing(user)) stop("Must provide user key")
    
    params <- list('token'=token, 'user'=user)
    if(!is.na(device)) params['device'] <- device
    
    response <- POST(url='https://api.pushover.net/1/users/validate.json',
                     body=params)
    
    attr(response$headers, 'class') <- 'list'
    rsp <- PushoverResponse(status=content(response)$status,
                            request=content(response)$request,
                            status_code=response$status_code ,
                            headers=response$headers,
                            content=content(response))
    return(rsp)
}

#' @export
is.valid_key <- function(token, user, device=NA)
{
    response <- validate_key(token=token, user=user, device=device)
    return(http_status_code(response)==200 & status(response)==1)
}
