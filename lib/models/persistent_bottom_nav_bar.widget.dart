// ignore_for_file: avoid_positional_boolean_parameters

part of persistent_bottom_nav_bar;

class _PersistentBottomNavBar extends StatelessWidget {
  const _PersistentBottomNavBar({
    required this.confineToSafeArea,
    required this.navBarEssentials,
    required this.navBarDecoration,
    required this.navBarStyle,
    required this.hideNavigationBar,
    required this.navBarHideAnimationController,
    this.customNavBarWidget,
    this.onAnimationComplete,
    this.neumorphicProperties = const NeumorphicProperties(),
    this.isCustomWidget = false,
    final Key? key,
  }) : super(key: key);

  final AnimationController navBarHideAnimationController;
  final _NavBarEssentials navBarEssentials;
  final NavBarDecoration navBarDecoration;
  final NavBarStyle navBarStyle;
  final NeumorphicProperties? neumorphicProperties;
  final Widget? customNavBarWidget;
  final bool confineToSafeArea;
  final bool hideNavigationBar;
  final Function(bool, bool)? onAnimationComplete;
  final bool isCustomWidget;

  Padding _navBarWidget(final BuildContext context) => Padding(
        padding: navBarEssentials.margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCustomWidget)
              navBarEssentials.margin.bottom > 0
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: navBarEssentials.backgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: confineToSafeArea
                                ? MediaQuery.paddingOf(context).bottom
                                : 0),
                        child: SizedBox(
                          height: navBarEssentials.navBarHeight,
                          child: customNavBarWidget,
                        ),
                      ),
                    )
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        color: navBarEssentials.backgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: confineToSafeArea
                                ? MediaQuery.paddingOf(context).bottom
                                : 0),
                        child: SizedBox(
                          height: navBarEssentials.navBarHeight,
                          child: customNavBarWidget,
                        ),
                      ),
                    )
            else
              navBarStyle == NavBarStyle.style19
                  ? navBarEssentials.margin.bottom > 0
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: confineToSafeArea
                                  ? MediaQuery.paddingOf(context).bottom
                                  : 0),
                          child: getNavBarStyle(),
                        )
                      : DecoratedBox(
                          decoration:
                              _PersistentBottomNavigationBarUtilFunctions
                                  .getNavBarDecoration(
                            decoration: navBarDecoration,
                            color: navBarEssentials.backgroundColor,
                            opacity: navBarEssentials
                                .items[navBarEssentials.selectedIndex].opacity,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: confineToSafeArea
                                    ? MediaQuery.paddingOf(context).bottom
                                    : 0),
                            child: getNavBarStyle(),
                          ),
                        )
                  : navBarStyle == NavBarStyle.style15 ||
                          navBarStyle == NavBarStyle.style16
                      ? navBarEssentials.margin.bottom > 0
                          ? DecoratedBox(
                              decoration:
                                  _PersistentBottomNavigationBarUtilFunctions
                                      .getNavBarDecoration(
                                decoration: navBarDecoration,
                                color: navBarEssentials.backgroundColor,
                                opacity: navBarEssentials
                                    .items[navBarEssentials.selectedIndex]
                                    .opacity,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: confineToSafeArea
                                        ? MediaQuery.paddingOf(context).bottom
                                        : 0),
                                child: getNavBarStyle(),
                              ),
                            )
                          : DecoratedBox(
                              decoration:
                                  _PersistentBottomNavigationBarUtilFunctions
                                      .getNavBarDecoration(
                                decoration: navBarDecoration,
                                color: navBarEssentials.backgroundColor,
                                opacity: navBarEssentials
                                    .items[navBarEssentials.selectedIndex]
                                    .opacity,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: confineToSafeArea
                                        ? MediaQuery.paddingOf(context).bottom
                                        : 0),
                                child: getNavBarStyle(),
                              ),
                            )
                      : navBarDecoration.useBackdropFilter
                          ? DecoratedBox(
                              decoration:
                                  _PersistentBottomNavigationBarUtilFunctions
                                      .getNavBarDecoration(
                                decoration: navBarDecoration,
                                showBorder: false,
                                color: navBarEssentials.backgroundColor,
                                opacity: navBarEssentials
                                    .items[navBarEssentials.selectedIndex]
                                    .opacity,
                              ),
                              child: ClipRRect(
                                borderRadius: navBarDecoration.borderRadius ??
                                    BorderRadius.zero,
                                child: BackdropFilter(
                                  filter: navBarEssentials
                                          .items[navBarEssentials.selectedIndex]
                                          .filter ??
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: DecoratedBox(
                                    decoration:
                                        _PersistentBottomNavigationBarUtilFunctions
                                            .getNavBarDecoration(
                                      showOpacity: false,
                                      decoration: navBarDecoration,
                                      color: navBarEssentials.backgroundColor,
                                      opacity: navBarEssentials
                                          .items[navBarEssentials.selectedIndex]
                                          .opacity,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: confineToSafeArea
                                              ? MediaQuery.paddingOf(context)
                                                  .bottom
                                              : 0),
                                      child: getNavBarStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : DecoratedBox(
                              decoration:
                                  _PersistentBottomNavigationBarUtilFunctions
                                      .getNavBarDecoration(
                                showOpacity: false,
                                decoration: navBarDecoration,
                                color: navBarEssentials.backgroundColor,
                                opacity: navBarEssentials
                                    .items[navBarEssentials.selectedIndex]
                                    .opacity,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: confineToSafeArea
                                        ? MediaQuery.paddingOf(context).bottom
                                        : 0),
                                child: getNavBarStyle(),
                              ),
                            ),
          ],
        ),
      );

  @override
  Widget build(final BuildContext context) => _OffsetAnimation(
        hideNavigationBar: hideNavigationBar,
        navBarHeight: navBarEssentials.navBarHeight +
            MediaQuery.paddingOf(context).bottom,
        navBarHideAnimationController: navBarHideAnimationController,
        onAnimationComplete: (final isAnimating, final isComplete) {
          onAnimationComplete!(isAnimating, isComplete);
        },
        child: _navBarWidget(context),
      );

  _PersistentBottomNavBar copyWith(
          {final int? selectedIndex,
          final double? iconSize,
          final int? previousIndex,
          final Color? backgroundColor,
          final Duration? animationDuration,
          final List<PersistentBottomNavBarItem>? items,
          final ValueChanged<int>? onItemSelected,
          final double? navBarHeight,
          final NavBarStyle? navBarStyle,
          final double? horizontalPadding,
          final NeumorphicProperties? neumorphicProperties,
          final Widget? customNavBarWidget,
          final Function(int)? popAllScreensForTheSelectedTab,
          final bool? popScreensOnTapOfSelectedTab,
          final NavBarDecoration? navBarDecoration,
          final _NavBarEssentials? navBarEssentials,
          final bool? confineToSafeArea,
          final ItemAnimationSettings? itemAnimationProperties,
          final Function? onAnimationComplete,
          final AnimationController? navBarHideAnimationController,
          final bool? hideNavigationBar,
          final bool? isCustomWidget,
          final EdgeInsets? padding}) =>
      _PersistentBottomNavBar(
          confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
          navBarHideAnimationController: navBarHideAnimationController ??
              this.navBarHideAnimationController,
          neumorphicProperties:
              neumorphicProperties ?? this.neumorphicProperties,
          navBarStyle: navBarStyle ?? this.navBarStyle,
          hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
          customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
          onAnimationComplete: onAnimationComplete as dynamic Function(
                  bool isAnimating, bool isComplete)? ??
              this.onAnimationComplete,
          navBarEssentials: navBarEssentials ?? this.navBarEssentials,
          isCustomWidget: isCustomWidget ?? this.isCustomWidget,
          navBarDecoration: navBarDecoration ?? this.navBarDecoration);

  bool opaque(final int? index) => navBarEssentials.items.isEmpty
      ? true
      : !(navBarEssentials.items[index!].opacity < 1.0);

  Widget getNavBarStyle() {
    if (isCustomWidget) {
      return customNavBarWidget ?? const SizedBox.shrink();
    } else {
      switch (navBarStyle) {
        case NavBarStyle.style1:
          return _BottomNavStyle1(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style2:
          return _BottomNavStyle2(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style3:
          return _BottomNavStyle3(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style4:
          return _BottomNavStyle4(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style5:
          return _BottomNavStyle5(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style6:
          return _BottomNavStyle6(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style7:
          return _BottomNavStyle7(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style8:
          return _BottomNavStyle8(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style9:
          return _BottomNavStyle9(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style10:
          return _BottomNavStyle10(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style11:
          return _BottomNavStyle11(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style12:
          return _BottomNavStyle12(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style13:
          return _BottomNavStyle13(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style14:
          return _BottomNavStyle14(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.style15:
          return _BottomNavStyle15(
            navBarEssentials: navBarEssentials,
            navBarDecoration: navBarDecoration,
          );
        case NavBarStyle.style16:
          return _BottomNavStyle16(
            navBarEssentials: navBarEssentials,
            navBarDecoration: navBarDecoration,
          );
        case NavBarStyle.style17:
          return _BottomNavStyle17(
            navBarEssentials: navBarEssentials,
            navBarDecoration: navBarDecoration,
          );
        case NavBarStyle.style18:
          return _BottomNavStyle18(
            navBarEssentials: navBarEssentials,
            navBarDecoration: navBarDecoration,
          );
        case NavBarStyle.style19:
          return _BottomNavStyle19(
            navBarEssentials: navBarEssentials,
          );
        case NavBarStyle.neumorphic:
          return _NeumorphicBottomNavBar(
            navBarEssentials: navBarEssentials,
            neumorphicProperties:
                neumorphicProperties ?? const NeumorphicProperties(),
          );
        default:
          return _BottomNavSimple(
            navBarEssentials: navBarEssentials,
          );
      }
    }
  }
}
