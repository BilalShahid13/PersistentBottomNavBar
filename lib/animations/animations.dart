// ignore_for_file: avoid_positional_boolean_parameters

part of persistent_bottom_nav_bar;

class OffsetAnimation extends StatefulWidget {
  const OffsetAnimation({
    required this.child,
    required this.hideNavigationBar,
    required this.navBarHeight,
    required this.navBarHideAnimationController,
    this.onAnimationComplete,
    this.extendedLength = false,
    final Key? key,
  }) : super(key: key);
  final Widget child;
  final bool hideNavigationBar;
  final double navBarHeight;
  final bool extendedLength;
  final Function(bool isAnimating, bool isComplete)? onAnimationComplete;
  final AnimationController navBarHideAnimationController;

  @override
  _OffsetAnimationState createState() => _OffsetAnimationState();
}

class _OffsetAnimationState extends State<OffsetAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _navBarOffsetAnimation;
  late bool _hideNavigationBar;

  @override
  void initState() {
    super.initState();
    _hideNavigationBar = widget.hideNavigationBar;

    _navBarOffsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0, widget.navBarHeight))
            .chain(CurveTween(curve: Curves.linear))
            .animate(widget.navBarHideAnimationController);

    _hideAnimation();

    widget.navBarHideAnimationController.addListener(() {
      widget.onAnimationComplete!(
          widget.navBarHideAnimationController.isAnimating,
          widget.navBarHideAnimationController.isCompleted);
    });
  }

  void _hideAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (_hideNavigationBar) {
        widget.navBarHideAnimationController.forward();
      } else {
        widget.navBarHideAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    if (_hideNavigationBar != widget.hideNavigationBar) {
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
