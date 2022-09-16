part of persistent_bottom_nav_bar;

class PersistentNavBarNavigator {
  PersistentNavBarNavigator._();

  static Future<T?> pushNewScreen<T>(
    final BuildContext context, {
    required final Widget screen,
    bool? withNavBar,
    final PageTransitionAnimation pageTransitionAnimation =
        PageTransitionAnimation.cupertino,
    final PageRoute<T>? customPageRoute,
  }) {
    withNavBar ??= true;
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
        customPageRoute ??
            (getPageRoute(pageTransitionAnimation, enterPage: screen)
                as Route<T>));
  }

  static Future<T?> pushDynamicScreen<T>(
    final BuildContext context, {
    required final Route<T> screen,
    bool? withNavBar,
  }) {
    withNavBar ??= true;
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(screen);
  }

  static Future<T?> pushNewScreenWithRouteSettings<T>(
    final BuildContext context, {
    required final Widget screen,
    required final RouteSettings settings,
    bool? withNavBar,
    final PageTransitionAnimation pageTransitionAnimation =
        PageTransitionAnimation.cupertino,
    final PageRoute<T>? customPageRoute,
  }) {
    withNavBar ??= true;

    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
        customPageRoute ??
            (getPageRoute(pageTransitionAnimation,
                enterPage: screen, settings: settings) as Route<T>));
  }
}
