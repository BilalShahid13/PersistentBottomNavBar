part of persistent_bottom_nav_bar;

enum PageTransitionAnimation {
  cupertino,
  slideRight,
  scale,
  rotate,
  sizeUp,
  fade,
  scaleRotate,
  slideUp
}

Widget _slideRightRoute(
        final BuildContext context,
        final Animation<double> animation,
        final Animation<double> secondaryAnimation,
        final Widget? child) =>
    SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: child);

Widget _slideUp(final BuildContext context, final Animation<double> animation,
        final Animation<double> secondaryAnimation, final Widget? child) =>
    SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(animation),
        child: child);

Widget _scaleRoute(
        final BuildContext context,
        final Animation<double> animation,
        final Animation<double> secondaryAnimation,
        final Widget? child) =>
    ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);

Widget _rotationRoute(
        final BuildContext context,
        final Animation<double> animation,
        final Animation<double> secondaryAnimation,
        final Widget? child) =>
    RotationTransition(
        turns: Tween<double>(begin: 0, end: 1)
            .animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
        child: child);

Widget _sizeRoute(final BuildContext context, final Animation<double> animation,
        final Animation<double> secondaryAnimation, final Widget? child) =>
    Align(
      child: SizeTransition(sizeFactor: animation, child: child),
    );

Widget _fadeRoute(final BuildContext context, final Animation<double> animation,
        final Animation<double> secondaryAnimation, final Widget? child) =>
    FadeTransition(opacity: animation, child: child);

Widget _scaleRotate(
        final BuildContext context,
        final Animation<double> animation,
        final Animation<double> secondaryAnimation,
        final Widget? child) =>
    ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: RotationTransition(
            turns: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.linear)),
            child: child));

class _AnimatedPageRoute extends PageRouteBuilder<dynamic> {
  _AnimatedPageRoute(
      {this.exitPage,
      this.enterPage,
      this.transitionAnimation,
      this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder:
              (final context, final animation, final secondaryAnimation) =>
                  enterPage!,
          transitionsBuilder: (final context, final animation,
                  final secondaryAnimation, final child) =>
              Stack(
            children: <Widget>[
              _getAnimation(context, animation, secondaryAnimation, exitPage,
                  transitionAnimation!),
              _getAnimation(context, animation, secondaryAnimation, enterPage,
                  transitionAnimation)
            ],
          ),
        );
  final Widget? enterPage;
  final Widget? exitPage;
  final PageTransitionAnimation? transitionAnimation;
  final RouteSettings? routeSettings;
}

class _SinglePageRoute extends PageRouteBuilder<dynamic> {
  _SinglePageRoute({this.page, this.transitionAnimation, this.routeSettings})
      : super(
            settings: routeSettings,
            pageBuilder:
                (final context, final animation, final secondaryAnimation) =>
                    page!,
            transitionsBuilder: (final context, final animation,
                    final secondaryAnimation, final child) =>
                _getAnimation(context, animation, secondaryAnimation, child,
                    transitionAnimation!));
  final Widget? page;
  final PageTransitionAnimation? transitionAnimation;
  final RouteSettings? routeSettings;
}

Widget _getAnimation(
  final BuildContext context,
  final Animation<double> animation,
  final Animation<double> secondaryAnimation,
  final Widget? child,
  final PageTransitionAnimation transitionAnimation,
) {
  switch (transitionAnimation) {
    case PageTransitionAnimation.cupertino:
      break;
    case PageTransitionAnimation.slideRight:
      return _slideRightRoute(context, animation, secondaryAnimation, child);
    case PageTransitionAnimation.scale:
      return _scaleRoute(context, animation, secondaryAnimation, child);
    case PageTransitionAnimation.rotate:
      return _rotationRoute(context, animation, secondaryAnimation, child);
    case PageTransitionAnimation.sizeUp:
      return _sizeRoute(context, animation, secondaryAnimation, child);
    case PageTransitionAnimation.fade:
      return _fadeRoute(context, animation, secondaryAnimation, child);
    case PageTransitionAnimation.scaleRotate:
      return _scaleRotate(context, animation, secondaryAnimation, child);
    case PageTransitionAnimation.slideUp:
      return _slideUp(context, animation, secondaryAnimation, child);
  }
  return Container();
}

Route<dynamic> _getPageRoute(final PageTransitionAnimation transitionAnimation,
    {final RouteSettings? settings,
    final Widget? enterPage,
    final Widget? exitPage}) {
  switch (transitionAnimation) {
    case PageTransitionAnimation.cupertino:
      return settings == null
          ? CupertinoPageRoute(builder: (final context) => enterPage!)
          : CupertinoPageRoute(
              settings: settings, builder: (final context) => enterPage!);
    default:
      return exitPage == null
          ? _SinglePageRoute(
              page: enterPage,
              transitionAnimation: transitionAnimation,
              routeSettings: settings)
          : _AnimatedPageRoute(
              enterPage: enterPage,
              exitPage: exitPage,
              transitionAnimation: transitionAnimation,
              routeSettings: settings);
  }
}
