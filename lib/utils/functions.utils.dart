import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

Future<T> pushNewScreen<T extends Object>(BuildContext context,
    {@required Widget screen, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar)
      .push(CupertinoPageRoute(builder: (BuildContext context) => screen));
}

Future<T> pushDynamicScreen<T extends Object>(BuildContext context,
    {@required dynamic screen, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(screen);
}

Future<T> pushNewScreenWithRouteSettings<T extends Object>(BuildContext context,
    {@required Widget screen,
    @required RouteSettings settings,
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

bool isColorOpaque(BuildContext context, Color color) {
    final Color backgroundColor =
        color ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha == 0xFF;
  }

bool opaque(List<PersistentBottomNavBarItem> items, int selectedIndex) {
    for (int i = 0; i < items.length; ++i) {
      if (items[i].isTranslucent && i == selectedIndex) {
        return false;
      }
    }
    return true;
  }

  double getTranslucencyAmount(List<PersistentBottomNavBarItem> items, int selectedIndex) {
    for (int i = 0; i < items.length; ++i) {
      if (items[i].isTranslucent && i == selectedIndex) {
        return items[i].translucencyPercentage / 100.0;
      }
    }
    return 1.0;
  }

  Color getBackgroundColor(BuildContext context, List<PersistentBottomNavBarItem> items, Color color, int selectedIndex) {
    if (color == null) {
      return Colors.white;
    } else if (!opaque(items, selectedIndex) && isColorOpaque(context, color)) {
      return color.withOpacity(getTranslucencyAmount(items, selectedIndex));
    } else {
      return color;
    }
  }