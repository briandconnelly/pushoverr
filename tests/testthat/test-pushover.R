valid_call <- function(message = "Hello",
                       title = NULL,
                       priority = 0,
                       attachment = NULL,
                       user = get_pushover_user(),
                       app = get_pushover_app(),
                       device = NULL,
                       sound = NULL,
                       url = NULL,
                       url_title = NULL,
                       format = "html",
                       retry = 60,
                       expire = 3600,
                       callback = NULL,
                       timestamp = NULL) {
  pushover(
    message = message,
    title = title,
    priority = priority,
    attachment = attachment,
    user = user,
    app = app,
    device = device,
    sound = sound,
    url = url,
    url_title = url_title,
    format = format,
    retry = retry,
    expire = expire,
    callback = callback,
    timestamp = timestamp
  )
}

random_string <- function(n) {
  paste0(sample(c(LETTERS, letters, 0:9), n, replace = TRUE), collapse = "")
}

test_that("input validation works", {
  # Message should be a non-empty scalar string
  expect_error(valid_call(message = ""))
  expect_error(valid_call(message = random_string(1025)))
  expect_error(valid_call(message = NA_character_))
  expect_error(valid_call(message = 21))
  expect_error(valid_call(message = c("msg 1", "msg 2")))

  # Title should be a scalar string <= 250 chars. Empty is ok.
  expect_error(valid_call(title = NA_character_))
  expect_error(valid_call(title = 21))
  expect_error(valid_call(title = TRUE))
  expect_error(valid_call(title = c("msg 1", "msg 2")))
  expect_error(valid_call(title = random_string(251)))

  # priority should be an integer in [-2,2]
  expect_error(valid_call(priority = NULL))
  expect_error(valid_call(priority = NA))
  expect_error(valid_call(priority = "0"))
  expect_error(valid_call(priority = c(0, 1)))
  expect_error(valid_call(priority = -3))
  expect_error(valid_call(priority = 0.1))
  expect_error(valid_call(priority = 3))

  # attachment must be a file
  expect_error(valid_call(attachment = NA_character_))
  expect_error(valid_call(attachment = ""))
  expect_error(valid_call(attachment = 3))
  expect_error(valid_call(attachment = "/blah/notafile.jpg"))

  # user should be a non-empty scalar string
  expect_error(valid_call(user = ""))
  expect_error(valid_call(user = NA_character_))
  expect_error(valid_call(user = 21))
  expect_error(valid_call(
    user = c("uQiRzpo4DXghDmr9QzzfQu27cmVRsG", "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
  ))

  # app should be a non-empty scalar string, length 30
  expect_error(valid_call(app = ""))
  expect_error(valid_call(app = NA_character_))
  expect_error(valid_call(app = 21))
  expect_error(valid_call(app = random_string(12)))

  # device should be a non-empty string, length [1,25]
  expect_error(valid_call(device = ""))
  expect_error(valid_call(device = NA_character_))
  expect_error(valid_call(device = random_string(26)))

  # sound should be a non-empty scalar string
  expect_error(valid_call(sound = ""))
  expect_error(valid_call(sound = NA_character_))
  expect_error(valid_call(sound = 21))
  expect_error(valid_call(sound = "notasound"))

  # If specified, url should be a string with <= 512 chars
  expect_error(valid_call(url = ""))
  expect_error(valid_call(url = NA_character_))
  expect_error(valid_call(url = 21))
  expect_error(valid_call(url = random_string(513)))

  # If specified, url should be a string with <= 100 chars
  expect_error(valid_call(url_title = ""))
  expect_error(valid_call(url_title = NA_character_))
  expect_error(valid_call(url_title = 21))
  expect_error(valid_call(url_title = random_string(101)))

  # Format should be either 'html' or 'monospace'
  expect_error(valid_call(format = ""))
  expect_error(valid_call(format = NA_character_))
  expect_error(valid_call(format = NULL))
  expect_error(valid_call(format = 21))
  expect_error(valid_call(format = "word"))

  # Retry is an integer >= 30
  expect_error(valid_call(retry = 20))
  expect_error(valid_call(retry = FALSE))
  expect_error(valid_call(retry = NA_integer_))
  expect_error(valid_call(retry = 34.56789))
  expect_error(valid_call(retry = 60, expire = 45))

  # Expire is an integer <= 10800
  expect_error(valid_call(retry = 10801))
  expect_error(valid_call(retry = FALSE))
  expect_error(valid_call(retry = NA_integer_))
  expect_error(valid_call(retry = 123.456789))

  # Callback is a string (length limit unknown)
  expect_error(valid_call(callback = ""))
  expect_error(valid_call(callback = NA_character_))
  expect_error(valid_call(callback = 21))

  # Timestamp is a count
  expect_error(valid_call(timestamp = -1))
  expect_error(valid_call(callback = NA_integer_))
  expect_error(valid_call(callback = 21.214142))
})
