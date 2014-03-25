#' Query Pushover to determine whether or not a given message has been seen
#'
#' \code{check_receipt} issues a query to Pushover to determine whether or not
#' an emergency-priority message has been acknowledged and when (if applicable).
#' If a callback URL was specified with the message, it will also report whether or
#' not that callback URL was POSTed to and when.
#' 
#' \code{is.acknowledged} returns whether a message was acknowledged
#' (\code{TRUE}) or not (\code{FALSE}) as well as some information about when
#' the message was received and by whom.
#' 
#' @note Message receipts can be acquired using \code{\link{receipt}} on the
#' \code{\link{PushoverResponse}} object storing the response to an emergency
#' message.
#'
#' @export
#' @aliases is.acknowledged
#' @param token A application token (e.g., 'KzGDORePK8gMaC0QOYAMyEEuzJnyUi')
#' @param receipt A message receipt (e.g., 'KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#' @param info \code{is.valid_receipt} will print out additional information
#' about who acknowledged the message, when, and if and when the callback URL
#' was accessed
#' @return A \code{\link{PushoverResponse}} object containing the response from
#' the server
#' @seealso \code{\link{is.acknowledged}}
#' @importFrom httr GET content
#' @examples
#' response <- check_receipt(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                           receipt='KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#'                           
#' if(is.acknowledged(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                    receipt='KAWXTswy4cekx6vZbHBKbCKk1c1fdf'))
#' {
#'     cat('Message has been read.\n')
#' }
#'
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


#' @export
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

#' Determine whether or not a given message receipt is valid
#'
#' \code{is.valid_receipt} determines whether or not a given message receipt
#' is valid or not according to Pushover's specifications. It does not determine
#' whether or not the given receipt actually exists.
#' 
#' @note To acquire a message receipt, send an emergency prioirty message
#'
#' @export
#' @param receipt A message receipt (e.g., 'KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#' @return A boolean value indicating if the message receipt is valid (\code{TRUE})
#' or not (\code{FALSE})
#' @seealso \code{\link{check_receipt}}
#' @examples
#' is.valid_receipt(token='KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#' 
is.valid_receipt <- function(receipt)
{
    return(grepl('^[a-zA-Z0-9]{30}$', receipt))
}
