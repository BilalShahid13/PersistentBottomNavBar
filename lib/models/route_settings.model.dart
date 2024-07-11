part of persistent_bottom_nav_bar;

class RouteAndNavigatorSettings {
  const RouteAndNavigatorSettings({
    this.defaultTitle,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.initialRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.navigatorKey,
  });
  final String? defaultTitle;

  final Map<String, WidgetBuilder>? routes;

  final RouteFactory? onGenerateRoute;

  final RouteFactory? onUnknownRoute;

  final String? initialRoute;

  final List<NavigatorObserver> navigatorObservers;

  final GlobalKey<NavigatorState>? navigatorKey;

  RouteAndNavigatorSettings copyWith({
    final String? defaultTitle,
    final Map<String, WidgetBuilder>? routes,
    final RouteFactory? onGenerateRoute,
    final RouteFactory? onUnknownRoute,
    final String? initialRoute,
    final List<NavigatorObserver>? navigatorObservers,
    final GlobalKey<NavigatorState>? navigatorKeys,
  }) =>
      RouteAndNavigatorSettings(
        defaultTitle: defaultTitle ?? this.defaultTitle,
        routes: routes ?? this.routes,
        onGenerateRoute: onGenerateRoute ?? this.onGenerateRoute,
        onUnknownRoute: onUnknownRoute ?? this.onUnknownRoute,
        initialRoute: initialRoute ?? this.initialRoute,
        navigatorObservers: navigatorObservers ?? this.navigatorObservers,
        navigatorKey: navigatorKey ?? navigatorKey,
      );
}

class CustomNavBarScreen {
  const CustomNavBarScreen(
      {required this.screen, this.routeAndNavigatorSettings});

  final Widget screen;
  final RouteAndNavigatorSettings? routeAndNavigatorSettings;
}
