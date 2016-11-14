#' Raise an Error if Pushover Request Failed
#' 
#' Examines a response from a Pushover API call for errors. If there were
#' errors, execution is stopped, and an error message is shown.
#'
#' @param x a \code{\link[httr]{response}} object returned by an API call
#'
#' @return If request was successful, the response (invisibly).
#' @export
#'
stop_for_pushover_status <- function(x) {
    code <- httr::status_code(x)
    response <- httr::content(x)

    if (response$status == 1 && floor(code / 100) == 2) {
        return(invisible(x))
    }
    else {
        msg <- sprintf("%s - %s", httr::http_status(code)$message,
                       paste0(response$errors, collapse = "; "))
        stop(msg, call. = FALSE)
    }
}
