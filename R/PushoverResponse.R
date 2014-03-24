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
          function(object) return(object@headers))