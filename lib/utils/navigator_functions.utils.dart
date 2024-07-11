part of persistent_bottom_nav_bar;

class PersistentNavBarNavigator {
  PersistentNavBarNavigator._();

  ///Once you push a screen with `withNavBar` set to `false`, Navigation bar cannot appear in screens pushed from here forward unless you define a new `PersistentTabView` on those screens.
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
            (_getPageRoute(pageTransitionAnimation, enterPage: screen)
                as Route<T>));
  }

  ///Once you push a screen with `withNavBar` set to `false`, Navigation bar cannot appear in screens pushed from here forward unless you define a new `PersistentTabView` on those screens.
  static Future<T?> pushDynamicScreen<T>(
    final BuildContext context, {
    required final Route<T> screen,
    bool? withNavBar,
  }) {
    withNavBar ??= true;
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(screen);
  }

  ///If you haven't defined a routeName for the first screen of the selected tab then don't use the optional property `routeName`. Otherwise it may not work as intended
  static void popUntilFirstScreenOnSelectedTabScreen(final BuildContext context,
          {final String? routeName}) =>
      Navigator.popUntil(
          context,
          ModalRoute.withName(
              routeName ?? "/9f580fc5-c252-45d0-af25-9429992db112"));

  static void pop(final BuildContext context) => Navigator.pop(context);

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
            (_getPageRoute(pageTransitionAnimation,
                enterPage: screen, settings: settings) as Route<T>));
  }
}
