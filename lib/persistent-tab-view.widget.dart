// Developed by Bilal Shahid
// For queries, contact: bilalscheema@gmail.com

import 'package:flutter/material.dart';
import 'persistent-tab-view.dart';

class PersistentTabView extends StatelessWidget {
  PersistentTabView(
      {Key key,
      @required this.items,
      @required this.screens,
      this.controller,
      this.showElevation = false,
      this.backgroundColor = CupertinoColors.white,
      this.iconSize = 26.0,
      this.navBarHeight = 0.0,
      this.selectedIndex = 0,
      this.onItemSelected,
      this.isCurved = false,
      this.navBarStyle = NavBarStyle.style1})
      : super(key: key) {
    assert(items != null);
    assert(screens != null);
    assert(items.length >= 2 && items.length <= 5);
  }

  final List<PersistentBottomNavBarItem> items;
  final List<Widget> screens;
  final PersistentTabController controller;
  final Color backgroundColor;
  final bool showElevation;
  final double iconSize;
  final double navBarHeight;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool isCurved;
  final String navBarStyle;

  @override
  Widget build(BuildContext context) {
    bool _isIOS = (Theme.of(context).platform == TargetPlatform.iOS &&
            Device.get().isIphoneX) ||
        (Theme.of(context).platform == TargetPlatform.iOS &&
            Device.get().isTablet);
    double _navBarHeight = 0.0;
    if (this.navBarHeight == 0.0) {
      _navBarHeight = _isIOS ? 90.0 : 60.0;
    } else {
      _navBarHeight = this.navBarHeight;
    }
    return PersistentTabScaffold(
      controller: this.controller,
      isIOS: _isIOS,
      tabBar: PersistentBottomNavBar(
        showElevation: this.showElevation,
        items: this.items,
        backgroundColor: this.backgroundColor,
        iconSize: this.iconSize,
        navBarHeight: _navBarHeight,
        selectedIndex: this.selectedIndex,
        isIOS: _isIOS,
        isCurved: isCurved,
        navBarStyle: this.navBarStyle,
        onItemSelected: (int index) {
          this.onItemSelected(index);
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) {
          return screens[index];
        });
      },
    );
  }
}

pushNewScreen(
    {BuildContext context,
    Widget screen,
    bool withNavBar,
    bool platformSpecific}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(
      CupertinoPageRoute<void>(builder: (BuildContext context) => screen));
}

pushNewScreenWithRouteSettings(
    {BuildContext context,
    Widget screen,
    RouteSettings settings,
    bool withNavBar,
    bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(
      CupertinoPageRoute<void>(
          settings: settings, builder: (BuildContext context) => screen));
}