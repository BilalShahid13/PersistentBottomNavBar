part of persistent_bottom_nav_bar;

class ScreenTransitionAnimation {
  const ScreenTransitionAnimation({
    this.animateTabTransition = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.ease,
  });
  final bool animateTabTransition;
  final Duration duration;
  final Curve curve;
}

class ItemAnimationProperties {
  const ItemAnimationProperties({this.duration, this.curve});
  final Duration? duration;
  final Curve? curve;
}
