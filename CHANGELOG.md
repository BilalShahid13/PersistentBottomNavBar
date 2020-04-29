# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.1] - 2020-04-29

- Improvements to readme.

## [1.4.0] - 2020-04-29

- Implemented handling of the Android back button.
- Fixed the issue where the app would not close at all on Android back button press.
- Updated navigation bar height to give it the default platform look.
- Updated styles to fix the issue where a tap would not be registered.

## [1.3.0] - 2020-04-25

- Incorporated the much requested ability to customize your own bottom navigation bar widget.
- Android's back button will no longer close the app.

## [1.2.1] - 2020-03-23

- Fixed centering of label text in style 1, 7, 9 and 10.

## [1.2.0] - 2020-03-20

- Added `navBarHeight` and `floatingActionWidget` properties, some bug fixes and (```BREAKING CHANGE```) `isCurved` property is now replaced with `navBarCurve` which accepts `NavBarCurve`.

## [1.1.5] - 2020-03-04

- Fixed issue for style 6 and 8 where a tap would not be registered occasionally.

## [1.1.4] - 2020-03-03

- Bug fixes and improvements for style 6 and 8.

## [1.1.3] - 2020-03-02

- Bug fixes.

## [1.1.2] - 2020-03-01

- Updated project description.

## [1.1.1] - 2020-03-01

- Memory leakage improvements.

## [1.1.0] - 2020-03-01

- Added `Neumorphic` design for the navigation bar.
- Scale animations for style 7 and 8.
- More control over translucency.
- Bug fixes and improvements.

## [1.0.15] - 2020-01-27

- bug fixes.

## [1.0.14] - 2020-01-27

- Fixed `showElevation` invisible shadow issue.

## [1.0.13] - 2020-01-27

- bug fixes.

## [1.0.12] - 2020-01-27

- Increased space between icon and text for most styles (can be reverted by the use of `bottomPadding` property).

## [1.0.11] - 2020-01-27

- bug fixes.

## [1.0.10] - 2020-01-26

- bug fixes.

## [1.0.9+2] - 2020-01-26

- transparency color improvements.

## [1.0.9+1] - 2020-01-26

- bug fixes.

## [1.0.9] - 2020-01-26

- Added `isTranslucent` property for `PersistentBottomNavBarItem`.
- Tweaked `style8` and `style9`'s magnification.

## [1.0.8] - 2020-01-24

- Fixed error thrown if `onItemSelected` was not declared.
- Wrapped screens with `Material` for material elements.

## [1.0.7+4] - 2020-01-23

- Updated README file.

## [1.0.7+3] - 2020-01-20

- Updated `style10`'s and `style7`'s shadow.

## [1.0.7+2] - 2020-01-20

- Updated `style10`'s and `style7`'s shadow.

## [1.0.7+1] - 2020-01-20

- Updated `style10`'s borders.

## [1.0.7] - 2020-01-20

- Updated `style8`'s text magnification and added new `style10`.

## [1.0.6+1] - 2020-01-20

- Updated navigator functions' arguments `BREAKING CHANGE`.

## [1.0.6] - 2020-01-20

- Updated navigator functions' arguments and added a new nav bar style.

## [1.0.5] - 2020-01-18

- Updated return type of navigator functions.

## [1.0.4] - 2020-01-16

- Added function for pushing `modal` screens.

## [1.0.3+5] - 2020-01-16

- Updated style8's magnification.

## [1.0.3+4] - 2020-01-16

- Updated navigator functions.
- Added another style for the nav bar.
- Added `horizontalPadding` property for the nav bar.

## [1.0.3+3] - 2020-01-10

- Fixed issue with `bottomPadding`.

## [1.0.3+2] - 2020-01-09

- Updated `pushNewScreen` functions.

## [1.0.3+1] - 2020-01-09

- Updated project description.

## [1.0.3] - 2020-01-09

- Updated font sizes. Added 'bottomPadding` property for navigation bar items.

## [1.0.2+1] - 2020-01-09

- Fixes in `pushNewScreen`.

## [1.0.2] - 2020-01-09

- Fixes in `pushNewScreen`.

## [1.0.1] - 2020-01-09

- Updated package's description.

## [1.0.0] - 2020-01-09

- Stable version released.

## [0.0.5] - 2020-01-09

- Fixed formatting.

## [0.0.4] - 2020-01-09

- Example project added to repository.

## [0.0.3] - 2020-01-08

- Updated README.md

## [0.0.2] - 2020-01-08

- Updated README.md

## [0.0.1] - 2020-01-08

### Added

- Persistent Bottom Navigation.
- Ability to push new screen with or without bottom navigation bar.
- 8 styles for the bottom navigation bar (includes BottomNavyBar style).
- Includes function for pushing screen with or without the bottom navigation bar i.e. pushNewScreen() and pushNewScreenWithRouteSettings().
- Includes platform specific behavior as an option (specify it in the two navigator functions).
- Based on flutter's Cupertino(iOS) bottom navigation bar.
