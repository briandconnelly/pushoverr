test_that("X_valid_device functions work as expected", {
  expect_true(is.character(check_valid_device(21)))
  expect_true(is.character(check_valid_device(NA_character_)))
  expect_true(is.character(check_valid_device("")))
  expect_true(is.character(check_valid_device(NULL)))
  expect_true(is.character(check_valid_device(paste0(LETTERS, collapse = ""))))
  expect_true(check_valid_device("phone"))

  expect_false(test_valid_device(21))
  expect_false(test_valid_device(NA_character_))
  expect_false(test_valid_device(""))
  expect_false(test_valid_device(NULL))
  expect_false(test_valid_device(paste0(LETTERS, collapse = "")))

  expect_true(test_valid_device("phone"))
  expect_false(
    test_valid_device(
      c("phone", "tablet")
    )
  )

  expect_error(assert_valid_device(21))
  expect_error(assert_valid_device(NA_character_))
  expect_error(assert_valid_device(""))
  expect_error(assert_valid_device(NULL))
  expect_error(assert_valid_device(paste0(LETTERS, collapse = "")))
  expect_equal(assert_valid_device("phone"), "phone")
  expect_error(
    assert_valid_device(
      c("phone", "tablet")
    )
  )
})
