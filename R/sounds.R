# TODO: document
# returns a [name, description] list
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
