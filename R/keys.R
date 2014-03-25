# TODO: document
is.valid_token <- function(token)
{
    return(grepl('^[a-zA-Z0-9]{30}$', token))
}

# TODO: document
validate_key <- function(token, user, device=NA)
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

# TODO: document
is.valid_key <- function(token, user, device=NA)
{
    response <- validate_key(token=token, user=user, device=device)
    return(http_status_code(response)==200 & status(response)==1)
}
