// Author: Bilal Shahid
// For queries, contact: bilalscheema@gmail.com

import 'package:flutter/material.dart';
import 'persistent-tab-view.dart';

///A highly customizable persistent navigation bar for flutter.
///
///To learn more, check out the [Readme](https://github.com/BilalShahid13/PersistentBottomNavBar).
class PersistentTabView extends StatelessWidget {
  PersistentTabView(
      {Key key,
      this.items,
      @required this.screens,
      this.controller,
      this.showElevation = false,
      this.navBarHeight,
      this.backgroundColor = CupertinoColors.white,
      this.iconSize = 26.0,
      this.selectedIndex = 0,
      this.onItemSelected,
      this.bottomPadding,
      this.horizontalPadding,
      this.neumorphicProperties,
      this.floatingActionWidget,
      this.customWidget,
      this.itemCount,
      this.navBarCurve = NavBarCurve.none,
      this.navBarStyle = NavBarStyle.style1})
      : super(key: key) {
    assert(items != null || navBarStyle == NavBarStyle.custom);
    assert(items == null && itemCount != null || items != null);
    assert(screens != null);
    assert(navBarStyle == NavBarStyle.custom || items.length == screens.length);
    assert(navBarStyle == NavBarStyle.custom || items.length >= 2 && items.length <= 5);
    assert(navBarStyle == NavBarStyle.custom && customWidget != null || navBarStyle != NavBarStyle.custom && customWidget == null);
  }

  ///List of persistent bottom navigation bar items to be displayed in the navigation bar.
  final List<PersistentBottomNavBarItem> items;

  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  final List<Widget> screens;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  final PersistentTabController controller;

  ///Background color of bottom navigation bar. `white` by default.
  final Color backgroundColor;

  ///Show shadow on the upper part of the navigation bar to give it an elevated feel. `true` by default.
  final bool showElevation;

  ///Icon size for the `persistent bottom navigation bar items`. `26.0` by default.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double iconSize;

  ///Index of the page to be selected. `0` by default.
  final int selectedIndex;

  ///Callback when page or tab change is detected.
  final ValueChanged<int> onItemSelected;

  ///Style for persistent bottom navigation bar. Accepts `NavBarStyle` to determine the theme.
  final NavBarStyle navBarStyle;

  ///Bottom `padding` for the persistent navigation bar items.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double bottomPadding;

  ///Horizontal `padding` for the persistent navigation bar items.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double horizontalPadding;

  ///Style the `neumorphic` navigation bar item.
  ///
  ///Works only with style `neumorphic`.
  final NeumorphicProperties neumorphicProperties;

  ///A custom widget which is displayed at the bottom right of the display at all times.
  final Widget floatingActionWidget;

  ///Specifies if the NavBar's borders should be curved or not.
  ///
  ///Defaults to `none`
  final NavBarCurve navBarCurve;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `60.0` for Android and notchless iPhones and `90.0` for tablets and iPhones with a notch.
  final double navBarHeight;

  ///Custom navigation bar widget. To be only used when `navBarStyle` is set to `NavBarStyle.custom`.
  final Widget customWidget;

  ///If using `custom` navBarStyle, define this instead of the `items` property
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PersistentTabScaffold(
        controller: this.controller,
        isIOS: isIOS(context),
        itemCount: items == null ? itemCount ?? 0 : items.length,
        tabBar: PersistentBottomNavBar(
          showElevation: this.showElevation,
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight ?? (isIOS(context) ? 90.0 : 60.0),
          selectedIndex: this.selectedIndex,
          isIOS: isIOS(context),
          navBarCurve: navBarCurve,
          bottomPadding: this.bottomPadding,
          horizontalPadding: this.horizontalPadding,
          navBarStyle: this.navBarStyle,
          neumorphicProperties: this.neumorphicProperties,
          customNavBarWidget: this.customWidget,
          onItemSelected: onItemSelected != null
              ? (int index) {
                  this.onItemSelected(index);
                }
              : (int index) {
                  //DO NOTHING
                },
        ),
        tabBuilder: (BuildContext context, int index) {
          return this.floatingActionWidget == null
              ? CupertinoTabView(builder: (BuildContext context) {
                  return Material(child: screens[index]);
                })
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SizedBox.expand(
                      child: CupertinoTabView(
                        builder: (BuildContext context) {
                          return Material(child: screens[index]);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: this.navBarCurve != NavBarCurve.none ? 25.0 : 10.0,
                      right: 10.0,
                      child: this.floatingActionWidget,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
