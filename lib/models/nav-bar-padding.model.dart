part of persistent_bottom_nav_bar;

class NavBarPadding {
  final double top;
  final double bottom;
  final double right;
  final double left;

  const NavBarPadding.only({this.top, this.bottom, this.right, this.left});

  const NavBarPadding.symmetric({double horizontal, double vertical})
      : this.top = vertical,
        this.bottom = vertical,
        this.right = horizontal,
        this.left = horizontal;

  const NavBarPadding.all(double value)
      : this.top = value,
        this.bottom = value,
        this.right = value,
        this.left = value;

  const NavBarPadding.fromLTRB(this.top, this.bottom, this.right, this.left);
}
