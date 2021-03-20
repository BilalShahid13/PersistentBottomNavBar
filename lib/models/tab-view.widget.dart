part of persistent_bottom_nav_bar;

class CustomTabView extends StatefulWidget {
  const CustomTabView({
    Key key,
    this.builder,
    this.routeAndNavigatorSettings,
  }) : super(key: key);
  final WidgetBuilder builder;
  final RouteAndNavigatorSettings routeAndNavigatorSettings;

  @override
  _CustomTabViewState createState() {
    return _CustomTabViewState();
  }
}

class _CustomTabViewState extends State<CustomTabView> {
  HeroController _heroController;
  List<NavigatorObserver> _navigatorObservers;

  @override
  void initState() {
    super.initState();
    _heroController = CupertinoApp.createCupertinoHeroController();
    _updateObservers();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.routeAndNavigatorSettings.navigatorKey !=
            oldWidget.routeAndNavigatorSettings.navigatorKey ||
        widget.routeAndNavigatorSettings.navigatorObservers !=
            oldWidget.routeAndNavigatorSettings.navigatorObservers) {
      _updateObservers();
    }
  }

  void _updateObservers() {
    _navigatorObservers = List<NavigatorObserver>.from(
        widget.routeAndNavigatorSettings.navigatorObservers)
      ..add(_heroController);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.routeAndNavigatorSettings.navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      observers: _navigatorObservers,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final String name = settings.name;
    WidgetBuilder routeBuilder;
    //String title;
    if (name == Navigator.defaultRouteName && widget.builder != null) {
      routeBuilder = widget.builder;
      //title = widget.defaultTitle;
    } else if (widget.routeAndNavigatorSettings.routes != null) {
      routeBuilder = widget.routeAndNavigatorSettings.routes[name];
    }
    if (routeBuilder != null) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            routeBuilder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        settings: RouteSettings(
            name: widget.routeAndNavigatorSettings.initialRoute ??
                '/9f580fc5-c252-45d0-af25-9429992db112'),
      );
    }
    if (widget.routeAndNavigatorSettings.onGenerateRoute != null)
      return widget.routeAndNavigatorSettings.onGenerateRoute(settings);
    return null;
  }

  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    assert(() {
      if (widget.routeAndNavigatorSettings.onUnknownRoute == null) {
        throw FlutterError(
            'Could not find a generator for route $settings in the $runtimeType.\n'
            'Generators for routes are searched for in the following order:\n'
            ' 1. For the "/" route, the "builder" property, if non-null, is used.\n'
            ' 2. Otherwise, the "routes" table is used, if it has an entry for '
            'the route.\n'
            ' 3. Otherwise, onGenerateRoute is called. It should return a '
            'non-null value for any valid route not handled by "builder" and "routes".\n'
            ' 4. Finally if all else fails onUnknownRoute is called.\n'
            'Unfortunately, onUnknownRoute was not set.');
      }
      return true;
    }());
    final Route<dynamic> result =
        widget.routeAndNavigatorSettings.onUnknownRoute(settings);
    assert(() {
      if (result == null) {
        throw FlutterError('The onUnknownRoute callback returned null.\n'
            'When the $runtimeType requested the route $settings from its '
            'onUnknownRoute callback, the callback returned null. Such callbacks '
            'must never return null.');
      }
      return true;
    }());
    return result;
  }
}
