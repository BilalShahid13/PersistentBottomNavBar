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

Widget _slideRightRoute(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: child);

Widget _slideUp(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(animation),
        child: child);

Widget _scaleRoute(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: child);

Widget _rotationRoute(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    RotationTransition(
        turns: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
        child: child);

Widget _sizeRoute(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    Align(
      child: SizeTransition(sizeFactor: animation, child: child),
    );

Widget _fadeRoute(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    FadeTransition(opacity: animation, child: child);

Widget _scaleRotate(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) =>
    ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.linear)),
            child: child));

class _AnimatedPageRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  final PageTransitionAnimation transitionAnimation;
  final RouteSettings routeSettings;
  _AnimatedPageRoute(
      {this.exitPage,
      this.enterPage,
      this.transitionAnimation,
      this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              enterPage,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              Stack(
            children: <Widget>[
              _getAnimation(context, animation, secondaryAnimation, exitPage,
                  transitionAnimation),
              _getAnimation(context, animation, secondaryAnimation, enterPage,
                  transitionAnimation)
            ],
          ),
        );
}

class _SinglePageRoute extends PageRouteBuilder {
  final Widget page;
  final PageTransitionAnimation transitionAnimation;
  final RouteSettings routeSettings;
  _SinglePageRoute({this.page, this.transitionAnimation, this.routeSettings})
      : super(
            settings: routeSettings,
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                _getAnimation(context, animation, secondaryAnimation, child,
                    transitionAnimation));
}

Widget _getAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
  PageTransitionAnimation transitionAnimation,
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

dynamic getPageRoute(PageTransitionAnimation transitionAnimation,
    {RouteSettings settings, Widget enterPage, Widget exitPage}) {
  switch (transitionAnimation) {
    case PageTransitionAnimation.cupertino:
      return settings == null
          ? CupertinoPageRoute(builder: (BuildContext context) => enterPage)
          : CupertinoPageRoute(
              settings: settings, builder: (BuildContext context) => enterPage);
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
