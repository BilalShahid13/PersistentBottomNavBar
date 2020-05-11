import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

BoxDecoration getNavBarDecoration(
    {bool showElevation = true,
    NavBarCurve navBarCurve = NavBarCurve.none,
    bool isTranslucent = false,
    double navBarCurveRadius = 15.0,
    double tralucencyPercentage}) {
  return navBarCurve == NavBarCurve.upperCorners && showElevation
      ? BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(navBarCurveRadius),
              topRight: Radius.circular(navBarCurveRadius)),
          boxShadow: [
            BoxShadow(
                color: isTranslucent
                    ? Colors.black12.withOpacity(0.0)
                    : Colors.black12,
                blurRadius: 2)
          ],
        )
      : navBarCurve == NavBarCurve.upperCorners && !showElevation
          ? BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(navBarCurveRadius),
                  topRight: Radius.circular(navBarCurveRadius)),
            )
          : navBarCurve == NavBarCurve.none && showElevation
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: isTranslucent
                            ? Colors.black12.withOpacity(0.0)
                            : Colors.black12,
                        blurRadius: 2)
                  ],
                )
              : BoxDecoration();
}

BorderRadius getClipRectBorderRadius(
    {NavBarCurve navBarCurve = NavBarCurve.none,
    double navBarCurveRadius = 15.0}) {
  return navBarCurve == NavBarCurve.upperCorners
      ? BorderRadius.only(
          topLeft: Radius.circular(navBarCurveRadius),
          topRight: Radius.circular(navBarCurveRadius))
      : BorderRadius.circular(0.0);
}

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

double getTranslucencyAmount(
    List<PersistentBottomNavBarItem> items, int selectedIndex) {
  for (int i = 0; i < items.length; ++i) {
    if (items[i].isTranslucent && i == selectedIndex) {
      return items[i].translucencyPercentage / 100.0;
    }
  }
  return 1.0;
}

Color getBackgroundColor(BuildContext context,
    List<PersistentBottomNavBarItem> items, Color color, int selectedIndex) {
  if (color == null) {
    return Colors.white;
  } else if (!opaque(items, selectedIndex) && isColorOpaque(context, color)) {
    return color.withOpacity(getTranslucencyAmount(items, selectedIndex));
  } else {
    return color;
  }
}

void popAllScreens(BuildContext context) {
  while (true) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      break;
    }
  }
}
