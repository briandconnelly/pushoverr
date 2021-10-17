test_that("input validation", {
  expect_false(is.valid_app(21))
  expect_false(is.valid_app(NA_character_))

  expect_true(is.valid_app("azGDORePK8gMaC0QOYAMyEEuzJnyUi"))
  expect_true(
    all(
      is.valid_app(
        c("azGDORePK8gMaC0QOYAMyEEuzJnyUi", "azGDORePK8gMaC0QOYAMyEEuzJnyUi")
      )
    )
  )
})
