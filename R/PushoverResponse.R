
#' Validate a given PushoverResponse object
#'
#' \code{validate_PushoverResponse} determines whether or not a given
#' \code{PushoverResponse} object has valid slot values. This function is
#' automatically called when a new \code{PushoverResponse} object is created or
#' \code{\link{validObject}} is called with an existing object.
#'
#' @param object A \code{\link{PushoverResponse}} object
#' @return A boolean value indicating if the PushoverResponse object is
#' valid (\code{TRUE}) or not (\code{FALSE})
#' 
validate_PushoverResponse <- function(object)
{
    retval <- NULL
    
    length_status <- length(object@status)
    length_request <- length(object@request)
    length_status_code <- length(object@status_code)
    length_headers <- length(object@headers)
    length_content <- length(object@content)
    
    if(length_status > 1)
    {
        retval <- c(retval, "only one response status is supported")
    }
    
    if(length_request > 1)
    {
        retval <- c(retval, "only one request token is supported")
    }
    
    if(length_status_code > 1)
    {
        retval <- c(retval, "only one HTTP status code is supported")
    }
    
    if(is.null(retval)) return(TRUE)
    else return(retval)
}


#' The PushoverResponse class
#' 
#' PushoverResponse objects store information from responses to Pushover queries
#' 
#' @export
#' @rdname PushoverResponse-class
#' @name PushoverResponse-class
#' @slot status The status response from Pushover 1=good, 0=problem
#' @slot request The unique identifier associated with the message
#' @slot status_code The HTTP status code returned
#' @slot headers A list containing the headers in the HTTP response
#' @slot content A list containing the content from the response. This will vary
#' depending on the type of query sent to the server.
#' @note \code{PushoverResponse} objects can be created with \code{\link{new}}
#' or with the \code{\link{PushoverResponse}} constructor (see Examples below).
#' @seealso \code{\link{PushoverResponse}}
#' @import methods
#' 
#' @examples 
#' \dontrun{
#' library(pushoverr)
#' 
#' # Create PushoverResponse object based on a POST to Pushover
#' response <- POST(url="https://api.pushover.net/1/messages.json",
#'                  body=params)
#' response <- new("PushoverResponse", status=1,
#'                 request='8345bfe5fbd7d346028f2863de77c8c4',
#'                 status_code=200,
#'                 headers=resp$headers,
#'                 content=content(rsp))
#'
#' # Create PushoverResponse object using constructor
#' response <- POST(url="https://api.pushover.net/1/messages.json",
#'                  body=params)
#' response <- PushoverResponse(status=1,
#'                              request='8345bfe5fbd7d346028f2863de77c8c4',
#'                              status_code=200,cheaders=resp$headers,
#'                              content=content(rsp))
#' }
#'  
GenPushoverResponse <- setClass('PushoverResponse',
                                slots=list(status='numeric',
                                           request='character',
                                           status_code='numeric',
                                           headers='list',
                                           content='list'),
                                prototype=list(status=NA_integer_,
                                               request=NA_character_,
                                               status_coe=NA_integer_,
                                               headers=list(),
                                               content=list()),
                                validity=validate_PushoverResponse
)


#' Create a PushoverResponse to store a Pushover server response
#' 
#' The \code{PushoverResponse} function is a constructor that creates
#' \code{\link{PushoverResponse-class}} objects. These objects store information
#' from responses to Pushover queries
#' 
#' @export
#' @param status The status response from Pushover 1=good, 0=problem
#' @param request The unique identifier associated with the message
#' @param status_code The HTTP status code returned
#' @param headers A list containing the headers in the HTTP response
#' @param content A list containing the content from the response. This will vary
#' depending on the type of query sent to the server.
#' @seealso \code{\link{PushoverResponse-class}}
#' 
#' @examples 
#' \dontrun{
#' library(pushoverr)
#' 
#' # Create PushoverResponse object
#' response <- POST(url="https://api.pushover.net/1/messages.json",
#'                  body=params)
#' response <- PushoverResponse(status=1,
#'                              request='8345bfe5fbd7d346028f2863de77c8c4',
#'                              status_code=200,cheaders=resp$headers,
#'                              content=content(rsp))
#' }
#'
PushoverResponse <- function(status=NA_integer_, request=NA_character_,
                             status_code=NA_integer_, headers=NA, content=NA)
{
    obj <- new("PushoverResponse", status=status, request=request,
               status_code=status_code, headers=headers, content=content)
    return (obj)
}


show_PushoverResponse <- function(object)
{
    cat('PushoverResponse object:\n')
    cat('\tStatus:', object@status, '\n')
    cat('\tRequest:', object@request, '\n')
    cat('\tHTTP Status Code:', object@status_code, '\n')
    cat(sprintf('\tHeaders (%d):\n', length(object@headers))) 
    for(name in names(object@headers))
    {
        cat(sprintf('\t\t%s: %s\n', name, object@headers[[name]]))
    }
}
#' Print information about a PushoverResponse object
#'
#' \code{show} prints information about a given
#' \code{\link{PushoverResponse-class}} object. This function is automatically
#' called when a
#' \code{PushoverResponse} object is referenced alone, when returned from a
#' function and not stored, or when \code{\link{show}} is called with a
#' \code{\link{PushoverResponse-class}} object.
#'
#' @export
#' @param object A \code{\link{PushoverResponse-class}} object
#' 
setMethod(f='show', signature='PushoverResponse',
          definition=show_PushoverResponse)


