env <- new.env()

.onAttach <- function(libname, pkgname)
{
    packageStartupMessage(paste('loading',libname,pkgname,'\n'))
}

# TODO: document
#' @export
set_user <- function(user)
{
    if(missing(user)) stop('must provide user/group key')
    # This can only be checked if the API token is set. Do a regexp test?
    #if(!is.valid_key(user)) stop('invalid user/group key')
    assign('user', user, envir=env)
}

# TODO: document
#' @export
set_group <- function(group) set_user(group)

# TODO: document
#' @export
get_user <- function() return(get('user', envir=env))
get_group <- function() return(get_user())


# TODO: document
#' @export
set_token <- function(token)
{
    if(missing(token)) stop('must provide application token')
    if(!is.valid_token(token)) stop('invalid application token')
    assign('token', token, envir=env)
}

#' @export
get_token <- function() return(get('token', envir=env))
