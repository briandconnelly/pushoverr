# TODO: document
check_receipt <- function(token, receipt)
{
    if(missing(token)) stop("Must provide application token")
    if(missing(receipt)) stop("Must provide receipt")
    
    url <- sprintf('https://api.pushover.net/1/receipts/%s.json', receipt)
    
    response <- GET(url=url, query=list('token'=token))
    
    attr(response$headers, 'class') <- 'list'
    rsp <- PushoverResponse(status=content(response)$status,
                            request=content(response)$request,
                            status_code=response$status_code ,
                            headers=response$headers,
                            content=content(response))
    
    if(is.success(rsp))
    {
        return(rsp)
    }
    else
    {
        stop(rsp@content$errors)
    }    
}

# TODO: document
# Return boolean indicating whether or not an emergency message was acknowledge
is.acknowledged <- function(token, receipt, info=TRUE)
{
    rsp <- check_receipt(token, receipt)
    
    if(!is.null(rsp))
    {
        if(is.success(rsp))
        {
            if(info)
            {
                acknowledged <- get_response_content(rsp, 'acknowledged')
                calledback <- get_response_content(rsp, 'called_back')
                
                ack_time <- ''
                if(acknowledged)
                {
                    ack_raw <- get_response_content(rsp, 'acknowledged_at')
                    ack_time <- as.POSIXct(as.numeric(ack_raw), origin = "1970-01-01")
                }

                callback_time <- ''
                if(calledback)
                {
                    cb_raw <- get_response_content(rsp, 'called_back_at')
                    callback_time <- as.POSIXct(as.numeric(cb_raw), origin = "1970-01-01")
                }
                
                exp_raw <- get_response_content(rsp, 'expires_at')
                exp_time <- callback_time <- as.POSIXct(as.numeric(exp_raw), origin = "1970-01-01")
                
                ld_raw <- get_response_content(rsp, 'last_delivered_at')
                ld_time <- callback_time <- as.POSIXct(as.numeric(ld_raw), origin = "1970-01-01")
                
                # TODO: format dates
                cat(paste('Acknowledged:', get_response_content(rsp, 'acknowledged'), '\n'))
                cat(paste('Acknowledged At:', ack_time, '\n'))
                cat(paste('Acknowledged By:', get_response_content(rsp, 'acknowledged_by'), '\n'))
                cat(paste('Last Delivered:', ld_time, '\n'))
                cat(paste('Expires At:', exp_time, '\n'))
                cat(paste('Called Back:', get_response_content(rsp, 'called_back'), '\n'))
                cat(paste('Called Back At:', callback_time, '\n'))
            }
            
            acknowledged <- get_response_content(rsp, 'acknowledged')
            calledback <- get_response_content(rsp, 'called_back')
            
            return(acknowledged | calledback)
        }
        else
        {
            stop(rsp@content$errors)
        }
    }
}
