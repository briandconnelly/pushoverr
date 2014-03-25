library(httr)

# TODO: document the package. Content similar to README.


# TODO: document these
pushover <- function(message, token, user, device=NA_character_,
                     title=NA_character_, url=NA_character_,
                     url_title=NA_character_, priority=0, timestamp=NA_integer_,
                     sound='pushover', callback=NA_character_, retry=60,
                     expire=3600)
{    
    msg <- PushoverMessage(message=message, token=token, user=user, device=device,
                           title=title, url=url, url_title=url_title,
                           priority=priority, timestamp=timestamp,
                           sound=sound, callback=callback, retry=retry,
                           expire=expire)    
    
    response <- send(msg)
    
    if(is.success(response))
    {
        return(request(response))
    }
    else
    {
        stop(response@content$errors)
    }
}

# TODO: document
pushover_quiet <- function(message, token, user, device=NA_character_,
                           title=NA_character_, url=NA_character_,
                           url_title=NA_character_, timestamp=NA_integer_)
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=-1,
                    timestamp=timestamp, sound='none'))
}

# TODO: document
pushover_normal <- function(message, token, user, device=NA_character_,
                            title=NA_character_, url=NA_character_, 
                            url_title=NA_character_, timestamp=NA_integer_,
                            sound='pushover')
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=0,
                    timestamp=timestamp, sound=sound))
}

# TODO: document
pushover_high <- function(message, token, user, device=NA_character_,
                          title=NA_character_, url=NA_character_,
                          url_title=NA_character_, timestamp=NA_integer_,
                          sound='pushover')
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=1,
                    timestamp=timestamp, sound=sound))
}

# TODO: document
pushover_emergency <- function(message, token, user, device=NA_character_,
                               title=NA_character_, url=NA_character_, 
                               url_title=NA_character_, timestamp=NA_integer_,
                               sound='pushover', callback=NA_character_,
                               retry=60, expire=3600)
{
    return(pushover(message=message, token=token, user=user, device=device,
                    title=title, url=url, url_title=url_title, priority=2,
                    timestamp=timestamp, callback=callback, sound=sound,
                    retry=retry, exipre=expire))
}
