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
