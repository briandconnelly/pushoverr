pushover_sounds <- c('bike', 'bugle', 'cashregister', 'classical', 'cosmic',
                     'falling', 'gamelan', 'incoming', 'intermission', 'magic',
                     'mechanical', 'pianobar', 'siren', 'spacealarm', 'tugboat',
                     'alien', 'climb', 'persistent', 'echo', 'updown',
                     'pushover', 'none')

priorities <- list('-1'='quiet', '0'='normal', '1'='high', '2'='emergency')


#' Validate a given PushoverMessage object
#'
#' \code{validate_PushoverMessage} determines whether or not a given
#' \code{PushoverMessage} object has valid slot values. It does not determine whether
#' or not the given application token or user/group keys are registered with
#' Pushover. This second step can be done with \code{\link{validate_key}} or
#' \code{\link{is.valid_key}}. This function is automatically called when a
#' \code{PushoverMessage} object is created or \code{\link{validObject}} is
#' called with an existing \code{PushoverMessage} object.
#' 
#' @note To acquire a user key, register an account at \link{https://pushover.net}
#' @note To acquire an application token, register your token at \link{https://pushover.net/apps}
#'
#' @param object A \code{\link{PushoverMessage}} object
#' @return A boolean value indicating if the PushoverMessage object is
#' valid (\code{TRUE}) or not (\code{FALSE})
#' 
validate_PushoverMessage <- function(object)
{
    if(missing(object)) stop("Must provide object for validation")
    
    retval <- NULL
    
    message_length <- length(object@message)
    if(message_length==0)
    {
        retval <- c(retval, "must specify message")
    }
    else if(message_length > 1)
    {
        retval <- c(retval, "only one message may be specified")
    }
    else if(nchar(object@message) > 512)
    {
        retval <- c(retval, "invalid message length (cannot be longer than 512 characters") 
    } 
    
    token_length <- length(object@token)
    if(token_length==0)
    {
        retval <- c(retval, "must specify API token")
    }
    else if(token_length > 1)
    {
        retval <- c(retval, "only one API token is supported")
    }
    else if(!is.valid_token(object@token))
    {
        retval <- c(retval, "invalid API token")
    }
    
    user_length <- length(object@user)
    if(user_length==0)
    {
        retval <- c(retval, "must specify user key")
    }
    else if(user_length > 1)
    {
        retval <- c(retval, "only one user key is supported")
    }
    else if(!grepl('^[a-zA-Z0-9]{30}$', object@user))
    {
        retval <- c(retval, "invalid user key")
    }
    # TODO: validate user key on server??
    
    device_length <- length(object@device)
    if(device_length > 1)
    {
        retval <- c(retval, "only one device may be specified (specify none to send to all devices")
    }    
    else if(device_length==1 & !is.na(object@device))
    {
        if(!is.valid_device(object@device))
        {
            retval <- c(retval, "invalid device name (must be up to 25 letters, numbers, _, or -)")
        }
    }
    
    title_length <- length(object@title)
    if(title_length > 1)
    {
        retval <- c(retval, "only one message title is supported")
    }
    else if(title_length==1 & !is.na(object@title))
    {
        if(nchar(object@title) + nchar(object@message) > 512)
        {
            retval <- c(retval, "title and message cannot exceed 512 characters")
        }
    }
    
    length_url <- length(object@url)
    if(length_url==1 & !is.na(object@url))
    {
        if(nchar(object@url) > 512)
        {
            retval <- c(retval, "URL cannot exceed 512 characters")
        }
        # TODO: validate url
    }
    else if(length_url > 1)
    {
        retval <- c(retval, "only one URL is supported")
    }
    
    length_url_title <- length(object@url_title)
    if(length_url_title==1 & !is.na(object@url_title))
    {
        if(nchar(object@url_title) > 100)
        {
            retval <- c(retval, "URL title cannot exceed 100 characters")
        }
    }
    else if(length_url_title > 1)
    {
        retval <- c(retval, "only one URL title is supported")
    }
    
    length_priority <- length(object@priority)
    if(length_priority > 1)
    {
        retval <- c(retval, "only one message priority is supported")
    }
    else if(length_priority==1)
    {
        if(!object@priority %in% c(-1,0,1,2))
        {
            retval <- c(retval, "invalid message priority")
        }
    } 
    
    length_sound <- length(object@sound)
    if(length_sound > 1)
    {
        retval <- c(retval, "only one message sound is supported per object")
    }
    else if(length_sound==1)
    {
        if(!object@sound %in% pushover_sounds)
        {
            retval <- c(retval, paste("invalid sound", object@sound))
        }
    }
    
    length_callback <- length(object@callback)
    if(length_callback > 1)
    {
        retval <- c(retval, "only one callback URL is supported per object")
    }
    
    length_retry <- length(object@retry)
    if(length_retry > 1)
    {
        retval <- c(retval, "only one retry value is supported per object")
    }
    else if(object@retry < 30)
    {
        retval <- c(retval, "value for retry must be at least 30")
    }
    
    length_expire <- length(object@expire)
    if(length_retry > 1)
    {
        retval <- c(retval, "only one expire is supported per object")
    }
    else if(object@expire > 86400)
    {
        retval <- c(retval, "value for expire must be less than 86400")
    }
    else if(object@expire <= 0)
    {
        retval <- c(retval, "value for expire must be positive")
    }
    
    if(is.null(retval)) return(TRUE)
    else return(retval)
}


