valid_call <- function(message = "Hello",
                       title = NULL,
                       priority = 0,
                       user = get_pushover_user(),
                       app = get_pushover_app(),
                       device = NULL,
                       sound = NULL,
                       url = NULL,
                       url_title = NULL,
                       retry = 60,
                       expire = 3600,
                       callback = NULL,
                       timestamp = NULL) {
  pushover(
    message = message,
    title = title,
    priority = priority,
    user = user,
    app = app,
    device = device,
    sound = sound,
    url = url,
    url_title = url_title,
    retry = retry,
    expire = expire,
    callback = callback,
    timestamp = timestamp
  )
}

test_that("input validation works", {
  # Message should be a non-empty scalar string
  expect_error(valid_call(message = ""))
  expect_error(valid_call(message = NA_character_))
  expect_error(valid_call(message = 21))
  expect_error(valid_call(message = c("msg 1", "msg 2")))

  # Title should be a scalar string. Empty is ok.
  expect_error(valid_call(title = NA_character_))
  expect_error(valid_call(title = 21))
  expect_error(valid_call(title = TRUE))
  expect_error(valid_call(title = c("msg 1", "msg 2")))

  # priority should be an integer in [-2,2]
  expect_error(valid_call(priority = NULL))
  expect_error(valid_call(priority = NA))
  expect_error(valid_call(priority = "0"))
  expect_error(valid_call(priority = c(0, 1)))
  expect_error(valid_call(priority = -3))
  expect_error(valid_call(priority = 0.1))
  expect_error(valid_call(priority = 3))

  # user should be a non-empty scalar string
  expect_error(valid_call(user = ""))
  expect_error(valid_call(user = NA_character_))
  expect_error(valid_call(user = 21))
  expect_error(valid_call(user = c("uQiRzpo4DXghDmr9QzzfQu27cmVRsG", "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")))

  # app should be a non-empty scalar string
  # TODO

  # device should be a non-empty string with 1+ items
  # TODO

  # sound should be a non-empty scalar string
  # TODO

  # TODO: others
})
