library(httr)

# TODO: document the package


# TODO: document
# returns a [name, description] list
get_sounds <- function(token)
{
    if(missing(token)) stop("Error: Must provide application token")
    
    response <- GET(url='https://api.pushover.net/1/sounds.json',
                    query=list('token'=token))
    if(response$status==200)
    {
        return(content(response)$sounds)
    }
    else
    {
        for(e in content(response)$errors)
        {
            cat(paste('Error:', e))
        }
    }
}

# TODO: document
validate_key <- function(token, user, device=NA)
{
    if(missing(token)) stop("Error: Must provide application token")
    if(missing(user)) stop("Error: Must provide user key")
    
    params <- list('token'=token, 'user'=user)
    if(!is.na(device)) params['device'] <- device
    
    response <- POST(url='https://api.pushover.net/1/users/validate.json',
                     body=params)

    attr(response$headers, 'class') <- 'list'
    rsp <- PushoverResponse(status=content(response)$status,
                            request=content(response)$request,
                            status_code=response$status_code ,
                            headers=response$headers)
    return(rsp)
}

# TODO: document
is.valid_key <- function(token, user, device=NA)
{
    response <- validate_key(token=token, user=user, device=device)
    return(http_status_code(response)==200 & status(response)==1)
}


# TODO: wrapper function to easily send a message
pushover <- function(message, token, user, device=NA, title=NA, url=NA,
                     url_title=NA, priority=PRIORITY_NORMAL, timestamp=NA,
                     sound='pushover')
{
    
}