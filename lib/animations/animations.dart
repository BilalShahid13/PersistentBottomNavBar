part of persistent_bottom_nav_bar;

class OffsetAnimation extends StatefulWidget {
  const OffsetAnimation(
      {final Key? key,
      this.child,
      this.hideNavigationBar,
      this.navBarHeight,
      this.onAnimationComplete,
      this.extendedLength = false})
      : super(key: key);
  final Widget? child;
  final bool? hideNavigationBar;
  final double? navBarHeight;
  final bool extendedLength;
  final Function(bool, bool)? onAnimationComplete;

  @override
  _OffsetAnimationState createState() => _OffsetAnimationState();
}

class _OffsetAnimationState extends State<OffsetAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _navBarHideAnimationController;
  late Animation<Offset> _navBarOffsetAnimation;
  bool? _hideNavigationBar;

  @override
  void initState() {
    super.initState();
    _hideNavigationBar = widget.hideNavigationBar;

    _navBarHideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _navBarOffsetAnimation = Tween<Offset>(
            begin: Offset.zero, end: Offset(0, widget.navBarHeight! + 22.0))
        .chain(CurveTween(curve: Curves.ease))
        .animate(_navBarHideAnimationController);

    _hideAnimation();

    _navBarHideAnimationController.addListener(() {
      widget.onAnimationComplete!(_navBarHideAnimationController.isAnimating,
          _navBarHideAnimationController.isCompleted);
    });
  }

  @override
  void dispose() {
    _navBarHideAnimationController.dispose();
    super.dispose();
  }

  void _hideAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (_hideNavigationBar!) {
        _navBarHideAnimationController.forward();
      } else {
        _navBarHideAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    if (_hideNavigationBar != null ||
        _hideNavigationBar != widget.hideNavigationBar) {
      _hideNavigationBar = widget.hideNavigationBar;
      _hideAnimation();
    }
    return AnimatedBuilder(
      animation: _navBarOffsetAnimation,
      child: widget.child,
      builder: (final context, final child) => Transform.translate(
        offset: _navBarOffsetAnimation.value,
        child: child,
      ),
    );
  }
}