#' Create a Pushover message
#' 
#' \code{PushoverMessage} objects represent a Pushover message and implements
#' all of the features available in Pushover's
#' API (\link{https://pushover.net/api}). \code{PushoverMessage} objects are
#' used to build queries that are sent to Pushover's servers.
#' 
#' @export
#' @name PushoverMessage
#' @rdname PushoverMessage
#' @slot message The message to be sent (max. 512 characters)
#' @slot token The application token
#' @slot user The user or group key to send the message to
#' @slot device The device to send the notification to (optional)
#' @slot title The title of the message (optional)
#' @slot url A URL to be included in the message (optional, max. 512 characters
#' @slot url_title A title for the given url (optional, max. 100 characters)
#' @slot priority The message's priority. One of: -1 (quiet), 0 (normal, default), 1 (high), 2 (emergency). Quiet messages do not play a sound. Emergency messages require acknowledgement.
#' @slot timestamp The time to associate with the message (default: now, format: UNIX time)
#' @slot sound The sound to be played when the message is received (see \code{\link{get_sounds}})
#' @slot callback A callback URL. For emergency priority, a POST request will be sent to this URL when the message is acknowledged (see \link{https://pushover.net/api#receipt})
#' @slot retry The number of seconds between re-sending of an unacknowledged emergency message (default: 60, min: 30)
#' @slot expire The number of seconds until an unacknowledged emergency message will stop being resent (default: 3600, max: 86400).
#' @examples
#' # Create a PushoverMessage
#' m1 <- new('PushoverMessage', message='Hi there', token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi', user='KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#'
#' # Alternate way to create a PushoverMessage
#' m2 <- PushoverMessage(message='Hi there', token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi', user='KAWXTswy4cekx6vZbHBKbCKk1c1fdf')

PushoverMessage <- setClass('PushoverMessage',
                            slots=list(message='character',
                                       token='character',
                                       user='character',
                                       device='character',
                                       title='character',
                                       url='character',
                                       url_title='character',
                                       priority='numeric',
                                       timestamp='numeric',
                                       sound='character',
                                       callback='character',
                                       retry='numeric',
                                       expire='numeric'),
                            prototype=list(message=NA_character_,
                                           token=NA_character_,
                                           user=NA_character_,
                                           device=NA_character_,
                                           title=NA_character_,
                                           url=NA_character_,
                                           url_title=NA_character_,
                                           priority=0,
                                           timestamp=NA_real_,
                                           sound='pushover',
                                           callback=NA_character_,
                                           retry=60,
                                           expire=3600),
                            validity=validate_PushoverMessage
                            )


