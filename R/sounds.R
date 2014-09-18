# sounds.R
# Functions and other objects that deal with the sounds played when a user
# receives a notification.

pushover_sounds <- c('bike', 'bugle', 'cashregister', 'classical', 'cosmic',
                     'falling', 'gamelan', 'incoming', 'intermission', 'magic',
                     'mechanical', 'pianobar', 'siren', 'spacealarm', 'tugboat',
                     'alien', 'climb', 'persistent', 'echo', 'updown',
                     'pushover', 'none')


#' Get a list of available message sounds
#'
#' \code{get_pushover_sounds} queries Pushover to receive a list of the sounds
#' that may be played on a user's device when a message is received. Sounds are
#' specified when the message is sent.
#'
#' @export
#' @param ... An application token can be specified with \code{token}
#' @return A list of available sounds and their descriptions
#' @examples
#' \dontrun{
#' sounds <- get_pushover_sounds()
#' for (s in names(sounds))
#' {
#'     cat(paste(s, ":", sounds[s], "\n"))
#' }
#' }
#' 
get_pushover_sounds <- function(...)
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
    
    response <- GET(url='https://api.pushover.net/1/sounds.json',
                    query=list('token'=token))
    
    if(response$status==200)
    {
        return(content(response)$sounds)
    }
    else
    {
        stop(response@content$errors)
    }
}
