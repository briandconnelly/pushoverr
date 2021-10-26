test_that("X_valid_app functions work as expected", {
  expect_true(is.character(check_valid_app(21)))
  expect_true(is.character(check_valid_app(21)))
  expect_true(is.character(check_valid_app(NA_character_)))
  expect_true(is.character(check_valid_app("")))
  expect_true(is.character(check_valid_app(NULL)))
  expect_true(is.character(check_valid_app("azGDORePKQOYAMyEEuzJnyUi")))
  expect_true(check_valid_app("azGDORePK8gMaC0QOYAMyEEuzJnyUi"))

  expect_false(test_valid_app(21))
  expect_false(test_valid_app(NA_character_))
  expect_false(test_valid_app(""))
  expect_false(test_valid_app(NULL))
  expect_false(test_valid_app("azGDORePKQOYAMyEEuzJnyUi"))

  expect_true(test_valid_app("azGDORePK8gMaC0QOYAMyEEuzJnyUi"))
  expect_false(
    test_valid_app(
      c("azGDORePK8gMaC0QOYAMyEEuzJnyUi", "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
    )
  )

  expect_error(assert_valid_app(21))
  expect_error(assert_valid_app(NA_character_))
  expect_error(assert_valid_app(""))
  expect_error(assert_valid_app(NULL))
  expect_error(assert_valid_app("azGDORePKQOYAMyEEuzJnyUi"))
  expect_error(
    assert_valid_app(
      c("azGDORePK8gMaC0QOYAMyEEuzJnyUi", "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
    )
  )
})