#' Show (print information about) a PushoverMessage object
#'
#' \code{show_PushoverMessage} prints information about a given
#' \code{PushoverMessage} object. This function is automatically called when a
#' \code{PushoverMessage} object is referenced alone, when returned from a
#' function and not stored, or when \code{\link{show}} is called with a
#' \code{PushoverMessage} object.
#'
#' @param object A \code{\link{PushoverMessage}} object
#' 
show_PushoverMessage <- function(object)
{
    cat('PushoverMessage object:\n')
    cat(sprintf('\tMessage: %s (%d chars)\n', object@message, nchar(object@message)))
    cat('\tAPI Token:', object@token, '\n')
    cat('\tUser Key:', object@user, '\n')
    cat('\tDevice:', object@device, '\n')
    cat('\tTitle:', object@title)
    if(!is.na(object@title))
    {
        cat(sprintf(' (%d chars)', nchar(object@title)))
    }
    cat('\n')
    
    cat('\tURL:', object@url)
    if(!is.na(object@url))
    {
        cat(sprintf(' (%d chars)', nchar(object@url)))
    }
    cat('\n')
    
    cat('\tURL Title:', object@url_title)
    if(!is.na(object@url_title))
    {
        cat(sprintf(' (%d chars)', nchar(object@url_title)))
    }
    cat('\n')
    
    cat(sprintf('\tPriority: %d (%s)\n', object@priority,
                priorities[as.character(object@priority)]))
    cat('\tTime Stamp:', object@timestamp, '\n')
    cat('\tSound:', object@sound, '\n')  
    cat('\tCallback URL:', object@callback, '\n')
    cat(sprintf('\tRetry: %d seconds\n', object@retry))
    cat(sprintf('\tExpire: %d seconds\n', object@expire))
}
setMethod(f='show', signature='PushoverMessage', definition=show_PushoverMessage)


#' Send a PushoverMessage object
#'
#' \code{send_PushoverMessage} sends a given \code{PushoverMessage} object to
#' Pushover. This function is not directly called, but is used when
#' \code{\link{send}} is called with a \code{PushoverMessage} object.
#'
#' @param object A \code{\link{PushoverMessage}} object
#' @return A \code{\link{PushoverResponse}} object containing information about
#' the server's response.
#' @importFrom httr POST
#' 
send_pushovermessage <- function(object)
{
    params <- list('message'=object@message,
                   'token'=object@token,
                   'user'=object@user,
                   'priority'=object@priority,
                   'sound'=object@sound,
                   'retry'=object@retry,
                   'expire'=object@expire)
    
    if(!is.na(object@device)) params['device'] <- object@device
    if(!is.na(object@title)) params['title'] <- object@title
    if(!is.na(object@url)) params['url'] <- object@url
    if(!is.na(object@url_title)) params['url_title'] <- object@url_title
    if(!is.na(object@timestamp)) params['timestamp'] <- object@timestamp
    if(!is.na(object@callback)) params['callback'] <- object@callback
    
    response <- POST(url="https://api.pushover.net:443/1/messages.json",
                     body=params)
    
    attr(response$headers, 'class') <- 'list'
    rsp <- PushoverResponse(status=content(response)$status,
                            request=content(response)$request,
                            status_code=response$status_code ,
                            headers=response$headers,
                            content=content(response))
    
    # Return the response, whether sending the message was successful or not.
    # This can be determined by the caller with is.success() or similar.
    return(rsp)
}

#' Send a Pushover message
#' 
#' \code{send} sends the given Pushover message (represented by a
#' \code{\link{PushoverMessage}}) object
#' 
#' @export
#' @param object A \code{\link{PushoverMessage}}) object
#' @return A \code{\link{PushoverResponse}} object containing information about
#' the server's response.
#' @examples
#' message <- PushoverMessage(message='Hello World', token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi', user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' response <- send(message)
#' 
setGeneric(name="send", def=function(object) standardGeneric("send"))
setMethod(f="send", signature="PushoverMessage", definition=send_pushovermessage)
