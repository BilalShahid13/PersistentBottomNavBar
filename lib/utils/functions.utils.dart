import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

Future<T> pushNewScreen<T extends Object>(BuildContext context,
    {Widget screen, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar)
      .push(CupertinoPageRoute(builder: (BuildContext context) => screen));
}

Future<T> pushDynamicScreen<T extends Object>(BuildContext context,
    {dynamic screen, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(screen);
}

Future<T> pushNewScreenWithRouteSettings<T extends Object>(BuildContext context,
    {Widget screen,
    RouteSettings settings,
    bool withNavBar,
    bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(
      CupertinoPageRoute(
          settings: settings, builder: (BuildContext context) => screen));
}

BoxDecoration getNavBarDecoration(
    {bool showElevation = true, bool isCurved = false}) {
  return isCurved && showElevation
      ? BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
        )
      : isCurved && !showElevation
          ? BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            )
          : !isCurved && showElevation
              ? BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                )
              : BoxDecoration();
}

bool isIOS(BuildContext context) =>
    (Theme.of(context).platform == TargetPlatform.iOS &&
        (Device.get().isIphoneX || Device.get().isTablet));
