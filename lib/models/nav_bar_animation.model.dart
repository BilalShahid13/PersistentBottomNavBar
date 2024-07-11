part of persistent_bottom_nav_bar;

class NavBarAnimationSettings {
  const NavBarAnimationSettings({
    this.navBarItemAnimation = const ItemAnimationSettings(),
    this.onNavBarHideAnimation = const OnHideAnimationSettings(),
    this.screenTransitionAnimation = const ScreenTransitionAnimationSettings(),
  });

  final ScreenTransitionAnimationSettings screenTransitionAnimation;
  final ItemAnimationSettings navBarItemAnimation;
  final OnHideAnimationSettings onNavBarHideAnimation;
}

class ScreenTransitionAnimationSettings {
  const ScreenTransitionAnimationSettings({
    this.animateTabTransition = false,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.ease,
    this.screenTransitionAnimationType = ScreenTransitionAnimationType.fadeIn,
  });
  final bool animateTabTransition;
  final Duration duration;
  final Curve curve;
  final ScreenTransitionAnimationType screenTransitionAnimationType;
}

class ItemAnimationSettings {
  const ItemAnimationSettings(
      {this.duration = const Duration(milliseconds: 400),
      this.curve = Curves.ease});
  final Duration duration;
  final Curve curve;
}

enum ScreenTransitionAnimationType { slide, fadeIn }

class OnHideAnimationSettings {
  const OnHideAnimationSettings(
      {this.duration = const Duration(milliseconds: 100),
      this.curve = Curves.linear});
  final Duration duration;
  final Curve curve;
}
