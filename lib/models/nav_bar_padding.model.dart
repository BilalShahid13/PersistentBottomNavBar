part of persistent_bottom_nav_bar;

class NavBarPadding {
  const NavBarPadding.only(
      {this.top = 0, this.bottom = 0, this.right = 0, this.left = 0});

  const NavBarPadding.symmetric(
      {final double horizontal = 0, final double vertical = 0})
      : top = vertical,
        bottom = vertical,
        right = horizontal,
        left = horizontal;

  const NavBarPadding.all(final double value)
      : top = value,
        bottom = value,
        right = value,
        left = value;

  const NavBarPadding.fromLTRB(this.top, this.bottom, this.right, this.left);
  final double top;
  final double bottom;
  final double right;
  final double left;
}
