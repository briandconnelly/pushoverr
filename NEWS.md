# pushoverr 1.1.0 (2021-11-13)

## New Features

* Messages now support image attachments
* Messages now support basic HTML formatting and monospace text

## Breaking Changes

* Version 1.0.0 exposed a lot of internal functions that aren't needed for everyday use. These are no longer exported.

## Under the Hood Changes

* Using {checkmate} for input validation instead of {assertthat}
* Added unit testing with {testthat}


# pushoverr 1.0.0

* Reimplemented core functionality. No longer using S4 objects.
    * Removed `PushoverMessage` and `PushoverResponse` classes
    * Lots of source file reorganization
* several functions have been deprecated
    * `cancel_receipt` is deprecated in favor of `cancel_retries`
    * `is.valid_token` is deprecated in favor of `is.valid_app`
    * `validate_key` is deprecated in favor of `verify_user`
* User/group and application keys are now stored in environment variables instead of a package-specific environment, which makes it easier to store keys in .Renviron
* added support for the glances API (e.g., for smartwatches) via `update_glance()`
* added `is.valid_pushover_sound` function to validate sound arguments
* added `get_pushover_limits` function to retrieve application message limit and usage information
* added `stop_for_pushover_status` to handle errors for all API requests
* added functions for working with groups:
    * `get_group_info` retrieves information about a group
    * `group_rename` renames a group
    * `group_add_user` and `group_remove_user` adds or removes a user from a group
    * `group_disable_user` and `group_enable_user` temporarily disable and re-enable a user's group membership
* Project now has a Contributer Code of Conduct

# pushoverr 0.1.4

* Added cancel_receipt function to cancel an emergency message
* Removed the port number from API calls

# pushoverr 0.1.3

* Added support for -2 priority messages ('silent'): http://updates.pushover.net/post/87000633097/api-change-to-message-priority-1-new-priority-2

# pushoverr 0.1.2

* Fixed small issue with user/token storage, which allowed similarly named variables outside the namespace to be used
* pushover_* helper functions now return invisible values. Request tokens can still be saved to a variable, but will not be printed when the functions are not part of an assignment operation. The return values of `pushover_high` are visible.

# pushoverr 0.1.1

* Updates for CRAN submission

# pushoverr 0.1.0

* Initial public release
