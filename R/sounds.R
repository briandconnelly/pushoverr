#' Get a list of available message sounds
#'
#' \code{get_sounds} queries Pushover to receive a list of the sounds that may
#' be played on a user's device when a message is received. Sounds are specified
#' when the message is sent.
#'
#' @export
#' @param token The application token
#' @return A list of available sounds and their descriptions
#' @importFrom httr GET
#' @examples
#' sounds <- get_sounds(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' for (s in names(sounds))
#' {
#'     cat(paste(s, ":", sounds[s], "\n"))
#' }
#' 
get_sounds <- function(token)
{
    if(missing(token)) stop("Must provide application token")
    
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
