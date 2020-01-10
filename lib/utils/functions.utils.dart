import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

pushNewScreen(
    {BuildContext context,
    Widget screen,
    bool withNavBar,
    bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
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
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(
      CupertinoPageRoute<void>(
          settings: settings, builder: (BuildContext context) => screen));
}

BoxDecoration getNavBarDecoration(
    {bool showElevation = true,
    bool isCurved = false,
    @required Color backgroundColor}) {
  return isCurved && showElevation
      ? BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
        )
      : isCurved && !showElevation
          ? BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            )
          : !isCurved && showElevation
              ? BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                )
              : BoxDecoration(
                  color: backgroundColor,
                );
}

bool isIOS(BuildContext context) =>
    (Theme.of(context).platform == TargetPlatform.iOS &&
        (Device.get().isIphoneX || Device.get().isTablet));
