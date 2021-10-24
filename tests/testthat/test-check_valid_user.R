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
