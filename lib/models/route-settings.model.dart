part of persistent_bottom_nav_bar;

class RouteAndNavigatorSettings {
  final String defaultTitle;

  final Map<String, WidgetBuilder> routes;

  final RouteFactory onGenerateRoute;

  final RouteFactory onUnknownRoute;

  final String initialRoute;

  final List<NavigatorObserver> navigatorObservers;

  final GlobalKey<NavigatorState> navigatorKey;

  const RouteAndNavigatorSettings({
    this.defaultTitle,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.initialRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.navigatorKey,
  }) : assert(navigatorObservers != null);

  RouteAndNavigatorSettings copyWith({
    String defaultTitle,
    Map<String, WidgetBuilder> routes,
    RouteFactory onGenerateRoute,
    RouteFactory onUnknownRoute,
    String initialRoute,
    List<NavigatorObserver> navigatorObservers,
    GlobalKey<NavigatorState> navigatorKeys,
  }) {
    return RouteAndNavigatorSettings(
      defaultTitle: defaultTitle ?? this.defaultTitle,
      routes: routes ?? this.routes,
      onGenerateRoute: onGenerateRoute ?? this.onGenerateRoute,
      onUnknownRoute: onUnknownRoute ?? this.onUnknownRoute,
      initialRoute: initialRoute ?? this.initialRoute,
      navigatorObservers: navigatorObservers ?? this.navigatorObservers,
      navigatorKey: navigatorKey ?? this.navigatorKey,
    );
  }
}

class CutsomWidgetRouteAndNavigatorSettings {
  final String defaultTitle;

  final Map<String, WidgetBuilder> routes;

  final RouteFactory onGenerateRoute;

  final RouteFactory onUnknownRoute;

  final String initialRoute;

  final List<NavigatorObserver> navigatorObservers;

  final List<GlobalKey<NavigatorState>> navigatorKeys;

  const CutsomWidgetRouteAndNavigatorSettings({
    this.defaultTitle,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.initialRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.navigatorKeys,
  }) : assert(navigatorObservers != null);

  CutsomWidgetRouteAndNavigatorSettings copyWith({
    String defaultTitle,
    Map<String, WidgetBuilder> routes,
    RouteFactory onGenerateRoute,
    RouteFactory onUnknownRoute,
    String initialRoute,
    List<NavigatorObserver> navigatorObservers,
    List<GlobalKey<NavigatorState>> navigatorKeys,
  }) {
    return CutsomWidgetRouteAndNavigatorSettings(
      defaultTitle: defaultTitle ?? this.defaultTitle,
      routes: routes ?? this.routes,
      onGenerateRoute: onGenerateRoute ?? this.onGenerateRoute,
      onUnknownRoute: onUnknownRoute ?? this.onUnknownRoute,
      initialRoute: initialRoute ?? this.initialRoute,
      navigatorObservers: navigatorObservers ?? this.navigatorObservers,
      navigatorKeys: navigatorKeys ?? this.navigatorKeys,
    );
  }
}
