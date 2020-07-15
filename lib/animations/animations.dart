part of persistent_bottom_nav_bar;

class OffsetAnimation extends StatefulWidget {
  OffsetAnimation(
      {Key key,
      this.child,
      this.hideNavigationBar,
      this.navBarHeight,
      this.onAnimationComplete,
      this.extendedLength = false})
      : super(key: key);
  final Widget child;
  final bool hideNavigationBar;
  final double navBarHeight;
  final bool extendedLength;
  final Function(bool, bool) onAnimationComplete;

  @override
  _OffsetAnimationState createState() => _OffsetAnimationState();
}

class _OffsetAnimationState extends State<OffsetAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _navBarHideAnimationController;
  Animation<Offset> _navBarOffsetAnimation;
  bool _hideNavigationBar;

  @override
  void initState() {
    super.initState();
    _hideNavigationBar = widget.hideNavigationBar;

    _navBarHideAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _navBarOffsetAnimation = Tween<Offset>(
            begin: Offset(0, 0), end: Offset(0, widget.navBarHeight + 22.0))
        .chain(CurveTween(curve: Curves.ease))
        .animate(_navBarHideAnimationController);

    _hideAnimation();

    _navBarHideAnimationController.addListener(() {
      widget.onAnimationComplete(_navBarHideAnimationController.isAnimating,
          _navBarHideAnimationController.isCompleted);
    });
  }

  @override
  void dispose() {
    _navBarHideAnimationController.dispose();
    super.dispose();
  }

  _hideAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_hideNavigationBar) {
        _navBarHideAnimationController.forward();
      } else {
        _navBarHideAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hideNavigationBar != null ||
        _hideNavigationBar != widget.hideNavigationBar) {
      _hideNavigationBar = widget.hideNavigationBar;
      _hideAnimation();
    }
    return AnimatedBuilder(
      animation: _navBarOffsetAnimation,
      child: widget.child,
      builder: (context, child) => Transform.translate(
        offset: _navBarOffsetAnimation.value,
        child: child,
      ),
    );
  }
}
