# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [6.2.1] - 2024-07-12
- Fixed `null` error around `routeAndNavigatorSettings`.

## [6.2.0] - 2024-07-11
- **Breaking Changes**
    - For `PersistentTabView.custom`, `List<Widget> screens` has been replaced with `List<CustomNavBarScreen> screens`. 
    - Property `routeAndNavigatorSettings` has been removed from `PersistentTabView.custom`. You now define `RouteAndNavigatorSettings` for each screen separately in `CustomNavBarScreen`. Please refer to the [Readme](https://pub.dev/packages/persistent_bottom_nav_bar#custom-navigation-bar-styling) file for more instructions.

## [6.1.1] - 2024-07-11
- Updated README.md

## [6.1.0] - 2024-07-11
- Fixed issue where class `CustomWidgetRouteAndNavigatorSettings` was unintentionally made private.
- **Breaking Changes**
    - To import the package, you will now have to use `import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";` instead of `import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";`.

## [6.0.2] - 2024-07-11
- Fixed issues reported by `flutter analyze`.

## [6.0.1] - 2024-07-11
- Removed deprecated classes.
- Fixed unwanted trigger of `onWillPop` when Android back button is pressed.
- Fixed the bug where bar in `Style3` and `Style4` would not work correctly when margin was applied.
- Fixed typos in Readme and Changelog.
- Updated example project to run on latest Android versions.


## [6.0.0] - 2024-07-11
- There are many new features and some breaking changes introduced in this version. I will do my best to list all down here but I will still advise to check the example project to cover and see all of the changes for yourself.
- **Breaking Changes**
    - `NavBarPadding` is replaced with `EdgeInsets` in the `padding` property.
    - `itemAnimationProperties` and `screenTransitionAnimation` are now part of property `animationSettings`.
    - Renamed `confineInSafeArea` to `confineToSafeArea`.
    - Removed redundant properties `popAllScreensOnTapOfSelectedTab` and `popAllScreensOnTapAnyTabs`. Added new property `popBehaviorOnSelectedNavBarItemPress` to cover this behavior.
    - Property `hideNavigationBar` is replaced with `isVisible`. 
- **New Features**
    - Updated maximum supported Flutter SDK version.
    - Animated icons are now supported.
    - Hiding of navigation bar on scroll down motion is now supported through property `hideOnScrollSettings`. Hiding animation settings can be controlled from `animationSettings`. Please check the readme file and example project for better understanding.
    - You can now scroll to top on a scrollable screen when an already selected navigation bar tab is pressed. You will need to provide scroll controllers in both this and above mentioned functionality.
    - New `fadeIn` animation in `screenTransitionAnimation`.
    - New function `popUntilFirstScreenOnSelectedTabScreen`introduced in `PersistentNavBarNavigator`.
    - If opacity is less than 1 in `PersistentBottomNavBarItem` and `boxShadow` is applied `NavBarDecoration`, `backgroundColor` will be set to transparent to achieve partial transparent navigation bar effect like on Spotify Android. 
- **Bug Fixes**
    - Fixed null errors around `NavBarDecoration`.
    - Removed jitter in animation when property `hideNavigationBar` was changed.
    - Fixed error -> The getter 'backgroundColor' isn't defined for the type 'ThemeData'.
    - Fixed the issue where wrong animation state was shown when `initialIndex` on `PersistentTabController` was other than 0 in `style19`.
    - `floatingActionButton` is now fixed above the screens instead of separate button for each screen.

## [5.0.2] - 2022-09-16
- Fixed onWillPop assert error

## [5.0.1] - 2022-09-16
- Fixed linting and formatting errors

## [5.0.0] - 2022-09-16
- Added style 19
- Fixed warnings introduced after Flutter 3.0
- **Breaking Changes**
    - Navigator functions will now be called like `PersistentNavBarNavigator.pushNewScreen(...)` instead of `pushNewScreen(..)`.

## [4.0.2] - 2021-03-27
- Fixed error while pushing new screens through the included Navigator functions.

## [4.0.1] - 2021-03-27
- Fixed type cast error with `NavigatorObserver`.

## [4.0.0] - 2021-03-22
- Null safety migration.

## [3.2.0] - 2021-03-21
- `inactiveIcon` is now available in `PersistentBottomNavBarItem`.
- Fixed the bug where all screens of a tab would be popped while switching between tabs.
- Bug fixes.
- **Breaking Changes**
    - `onWillPop` function now will return the selected screen's context.
    **PersistentBottomNavBarItem**
    - `routeAndNavigatorSettings` has been removed for **non-custom** navigation bar. Instead, you must now declare `routeAndNavigatorSettings` in `PersistentBottomNavBarItem`.
    - `activeColor` is now `activeColorPrimary`.
    - `inactiveColor` is now `inactiveColorPrimary`.
    - `activeColorAlternate` is now `activeColorSecondary`.
    - `onPressed` now returns context of the selected screen.

## [3.1.0] - 2020-12-06
- Argument `routeAndNavigatorSettings` added to handle `Navigator.pushNamed(context, 'routeName')`. Please define your routes and other navigator settings like navigator observers here as well.
- **Breaking Changes**
    - Arguments `initalRoute`, `navigatorObservers` and `navigatorKeys` removed and shifted to `routeAndNavigatorSettings`.

## [3.0.0] - 2020-12-06

- Added new arguments `navigatorObservers` and `navigatorKeys` for the main navigation bar widget.
- No need to call `setState` when updating active tab using the PersistentTabController.
- Function argument `selectedTabScreenContext` exposes `context` of the selected tab.
- Bug fixes and code refactoring.
- **Breaking Changes**
    - `context` is now required in the constructor.
    - For custom widget, use this constructor `PersistentTabView.custom()`.
    - `NavBarStyle.custom` has been removed. Please use `PersistentTabView.custom()`.
    - Argument `iconSize` has been shifted to PersistentBottomNavBarItem.
    - PersistentBottomNavBarItem argument `activeContentColor`'s name has been changed to `activeColorSecondary`. Functionality remains the same.
    - PersistentBottomNavBarItem argument `titleStyle`'s name has been changed to `textStyle`. Functionality remains the same.

## [2.1.0] - 2020-10-02

- Added `TextStyle` property for title in the PersistentBottomNavBarItem.
- Added `margin` property for the navigation bar.
- Bug fixes.

## [2.0.5] - 2020-07-16

- Bug fixes related to decoration border.

## [2.0.4] - 2020-07-16

- Bug fixes.

## [2.0.3] - 2020-07-16

- Bug fixes.

## [2.0.2] - 2020-07-15

- Fixed `hideNavigationBar` animation jitter and updated Readme.

## [2.0.1] - 2020-07-15

- README updated.

## [2.0.0] - 2020-07-15

### These are not all the changes introduced in this update. Only the major ones. They were simply too many and couldn't be listed down here

- Added transition animations to the Navigator functions.
- Padding simplified into a single property and uses `NavBarPadding` instead of EdgeInsets.
- New property called 'decoration' where are decoration related properties have been moved like curveRadius, boxShadow etc.
- New property to hide the Navigation Bar when keyboard appears.
- For those wanting to display a custom dialog when user tries to exit the app on **Android only**, use `onWillPop` the callback function.
- 8 new styles added.
- Animation properties for all styles can now be controlled through the property `itemAnimationProperties`.
- Ability to turn off state management.
- Screen transition animation added. Can be controlled with the property `screenTransitionAnimation`.
- Ability to use custom behavior on tapping of a navigation bar's tab/item through `onPressed` callback method in the `PersistentBottomNavBarItem`.
- Removed `platformSpecific` property from Navigator functions to make it compatible with Flutter-Web.
- Minor new features, bug fixes and stability improvements.

## [1.5.5] - 2020-05-11

- Added property `bottomScreenPadding` to control a screen's bottom padding.
- Added property `navBarCurveRadius` to change the nav bar curve's radius.
- Added property `popAllScreensOnTapOfSelectedTab` to toggle between the ability to pop all pushed screens of a particular selected tab on the second press of the said tab.

## [1.5.4] - 2020-05-07

- Fixed background shadow issue when translucency was turned on with `showElevation == true`.

## [1.5.3] - 2020-05-07

- Updated Readme file.

## [1.5.2] - 2020-05-07

- Fixed nav bar background color consistency when translucency enabled.
- Added an example for the navigator function `pushDynamicScreen` in the sample project.
- Minor improvements to some styles.

## [1.5.1] - 2020-04-30

- Reverted changes to `PersistentTabController`.

## [1.5.0] - 2020-04-30

- Added feature to pop back to first screen on tapping of an already selected tab.
- Fixed the issue when new tab was added dynamically.
- Fixed safe area issues.
- Removed property `selectedIndex` as it was redundant. Use `PersistentTabController` to control it instead. `Breaking Change`
- Bug fixes.

## [1.4.5] - 2020-04-29

- Fixed nav bar translucency for provided styles.

## [1.4.4] - 2020-04-29

- Updated dependencies.
- Removed `allCorners` value from `NavBarCurve` as it became redundant after a fix.

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
