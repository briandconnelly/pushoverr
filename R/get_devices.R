#' Get a list of the user's registered devices
#'
#' \code{get_devices} queries the Pushover API for a list of the devices that
#' have been registered by the given user
#'
#' @param user Pushover user key (see \code{\link{set_pushover_user}})
#' @param app Pushover application token (see \code{\link{set_pushover_app}})
#'
#' @return \code{get_devices} returns a list of device names registered by the
#' given user
#' @export
#'
#' @examples
#' \dontrun{
#' get_devices(user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG", app = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' }
get_devices <- function(user = get_pushover_user(), app = get_pushover_app()) {
    assertthat::assert_that(assertthat::is.scalar(user), is.valid_user(user))
    assertthat::assert_that(assertthat::is.scalar(app), is.valid_app(app))

    result <- verify_user(user = user, app = app)
    unlist(result$devices)
}


#' @rdname get_devices
#' @description \code{is.device} determines whether the given device is
#' registered to the given user
#' @param device The name of a device
#' @return \code{is.device} returns a logical value for each of the given
#' devices that indicates whether (\code{TRUE}) or not (\code{FALSE}) that
#' device is registered to the given user.
#' @export
#' @examples
#' \dontrun{
#' is.device(device = "phone")
#' }
is.device <- function(device,
                      user = get_pushover_user(),
                      app = get_pushover_app()) {
    device %in% get_devices(user = user, app = app)
}
