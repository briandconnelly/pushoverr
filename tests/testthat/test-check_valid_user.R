test_that("X_valid_user functions work as expected", {
  expect_true(is.character(check_valid_user(21)))
  expect_true(is.character(check_valid_user(21)))
  expect_true(is.character(check_valid_user(NA_character_)))
  expect_true(is.character(check_valid_user("")))
  expect_true(is.character(check_valid_user(NULL)))
  expect_true(is.character(check_valid_user("notauser")))
  expect_true(check_valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG"))

  expect_false(test_valid_user(21))
  expect_false(test_valid_user(NA_character_))
  expect_false(test_valid_user(""))
  expect_false(test_valid_user(NULL))
  expect_false(test_valid_user("notauser"))

  expect_true(test_valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG"))
  expect_false(
    test_valid_user(
      c("uQiRzpo4DXghDmr9QzzfQu27cmVRsG", "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
    )
  )

  expect_error(assert_valid_user(21))
  expect_error(assert_valid_user(NA_character_))
  expect_error(assert_valid_user(""))
  expect_error(assert_valid_user(NULL))
  expect_error(assert_valid_user("notauser"))
  expect_error(
    assert_valid_user(
      c("uQiRzpo4DXghDmr9QzzfQu27cmVRsG", "uQiRzpo4DXghDmr9QzzfQu27cmVRsG")
    )
  )
})


test_that("X_valid_group functions work as expected", {
  expect_true(is.character(check_valid_group(21)))
  expect_true(is.character(check_valid_group(21)))
  expect_true(is.character(check_valid_group(NA_character_)))
  expect_true(is.character(check_valid_group("")))
  expect_true(is.character(check_valid_group(NULL)))
  expect_true(is.character(check_valid_group("notagroup")))
  expect_true(check_valid_group("gznej3rKEVAvPUxu9vvNnqpmZpokzF"))

  expect_false(test_valid_group(21))
  expect_false(test_valid_group(NA_character_))
  expect_false(test_valid_group(""))
  expect_false(test_valid_group(NULL))
  expect_false(test_valid_group("notagroup"))

  expect_true(test_valid_group("gznej3rKEVAvPUxu9vvNnqpmZpokzF"))
  expect_false(
    test_valid_group(
      c("gznej3rKEVAvPUxu9vvNnqpmZpokzF", "gznej3rKEVAvPUxu9vvNnqpmZpokzF")
    )
  )

  expect_error(assert_valid_group(21))
  expect_error(assert_valid_group(NA_character_))
  expect_error(assert_valid_group(""))
  expect_error(assert_valid_group(NULL))
  expect_error(assert_valid_group("notagroup"))
  expect_error(
    assert_valid_group(
      c("gznej3rKEVAvPUxu9vvNnqpmZpokzF", "gznej3rKEVAvPUxu9vvNnqpmZpokzF")
    )
  )
})
