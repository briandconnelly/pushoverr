# TODO: document
get_user_devices <- function(token, user)
{
    if(missing(token)) stop("Must provide application token")
    if(missing(user)) stop("Must provide user/group key")
    
    response <- validate_key(token=token, user=user)
    return(response@content$devices)
}

# TODO: document
is.user_device <- function(token, user, device)
{
    if(missing(device)) stop("Must provide device name")
    return(device %in% get_user_devices(token, user))
}

# TODO: document
is.valid_device <- function(device)
{
    return(grepl('^[a-zA-Z0-9_-]{1,25}$', device))
}
