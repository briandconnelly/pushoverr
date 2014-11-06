#' Cancel an emergency message
#'
#' \code{cancel_receipt} issues a query to Pushover to cancel sending the
#' emergency message with the given receipt.
#' 
#' @note Message receipts can be acquired using \code{\link{receipt}} on the
#' \code{\link{PushoverResponse}} object storing the response to an emergency
#' message.
#'
#' @export
#' @param receipt A message receipt (e.g., 'KAWXTswy4cekx6vZbHBKbCKk1c1fdf')
#' @param ... An application token can be specified with \code{token}
#' @return A \code{\link{PushoverResponse}} object containing the response from
#' the server
#' @note The token argument is necessary, however it does not need to be given
#' if the application token have been set with \code{\link{set_pushover_app}}.

cancel_receipt <- function(receipt, ...)
{
    if(missing(receipt)) stop("Must provide receipt")
    
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
        
    url <- sprintf('https://api.pushover.net/1/receipts/%s/cancel.json', receipt)
    response <- POST(url=url, query=list('token'=token))
    
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