setGeneric("status", function(object) standardGeneric("status"))
#' Return the Pushover response status
#' 
#' Pushover API calls return a status code, which indicates the success of a
#' a query (1=success, 0=problem). The \code{status} method extracts the numeric
#' status code from a \code{\link{PushoverResponse-class}} object.
#' 
#' @export
#' @aliases status
#' @param object A \code{\link{PushoverResponse-class}} object
#' @return The numeric status value stored in the object (1=success, 0=problem)
#' @seealso \code{\link{is.success}}
#' 
setMethod("status", "PushoverResponse", function(object) return(object@status))


setGeneric("is.success", function(object) standardGeneric("is.success"))
#' Return whether a PushoverResponse indicated success (\code{TRUE}) or not
#' (\code{FALSE})
#' 
#' @export
#' @aliases is.success
#' @param object A \code{\link{PushoverResponse-class}} object
#' @return Whether the query was a success (\code{TRUE}) or not (\code{FALSE}
#' @seealso \code{\link{status}}
#' 
setMethod("is.success", "PushoverResponse",
          function(object) return(object@status==1))


setGeneric("request", function(object) standardGeneric("request"))
#' Return the Pushover response request token
#' 
#' Responses to Pushover queries include a unique request token. This method
#' returns the request token for the given PushoverResponse object.
#' 
#' @export
#' @aliases request
#' @param object A \code{\link{PushoverResponse-class}} object
#' @return The string request token included as response to a Pushover query
#' 
setMethod("request", "PushoverResponse",
          function(object) return(object@request))


setGeneric("http_status_code",
           function(object) standardGeneric("http_status_code"))
#' Return the HTTP status code returned by a Pushover API query
#' 
#' Get the HTTP status code returned from a Pushover API query. Successful
#' queries return 200, 4xx indicates query errors (see the \code{errors} list in
#' the \code{content} slot of a \code{PushoverResponse-class} object), and 500
#' indicates a connection problem.
#' 
#' @export
#' @aliases http_status_code
#' @param object A \code{\link{PushoverResponse-class}} object
#' @return The numeric HTTP status code used in response to a Pushover query
#' 
setMethod("http_status_code", "PushoverResponse",
          function(object) return(object@status_code))


setGeneric("headers", function(object) standardGeneric("headers"))
#' Get the HTTP headers returned by a Pushover API query
#' 
#' Aside from standard HTTP parameters, headers in Pushover API responses also
#' contain information about the application, including the app's limit on the
#' number of messages sent per month ('\code{x-limit-app-limit}'), how many
#' messages remain ('\code{x-limit-app-remaining}'), and when the message
#' counter will be reset ('\code{x-limit-app-reset}').
#' 
#' @export
#' @aliases headers
#' @param object A \code{\link{PushoverResponse-class}} object
#' @return A list of values from the HTTP header
#'
setMethod("headers", "PushoverResponse",
          function(object) return(object@headers))


setGeneric("content_value",
           function(object, param) standardGeneric("content_value"))
#' Get a value from a API query response
#' 
#' Pushover API calls return JSON data containing parameter-value data related
#' to the query. \code{content_value} extracts the value for a given parameter
#' from a \code{\link{PushoverResponse-class}} object.
#' 
#' @note All values are returned as strings. Numeric, date, and other types
#' should be coerced with \code{\link{as.numeric}}, etc.
#' 
#' @export
#' @aliases content_value
#' @param object A \code{\link{PushoverResponse-class}} object
#' @param param The name of a parameter in the response
#' @return A string containing the value associated with the given parameter.
#' @examples
#' \dontrun{
#' # Get the acknowledged status of an emergency message
#' message <- PushoverMessage(message='EMERGENCY!', priority=2,
#'                            token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                            user='uQiRzpo4DXghDmr9QzzfQu27cmVRsG')
#' response <- send(message)
#' acknowledged <- as.numeric(content_value(response, 'acknowledged'))
#' }
#' 
setMethod("content_value", "PushoverResponse",
          function(object, param) return(object@content[[param]]))


setGeneric("receipt", function(object) standardGeneric("receipt"))
#' Get the receipt from a Pushover server response  (M)
#' 
#' Receipts are unique tokens returned by Pushover servers in response to
#' emergency priority messages being sent. Receipts can be used to query whether
#' or not the message has been acknowledged, when, and by whom. This can be done
#' with \pkg{pushoverr} using either \code{\link{check_receipt}} or
#' \code{\link{is.acknowledged}}.
#' 
#' @export
#' @aliases receipt
#' @seealso \code{\link{check_receipt}}, \code{\link{is.acknowledged}} for
#' checking receipt status
#' @param object A \code{\link{PushoverResponse-class}} object containing a
#' response from Pushover following a request
#' @return A string containing a unique receipt token
#' @examples
#' \dontrun{
#' # Send an emergency message to a group, and see if it's been acknowledged
#' msg <- PushoverMessage(mesage='Get back to work',
#'                        token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                        user=' gznej3rKEVAvPUxu9vvNnqpmZpokzF')
#' response <- send(msg)
#' r <- receipt(response)
#' 
#' if(is.acknowledged(token='KzGDORePK8gMaC0QOYAMyEEuzJnyUi',
#'                    receipt=r))
#' {
#'     cat('Message has been read.\n')
#' }
#' }
#' 
setMethod("receipt", "PushoverResponse",
          function(object) return(content_value(object, 'receipt')))

