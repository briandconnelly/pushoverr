#' The PushoverResponse class
#' 
#' PushoverResponse objects store information from responses to Pushover queries
#' 
#' @name PushoverResponse
#' @exportClass PushoverResponse
#' @slot status TODO
#' @slot request TODO
#' @slot status_code TODO
#' @slot headers
#' @slot content
#' 
# @usage 
#' ## Create PushoverResponse object
#' # TODO
#' PushoverResponse(TODO)
#' 
#' @slot nrow The number of rows in the microtiter plate (\code{numeric})
#' @slot ncol The number of columns in the microtiter plate (\code{numeric})
#' @slot attributes Collection of 0+ name-value pairs describing any important
#' attributes of the microtiter plate (\code{list})
#' @slot wellgroups Collection of 0+ \code{\link{WellGroup}} objects that
#' describe logical groupings of wells (\code{list})

PushoverResponse <- setClass('PushoverResponse',
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

# TODO: document
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

# TODO: document
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
setMethod('show', 'PushoverResponse', show_PushoverResponse)

setGeneric("status", function(object) standardGeneric("status"))
setMethod("status", "PushoverResponse", function(object) return(object@status))

setGeneric("is.success", function(object) standardGeneric("is.success"))
setMethod("is.success", "PushoverResponse",
          function(object) return(object@status==1))


setGeneric("request", function(object) standardGeneric("request"))
setMethod("request", "PushoverResponse", function(object) return(object@request))


setGeneric("http_status_code", function(object) standardGeneric("http_status_code"))
setMethod("http_status_code", "PushoverResponse",
          function(object) return(object@status_code))


setGeneric("headers", function(object) standardGeneric("headers"))
setMethod("headers", "PushoverResponse",
          function(object) return(object@headers))


setGeneric("app_limit", function(object) standardGeneric("app_limit"))
setMethod("app_limit", "PushoverResponse",
          function(object) return(object@headers[['x-limit-app-limit']]))


setGeneric("app_remaining", function(object) standardGeneric("app_remaining"))
setMethod("app_remaining", "PushoverResponse",
          function(object) return(object@headers[['x-limit-app-remaining']]))

setGeneric("get_response_content", function(object, param) standardGeneric("get_response_content"))
setMethod("get_response_content", "PushoverResponse",
          function(object, param) return(object@content[[param]]))

setGeneric("receipt", function(object) standardGeneric("receipt"))
setMethod("receipt", "PushoverResponse",
          function(object) return(get_response_content(object, 'receipt')))
