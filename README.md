# Time Tracking app with Flutter & Firebase

A time tracking application built with Flutter & Firebase: 

![](/.github/images/time-tracker-screenshots.png)

This is a toy project based on Andrea Bizotto's starter architecture with Riverpod. 


## Features

- **Simple onboarding page**
- **Full authentication flow** with email/password and other providers
- **Topology**: A user can define their own categories and jobs
- **Entries**: for each job, user can view, create, edit, and delete the corresponding entries (an entry is a task with a start and end time, with an optional comment)
- **Timer**: on the start page, the user can close one job and open another 
- **A report page (TBD)** that shows a daily breakdown of all jobs, hours worked and pay, along with the totals.

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

Tests will generate firestore data for tester1@foo.bar account.
```bash
firebase emulators:start --export-on-exit --import ./data
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshots_test.dart -d emulator-5554
cp screenshots/tmp screenshots/pixel_2
```
## [License: MIT](LICENSE.md)
