valid_verify <- function(fn = verify_user,
                         user = "uQiRzpo4DXghDmr9QzzfQu27cmVRsG",
                         app = "azGDORePK8gMaC0QOYAMyEEuzJnyUi",
                         device = NULL) {
  fn(
    user = user,
    app = app,
    device = device
  )
}

test_that("input validation works", {
  # Verify group is an alias of verify_user

  for (fn in c(verify_user, verify_group)) {
    expect_error(valid_verify(fn, user = ""))
    expect_error(valid_verify(fn, user = NA_character_))
    expect_error(valid_verify(
      fn,
      user = c(
        "uQiRzpo4DXghDmr9QzzfQu27cmVRsG",
        "uQiRzpo4DXghDmr9QzzfQu27cmVRsG"
      )
    ))

    expect_error(valid_verify(fn, app = ""))
    expect_error(valid_verify(fn, app = NA_character_))
    expect_error(valid_verify(fn, app = "notanapp"))
    expect_error(valid_verify(fn, app = "azGDORePKQOYAMyEEuzJnyUi"))
    expect_error(valid_verify(
      fn,
      app = c(
        "azGDORePK8gMaC0QOYAMyEEuzJnyUi",
        "azGDORePK8gMaC0QOYAMyEEuzJnyUi"
      )
    ))

    expect_error(valid_verify(fn, device = ""))
    expect_error(valid_verify(fn, device = c("phone", "tablet")))
  }
})
