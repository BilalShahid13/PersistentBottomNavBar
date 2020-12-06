part of persistent_bottom_nav_bar;

enum NavBarStyle {
  style1,
  style2,
  style3,
  style4,
  style5,
  style6,
  style7,
  style8,
  style9,
  style10,
  style11,
  style12,
  style13,
  style14,
  style15,
  style16,
  style17,
  style18,
  neumorphic,
  simple,
}

enum PopActionScreensType { once, all }

class NavBarDecoration {
  ///Defines the curve radius of the corners of the NavBar.
  final BorderRadius borderRadius;

  /// Color for the container which holds the bottom NavBar.
  ///
  /// When you increase the `navBarCurveRadius`, the `bottomScreenPadding` will automatically adjust to avoid layout issues. But if you want a fixed `bottomScreenPadding`, then you might want to set the color of your choice to avoid black edges at the corners of the NavBar.
  final Color colorBehindNavBar;

  final Gradient gradient;

  final BoxBorder border;

  final List<BoxShadow> boxShadow;

  ///If enabled, the screen's bottom padding will be adjusted accordingly to the amount of curve applied.
  final bool adjustScreenBottomPaddingOnCurve;

  const NavBarDecoration({
    this.border,
    this.gradient,
    this.borderRadius,
    this.colorBehindNavBar = CupertinoColors.black,
    this.boxShadow,
    this.adjustScreenBottomPaddingOnCurve = true,
  });
}
