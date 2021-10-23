test_that("input validation (is.valid_app)", {
  expect_false(is.valid_app(21))
  expect_false(is.valid_app(NA_character_))
  expect_false(is.valid_app(""))
  expect_false(is.valid_app(NULL))
  expect_false(is.valid_app("azGDORePKQOYAMyEEuzJnyUi"))
  expect_error(assertthat::assert_that(is.valid_app(NA_character_)))

  expect_true(is.valid_app("azGDORePK8gMaC0QOYAMyEEuzJnyUi"))
  expect_true(
    all(
      is.valid_app(
        c("azGDORePK8gMaC0QOYAMyEEuzJnyUi", "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
      )
    )
  )
})

test_that("input validation (is.valid_device)", {
  expect_false(is.valid_device(NA_character_))
  expect_false(is.valid_device(""))
  expect_false(is.valid_device(NULL))
  expect_false(is.valid_device(paste0(LETTERS, collapse = "")))
  expect_error(assertthat::assert_that(is.valid_device(NA_character_)))

  expect_true(is.valid_device("my_phone"))
  expect_true(
    all(
      is.valid_device(
        c("my_phone", "my_tablet")
      )
    )
  )
})

test_that("input validation (is.valid_receipt)", {
  expect_false(is.valid_receipt(21))
  expect_false(is.valid_receipt(NA_character_))
  expect_false(is.valid_receipt(""))
  expect_false(is.valid_receipt(NULL))
  expect_false(is.valid_receipt(paste0(LETTERS, collapse = "")))
  expect_error(assertthat::assert_that(is.valid_receipt(NA_character_)))
})

test_that("input validation (is.valid_user)", {
  expect_false(is.valid_user(21))
  expect_false(is.valid_user(NA_character_))
  expect_false(is.valid_user(""))
  expect_false(is.valid_user(NULL))
  expect_error(assertthat::assert_that(is.valid_user("notauser")))

  expect_true(is.valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG"))
})

test_that("input validation (is.valid_group)", {
  expect_false(is.valid_group(21))
  expect_false(is.valid_group(NA_character_))
  expect_false(is.valid_group(""))
  expect_false(is.valid_group(NULL))
  expect_error(assertthat::assert_that(is.valid_group("notagroup")))

  expect_true(is.valid_group("gznej3rKEVAvPUxu9vvNnqpmZpokzF"))
})

test_that("input validation (is.valid_sound)", {
  expect_false(is.valid_sound(21))
  expect_false(is.valid_sound(NA_character_))
  expect_false(is.valid_sound(""))
  expect_false(is.valid_sound(NULL))
  expect_false(is.valid_sound("notasound"))
  expect_false(all(is.valid_sound(c("notasound", sample(pushover_sounds, 2)))))
  expect_error(assertthat::assert_that(is.valid_sound("notasound")))

  expect_true(is.valid_sound(sample(pushover_sounds, 1)))
  expect_true(all(is.valid_sound(sample(pushover_sounds, 3))))
  expect_true(
    assertthat::assert_that(is.valid_sound(sample(pushover_sounds, 1)))
  )
})
