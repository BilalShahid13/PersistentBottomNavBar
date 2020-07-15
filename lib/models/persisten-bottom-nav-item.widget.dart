part of persistent_bottom_nav_bar;

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

  ///Enables and controls the transparency effect of the entire NavBar when this tab is selected.
  ///
  ///`Warning: Screen will cover the entire extent of the display`
  final double opacity;

  ///If you want custom behavior on a press of a NavBar item like display a modal screen, you can declare your logic here.
  ///
  ///NOTE: This will override the default tab switiching behavior for this particular item.
  final Function onPressed;

  ///Use it when you want to run some code when user presses the NavBar when on the initial screen of that respective tab. The inspiration was taken from the native iOS navigation bar behavior where when performing similar operation, you taken to the top of the list.
  ///
  ///NOTE: This feature is experimental at the moment and might not work as intended for some.
  final Function onSelectedTabPressWhenNoScreensPushed;

  ///Filter used when `opacity < 1.0`. Can be used to create 'frosted glass' effect.
  ///
  ///By default -> `ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0)`.
  final ImageFilter filter;

  PersistentBottomNavBarItem(
      {@required this.icon,
      this.title,
      this.titleFontSize = 12.0,
      this.contentPadding = 5.0,
      this.activeColor = CupertinoColors.activeBlue,
      this.activeContentColor,
      this.opacity = 1.0,
      this.inactiveColor,
      this.filter,
      this.onSelectedTabPressWhenNoScreensPushed,
      this.onPressed}) {
    assert(icon != null);
    assert(opacity >= 0 && opacity <= 1.0);
  }
}
