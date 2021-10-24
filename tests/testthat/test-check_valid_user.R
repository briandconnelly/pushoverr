test_that("input validation (check_valid_user)", {
  expect_false(test_valid_user(21))
  expect_false(test_valid_user(NA_character_))
  expect_false(test_valid_user(""))
  expect_false(test_valid_user(NULL))
  expect_error(assertthat::assert_that(test_valid_user("notauser")))

  expect_true(test_valid_user("uQiRzpo4DXghDmr9QzzfQu27cmVRsG"))
})

test_that("input validation (is.valid_group)", {
  expect_false(test_valid_group(21))
  expect_false(test_valid_group(NA_character_))
  expect_false(test_valid_group(""))
  expect_false(test_valid_group(NULL))
  expect_error(assertthat::assert_that(test_valid_group("notagroup")))

  expect_true(test_valid_group("gznej3rKEVAvPUxu9vvNnqpmZpokzF"))
})
