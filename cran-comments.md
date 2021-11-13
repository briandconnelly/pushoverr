## Release Overview

* New release adding attachments and formatting options to messages
* No breaking API changes, so any dependencies should be unaffected
* Added proper quoting and URL syntax to Description

## Test Environments

* local: macOS 11.6.1, 4.1.2
* github actions
  * macOS-latest (release)
  * windows-latest (release)
  * windows-latest (3.6)
  * ubuntu-18.04 (devel)
  * ubuntu-18.04 (release)
  * ubuntu-18.04 (oldrel-1)
  * ubuntu-18.04 (oldrel-2)
  * ubuntu-18.04 (oldrel-3)
  * ubuntu-18.04 (oldrel-4)
* r-hub (via `rhub::check_for_cran()`)
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran

## R CMD check results

0 errors | 0 warnings | 0 notes

