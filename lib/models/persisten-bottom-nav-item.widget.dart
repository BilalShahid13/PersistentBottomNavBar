import '../persistent-tab-view.dart';

class PersistentBottomNavBarItem {
  final Widget icon;
  final String title;
  final Color activeColor;
  final Color inactiveColor;
  final double contentPadding;
  final double titleFontSize;

  PersistentBottomNavBarItem(
      {@required this.icon,
      @required this.title,
      this.titleFontSize = 14.0,
      this.contentPadding = 5.0,
      this.activeColor = CupertinoColors.activeBlue,
      this.inactiveColor}) {
    assert(icon != null);
    assert(title != null);
  }
}
