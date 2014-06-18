# pushover.R
# Functions that deal with building and sending messages to
# Pushover. The actual structures of the message objects and server response
# objects, which are created and used here, are defined in PushoverMessage.R and
# PushoverResponse.R.


#' Send a message using Pushover
#'
#' \code{pushover} sends a message (push notification) to a user or group.
#' Messages can be given different priorities, play different sounds, or require
#' acknowledgments. A unique request token is returned. The
#' \code{pushover_normal}, \code{pushover_silent}, \code{pushover_quiet},
#' \code{pushover_high}, and \code{pushover_emergency} functions send messages
#' with those priorities.
#'
#' @export
#' @aliases pushover pushover_normal pushover_quiet pushover_high
#' pushover_emergency pushover_silent
#' @param message The message to be sent (max. 512 characters)
#' @param ... Any additional message parameters (see
#' \code{\link{PushoverMessage-class}})
#' @return A list containing a Pushover request token and a receipt token for
#' emergency priority messages. When used outside of an assignment, these
#' return values will not be displayed for non-emergency messages.
#' @note Pushover user/group keys and application tokens are requred for a
#' message. They can either be specified as arguments or be set earlier with
#' \code{\link{set_pushover_user}} and \code{\link{set_pushover_app}},
#' respectively.
#' @examples
#' \dontrun{
#' # Send a pushover message
#' pushover(message='Hello World!', token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'          user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#'               
#' # User keys and app tokens can be set ahead of time
#' set_pushover_user('KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#' set_pushover_app('KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' pushover(message='so much less work!')
#' 
#' # Send a message with high priority and a title
#' pushover_high(message='The sky is falling', title='Alert')
#'
#' # Send an emergency message. Emergency messages will be re-sent until they
#' # are acknowledged (in this case, every 60 seconds)
#' pushover_emergency(message='TAXES ARE DUE AT MIDNIGHT!', retry=60)
#'                              
#' # Send a quiet message
#' pushover_quiet(message='Pssst. Walk the dog when you wake up')
#' }

pushover <- function(message, ...)
{    
    msg <- PushoverMessage(message=message, ...)    
    response <- send(msg)
    
    if(is.success(response))
    {
        ret <- list('request'=request(response))
        
        if(msg@priority==2)
        {
            ret['receipt'] <- receipt(response)
            return(ret)
        }
        return(invisible(ret))
    }
    else
    {
        stop(response@content$errors)
    }
}

#' @export
pushover_silent <- function(message, ...)
{
    return(invisible(pushover(message=message, priority=-2, ...)))
}

#' @export
pushover_quiet <- function(message, ...)
{
    return(invisible(pushover(message=message, priority=-1, ...)))
}

#' @export
pushover_normal <- function(message, ...)
{
    return(invisible(pushover(message=message, priority=0, ...)))
}

#' @export
pushover_high <- function(message, ...)
{
    return(invisible(pushover(message=message, priority=1, ...)))
}

#' @export
pushover_emergency <- function(message, ...)
{
    return(pushover(message=message, priority=2, ...))
}
