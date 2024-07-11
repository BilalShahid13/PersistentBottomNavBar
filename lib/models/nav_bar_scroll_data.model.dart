part of persistent_bottom_nav_bar;

class _NavBarScrollModel {
  double minimumOffset = 0;
  double maxOffset = 0;
  double lastOffset = 0;
  bool isScrollingUp = false;
}

class HideOnScrollSettings {
  const HideOnScrollSettings(
      {this.hideNavBarOnScroll = true, this.scrollControllers = const []});

  ///Navigation bar will slide down and disappear if this value is set to `true` when scroll controller(s) provided in `scrollController` property detect scroll down motion.
  final bool hideNavBarOnScroll;

  ///Navigation bar will disappear down if scroll down motion is detect. Navigation bar will simultaneously reappear if scroll up motion is detected.
  final List<ScrollController> scrollControllers;
}
