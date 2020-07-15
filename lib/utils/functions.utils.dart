part of persistent_bottom_nav_bar;

BoxDecoration getNavBarDecoration({
  bool showElevation = true,
  NavBarDecoration decoration = const NavBarDecoration(),
  double opacity,
  bool showBorder = true,
  bool showOpacity = true,
  Color color = Colors.white,
}) {
  if (opacity < 1.0) {
    return BoxDecoration(
      border: showBorder ? decoration.border : null,
      borderRadius: decoration.borderRadius,
      color: color.withOpacity(opacity),
    );
  } else {
    return BoxDecoration(
      border: showBorder ? decoration.border : null,
      borderRadius: decoration.borderRadius,
      color: color,
      gradient: decoration.gradient,
      boxShadow: decoration.boxShadow,
    );
  }
}

bool isColorOpaque(BuildContext context, Color color) {
  final Color backgroundColor =
      color ?? CupertinoTheme.of(context).barBackgroundColor;
  return CupertinoDynamicColor.resolve(backgroundColor, context).alpha == 0xFF;
}

bool opaque(List<PersistentBottomNavBarItem> items, int selectedIndex) {
  for (int i = 0; i < items.length; ++i) {
    if (items[i].opacity < 1.0 && i == selectedIndex) {
      return false;
    }
  }
  return true;
}

double getTranslucencyAmount(
    List<PersistentBottomNavBarItem> items, int selectedIndex) {
  for (int i = 0; i < items.length; ++i) {
    if (items[i].opacity < 1.0 && i == selectedIndex) {
      return items[i].opacity;
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
