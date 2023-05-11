# Time Tracking app with Flutter & Firebase

A time tracking application built with Flutter & Firebase:

![](/.github/images/time-tracker-screenshots.png)

This is a toy project based on Andrea Bizotto's starter architecture with Riverpod.

## Features

- **Simple onboarding page**
- **Full authentication flow** with email/password and other providers
- **Topology**: A user can define their own categories and jobs
- **Entries**: for each job, user can view, create, edit, and delete the corresponding entries (an
  entry is a task with a start and end time, with an optional comment)
- **Timer**: on the start page, the user can close one job and open another
- **A report page (TBD)** that shows a daily breakdown of all jobs, hours worked and pay, along with
  the totals.

All the data is persisted with Firestore and is kept in sync across multiple devices.

## Roadmap

- [ ] more tests
- [ ] additional auth providers
- [ ] android support

## Generate firebase config

```bash
firebase login
firebase configure
```

## Run code generator for riverpod

```
flutter pub run build_runner watch -d
```

## Firebase rules and indexe

```bash
firebase init firestore 
firebase deploy --only firestore:rules
```

## Build and deploy to ios

```bash
flutter build ios --release --no-codesign --config-only
cd ios
bundle exec fastlane ios build_and_distribute  
```

## Run integration tests to generate screen shots

### Start firebase emulators

The Auth emulator is preseeded with two tester accounts. If those get regenerated, update the tests
with the new uid

The Firestore emulator gets wiped and seeded multiple times during the test, but only for the UID
matching the tester1@foo.bar account.

```bash
firebase emulators:start --export-on-exit --import ./data
```

## Android

### Start an android  emulator

This is a bit tricky, since `flutter emulator` shows a list of available emulator ids but the tests
need to be started with the device id. That one is only available once the emulator has been
started, and it changes.

For best results, close all open emulators, then start one at a time which will likely use device
id `emulator-5560`

Available emulators (check with `flutter emulators`):
IOS
apple_ios_simulator • iOS Simulator   • Apple  • ios

Android
* Nexus_10_API_33     • Nexus 10 API 33 • Google • android
* Nexus_7_API_33      • Nexus 7 API 33  • Google • android
* Pixel_2_API_33      • Pixel 2 API 33  • Google • android
* Pixel_6_API_33      • Pixel 6 API 33  • User   • android

### Kill an emulator

To kill use `adb devices`. `flutter devices` works as well but the output is more chatty

```bash
adb devices
## for each emulator_55xx
adb -s emulator-5554 emu kill 
```
Or kill all with this:
```bash
adb devices | grep emulator | cut -f1 | while read line; do adb -s $line emu kill; done
```

### Actually generate the screenshots for one device
```bash
flutter emulators --launch Nexus_10_API_33 
## check that the id is really emulator-5554
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshots_test.dart -d emulator-5554

cp screenshots/tmp screenshots/nexus_10_portrait

```

### Upload via fastlane supply

Move the generated output to fastlane/metadata

```bash
bundle exec fastlane supply --skip_upload_changelogs
```


## IOS

### Start an android emulator

Get a list of all available simulators. If the right one isn't available, create it.

```bash
xcrun simctl list
```

Find the device id of the simulator you want. Start it, then run the tests
```bash
open -a simulator --args -CurrentDeviceUDID 5DDF4716-EA15-4109-8F87-11E65126F940
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshots_test.dart -d 5DDF4716-EA15-4109-8F87-11E65126F940
```

the output needs to be renamed, can't just be dumped into a directory like with android

### Upload with fastlane

First download meta info once
```bash
bundle exec fastlane deliver init
bundle exec fastlane deliver download_screenshots
```

Afterwards, build and upload to testflight, check, fix assets, promote to appstore 
and include screenshots


## [License: MIT](LICENSE.md)
