fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios build_adhoc

```sh
[bundle exec] fastlane ios build_adhoc
```

Build release version and store it in build/ios/outputs; use adhoc profile for firebase

### ios distribute_to_firebase

```sh
[bundle exec] fastlane ios distribute_to_firebase
```

Distribute previously built to firebase, upload crashlytics symbols at the same time

### ios build_and_distribute

```sh
[bundle exec] fastlane ios build_and_distribute
```

Build and distribute all

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
