test_that("X_valid_receipt functions work as expected", {
  expect_true(is.character(check_valid_receipt(21)))
  expect_true(is.character(check_valid_receipt(21)))
  expect_true(is.character(check_valid_receipt(NA_character_)))
  expect_true(is.character(check_valid_receipt("")))
  expect_true(is.character(check_valid_receipt(NULL)))
  expect_true(is.character(check_valid_receipt("KAWXTswy4cekx6vZbHBK")))
  expect_true(check_valid_receipt("KAWXTswy4cekx6vZbHBKbCKk1c1fdf"))

  expect_false(test_valid_receipt(21))
  expect_false(test_valid_receipt(NA_character_))
  expect_false(test_valid_receipt(""))
  expect_false(test_valid_receipt(NULL))
  expect_false(test_valid_receipt("KAWXTswy4cekx6vZbHBKbCKk1c1fdfBAD"))

  expect_true(test_valid_receipt("KAWXTswy4cekx6vZbHBKbCKk1c1fdf"))
  expect_false(
    test_valid_receipt(
      c("KAWXTswy4cekx6vZbHBKbCKk1c1fdf", "KAWXTswy4cekx6vZbHBKbCKk1c1fdf")
    )
  )

  expect_error(assert_valid_receipt(21))
  expect_error(assert_valid_receipt(NA_character_))
  expect_error(assert_valid_receipt(""))
  expect_error(assert_valid_receipt(NULL))
  expect_error(assert_valid_receipt(paste0(LETTERS, collapse = "")))
  expect_error(
    assert_valid_receipt(
      c("azGDORePK8gMaC0QOYAMyEEuzJnyUi", "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
    )
  )
})
