# keys.R
# Functions that deal with validating, storing, and retrieving
# user/group keys and app tokens.

# This environment stores user/group keys and API tokens so they don't have to
# always be provided as arguments to messaging functions
env <- new.env()

#' Determine whether or not a given API token is valid
#'
#' \code{is.valid_token} determines whether or not a given application token
#' is valid or not according to Pushover's specifications. It does not determine
#' whether or not the given token is associated with an application.
#' 
#' @note To acquire an application token, register your token at
#' \url{https://pushover.net/apps}
#'
#' @export
#' @param token A application token (e.g., 'KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' @return A boolean value indicating if the application token is valid
#' (\code{TRUE})
#' or not (\code{FALSE})
#' @examples
#' \dontrun{
#' is.valid_token(token='KzGDORePK8gMaC0QOYAMyEEuzJnyU')
#' }
#' 
is.valid_token <- function(token)
{
    return(grepl('^[a-zA-Z0-9]{30}$', token))
}


#' Determine whether or not a given user/group key is valid
#'
#' \code{validate_key} issues a query to Pushover to determine whether or not a
#' given user (or group) key is valid. If a \code{device} is specified, the
#' query will also see if the given device is registered to that user.
#' 
#' @note To acquire a user key, create an account at \url{https://pushover.net}
#'
#' @export
#' @param user A user or group key (e.g., 'uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' @param device A device name (e.g., 'phone')
#' @param ... Any additional parameters, such as an application \code{token}
#' \code{\link{set_pushover_app}}.
#' @return \code{validate_key} returns a \code{\link{PushoverResponse}} object
#' containing the response from the server
#' @examples
#' \dontrun{
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
#' }
#'
validate_key <- function(user, device=NA_character_, ...)
{
    if(missing(user)) stop("Must provide user key")

    opt_args <- list(...)
    token <- NA
    
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

#' Determine whether a user key is valid
#'
#' \code{is.valid_key} returns a boolean value indicating whether the
#' user/device is valid (\code{TRUE}) or not (\code{FALSE}).
#'
#' @return \code{is.valid_key} returns a boolean value indicating whether the
#' user/device is valid (\code{TRUE}) or not (\code{FALSE}).
#' @export
#' @rdname validate_key
is.valid_key <- function(user, device=NA, ...)
{
    opt_args <- list(...)
    token <- NA
    
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
    
    response <- validate_key(token=token, user=user, device=device)
    return(http_status_code(response)==200 & status(response)==1)
}


#' Store Pushover app and user information and use for all subsequent queries
#' 
#' \code{set_pushover_app} allows an application token to be stored that will be
#' used for all subsequent calls that require a token (e.g.,
#' \code{\link{pushover}}).
#' 
#' @note This behavior can temporarily be overridden by providing an app token
#' or user key as argument to the function in question.
#' 
#' @export
#' @rdname set_pushover_app
#' @param token The application token
#' @param user If a user/group key is given, that information will also be
#' saved for subsequent queries. This is eqivalant to calling
#' \code{\link{set_pushover_user}}.
#' @examples
#' \dontrun{
#' # Set the Pushover user account to use
#' set_pushover_app('KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' 
#' # Determine whether the Pushover user account has been set
#' if(pushover_app.isset())
#' {
#'     cat(paste('The Pushover app token has been set to', get_pushover_app()))
#' }
#' }
#' 
set_pushover_app <- function(token, user=NA)
{
    if(missing(token)) stop('must provide application token')
    if(!is.valid_token(token)) stop('invalid application token')
    
    if(!is.na(user)) set_pushover_user(user)
    
    assign('token', token, envir=env, inherits=FALSE)
}

#' Determine whether the Pushover app token has been set
#' 
#' \code{pushover_app.isset} determines whether or not a Pushover app has been
#' set
#' 
#' @rdname set_pushover_app
#' @export
#' @return \code{pushover_app.isset} returns a boolean indicating whether the
#' app token has been set (\code{TRUE}) or not (\code{FALSE}).
pushover_app.isset <- function() exists('token', envir=env, inherits=FALSE)


#' Forget about the current Pushover App
#' 
#' \code{unset_pushover_app} removes a stored Pushover app token, which means
#' that a token will have to be provided to all subsequent API calls.
#' 
#' @rdname set_pushover_app
#' @export
unset_pushover_app <- function() rm('token', envir=env, inherits=FALSE)


#' Get the current pushover app token
#' 
#' \code{get_pushover_app} returns the token associated with the current
#' Pushover app
#' 
#' @rdname set_pushover_app
#' @export
#' @return \code{get_pushover_app} returns a string representing the token
#' associated with the current app (if one is set)
get_pushover_app <- function() get('token', envir=env, inherits=FALSE)


#' Use a Pushover user key for all subsequent queries
#' 
#' \code{set_pushover_user} allows a user key to be stored that will be used
#' for all subsequent calls that require a user key (e.g.,
#' \code{\link{pushover}}).
#' 
#' @export
#' @rdname set_pushover_app
#' @examples
#' \dontrun{
#' # Set the Pushover user account to use
#' set_pushover_user('uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' 
#' # Determine whether the Pushover user account has been set
#' if(pushover_user.isset())
#' {
#'     cat(paste('Pushover user has been set to', get_pushover_user()))
#' }
#' 
#' When both the app token and user account have been set, we can send a
#' message without providing either of them:
#' pushover('this took so much less typing!')
#' pushover_high('and again!')
#' }
#' 
set_pushover_user <- function(user)
{
    if(missing(user)) stop('must provide user/group key')
    # This can only be checked if the API token is set. Do a regexp test?
    #if(!is.valid_key(user)) stop('invalid user/group key')
    
    if(!grepl('^[a-zA-Z0-9]{30}$', user))
    {
        stop('invalid user/group key')
    }
    
    assign('user', user, envir=env, inherits=FALSE)
}


#' Determine whether a user/group has been set for subsequent Pushover API calls
#' 
#' \code{pushover_user.isset} indicates whether or not a Pushover user/group is
#' currently set
#' 
#' @rdname set_pushover_app
#' @export
#' @return \code{pushover_user.isset} returns  boolean indicating whether the
#' user/group is set
#' (\code{TRUE}) or not (\code{FALSE}).
pushover_user.isset <- function() exists('user', envir=env, inherits=FALSE)



#' Forget about the current user or group
#' 
#' \code{unset_pushover_user} removes a stored
#' Pushover user/group, which means that a key will have to be provided to all
#' subsequent API calls.
#' 
#' @note The Pushover API calls don't differentiate between users and groups
#' (and therefore neither does \code{pushoverr}). This function will remove any
#' user or group key that is saved.
#' 
#' @rdname set_pushover_app
#' @export
#' @examples
#' \dontrun{
#' # Forget about the current Pushover user
#' unset_pushover_user()
#' }
unset_pushover_user <- function() rm('user', envir=env, inherits=FALSE)


#' \code{get_pushover_user} gets the key associated with the current Pushover
#' user/group
#' @return \code{get_pushover_user} returns a string containing a Pushover
#' user/group key
#' @rdname set_pushover_app
#' @export
get_pushover_user <- function() get('user', envir=env, inherits=FALSE)
