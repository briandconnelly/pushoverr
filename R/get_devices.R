#' Get a list of the user's registered devices
#'
#' `get_devices()` queries the Pushover API for a list of the devices that
#' have been registered by the given user
#'
#' @param user Pushover user key (see [`set_pushover_user()`])
#' @param app Pushover application token (see [`set_pushover_app()`])
#'
#' @return `get_devices()` returns a list of device names registered by the
#' given user
#' @export
#'
#' @examples
#' \dontrun{
#' get_devices(
#'   user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG",
#'   app = "azGDORePK8gMaC0QOYAMyEEuzJnyUi"
#' )
#' }
get_devices <- function(user = get_pushover_user(), app = get_pushover_app()) {
  result <- verify_user(
    user = assert_valid_user(user),
    app = assert_valid_app(app)
  )
  unlist(result$devices)
}


#' @rdname get_devices
#' @description `is.registered_device()` determines whether the given device is
#' registered to the given user
#' @param device The name of a device
#' @return `is.registered_ device()` returns a logical value for each of the
#' given devices that indicates whether or not that device is registered to the
#' given user.
#' @export
#' @examples
#' \dontrun{
#' is.registered_device(device = "phone")
#' }
is.registered_device <- function(device,
                                 user = get_pushover_user(),
                                 app = get_pushover_app()) {
  checkmate::assert_string(device, min.chars = 1)
  device %in% get_devices(user = user, app = app)
}
