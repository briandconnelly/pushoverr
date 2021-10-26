#' Get a list of sounds available for Pushover notifications
#'
#' @param app application token (see [`set_pushover_app()`])
#'
#' @return A list of available sounds and their descriptions.
#' @export
#'
#' @examples
#' \dontrun{
#' get_pushover_sounds(app = "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
#' }
get_pushover_sounds <- function(app = get_pushover_app()) {
  assert_valid_app(app)

  response <- pushover_api(
    verb = "GET",
    url = "https://api.pushover.net/1/sounds.json",
    query = list(token = app)
  )
  response$sounds
}
