import '../persistent-tab-view.dart';

///An item widget for the `PersistentTabView`.
class PersistentBottomNavBarItem {
  ///Icon for the bar item.
  final Widget icon;

  ///Title for the bar item. Might not appear is some `styles`.
  final String title;

  ///Color for the current selected item in the navigation bar. If `activeContentColor` property is empty, this will act in its place (recommended). `cupertino activeBlue` by default.
  final Color activeColor;

  ///Color for the unselected item(s) in the navigation bar.
  final Color inactiveColor;

  ///Color for the item's `icon` and `title`. In most styles, declaring the the `activeColor` will be enough. But in some styles like `style7`, this might come help in differentiating the colors.
  final Color activeContentColor;

  ///Padding of the navigation bar item. Applies on all sides. `5.0` by default.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double contentPadding;

  ///`title` property's font size. `12.0` by default.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double titleFontSize;

  PersistentBottomNavBarItem(
      {@required this.icon,
      @required this.title,
      this.titleFontSize = 12.0,
      this.contentPadding = 5.0,
      this.activeColor = CupertinoColors.activeBlue,
      this.activeContentColor,
      this.inactiveColor}) {
    assert(icon != null);
    assert(title != null);
  }
}
