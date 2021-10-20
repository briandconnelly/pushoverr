test_that("input validation (is.valid_app)", {
  expect_false(is.valid_app(21))
  expect_false(is.valid_app(NA_character_))
  expect_false(is.valid_app(""))
  expect_false(is.valid_app("azGDORePKQOYAMyEEuzJnyUi"))

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
  expect_false(is.valid_device(21))
  expect_false(is.valid_device(NA_character_))
  expect_false(is.valid_device(""))
  expect_false(is.valid_device(paste0(LETTERS, collapse = "")))

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
  expect_false(is.valid_receipt(paste0(LETTERS, collapse = "")))
})
