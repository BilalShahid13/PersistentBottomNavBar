part of persistent_bottom_nav_bar;

class _PersistentBottomNavigationBarUtilFunctions {
  _PersistentBottomNavigationBarUtilFunctions._();

  static BoxDecoration getNavBarDecoration({
    required final double opacity,
    final NavBarDecoration decoration = const NavBarDecoration(),
    final bool showBorder = true,
    final bool showOpacity = true,
    final Color? color = Colors.white,
  }) {
    if (opacity < 1.0) {
      return BoxDecoration(
          border: showBorder ? decoration.border : null,
          borderRadius: decoration.borderRadius,
          color: decoration.boxShadow != null
              ? Colors.transparent
              : color!.withOpacity(opacity),
          gradient: decoration.gradient,
          boxShadow: decoration.boxShadow);
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

  static bool isColorOpaque(final BuildContext context, final Color? color) {
    final Color backgroundColor =
        color ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha ==
        0xFF;
  }

  static bool opaque(
      final List<PersistentBottomNavBarItem> items, final int? selectedIndex) {
    for (int i = 0; i < items.length; ++i) {
      if (items[i].opacity < 1.0 && i == selectedIndex) {
        return false;
      }
    }
    return true;
  }

  static double getTranslucencyAmount(
      final List<PersistentBottomNavBarItem> items, final int? selectedIndex) {
    for (int i = 0; i < items.length; ++i) {
      if (items[i].opacity < 1.0 && i == selectedIndex) {
        return items[i].opacity;
      }
    }
    return 1;
  }

  static Color getBackgroundColor(
      final BuildContext context,
      final List<PersistentBottomNavBarItem> items,
      final Color? color,
      final int? selectedIndex) {
    if (color == null) {
      return Colors.white;
    } else if (!opaque(items, selectedIndex) && isColorOpaque(context, color)) {
      return color.withOpacity(getTranslucencyAmount(items, selectedIndex));
    } else {
      return color;
    }
  }
}
