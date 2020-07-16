part of persistent_bottom_nav_bar;

class PersistentBottomNavBar extends StatelessWidget {
  const PersistentBottomNavBar(
      {Key key,
      this.selectedIndex,
      this.previousIndex,
      this.iconSize,
      this.backgroundColor,
      this.items,
      this.navBarHeight,
      this.onItemSelected,
      this.decoration,
      this.padding,
      this.confineToSafeArea,
      this.customNavBarWidget,
      this.popScreensOnTapOfSelectedTab,
      this.popAllScreensForTheSelectedTab,
      this.itemAnimationProperties,
      this.hideNavigationBar,
      this.onAnimationComplete,
      this.neumorphicProperties = const NeumorphicProperties(),
      this.navBarStyle})
      : super(key: key);

  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarDecoration decoration;
  final NavBarStyle navBarStyle;
  final NavBarPadding padding;
  final NeumorphicProperties neumorphicProperties;
  final Widget customNavBarWidget;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;
  final bool confineToSafeArea;
  final ItemAnimationProperties itemAnimationProperties;
  final bool hideNavigationBar;
  final Function(bool, bool) onAnimationComplete;

  Widget _navBarWidget() => this.navBarStyle == NavBarStyle.custom
      ? Container(
          color: this.backgroundColor,
          child: SafeArea(top: false, child: this.customNavBarWidget),
        )
      : this.navBarStyle == NavBarStyle.style15 ||
              this.navBarStyle == NavBarStyle.style16
          ? Container(
              decoration: getNavBarDecoration(
                decoration: this.decoration,
                color: this.backgroundColor,
                opacity: items[selectedIndex].opacity,
              ),
              child: SafeArea(
                top: false,
                right: false,
                left: false,
                bottom: this.navBarHeight == 0.0 ||
                        (this.hideNavigationBar ?? false)
                    ? false
                    : confineToSafeArea ?? true,
                child: getNavBarStyle(),
              ),
            )
          : Container(
              decoration: getNavBarDecoration(
                decoration: this.decoration,
                showBorder: false,
                color: this.backgroundColor,
                opacity: items[selectedIndex].opacity,
              ),
              child: ClipRRect(
                borderRadius: this.decoration.borderRadius ?? BorderRadius.zero,
                child: BackdropFilter(
                  filter: this.items[this.selectedIndex].filter ??
                      ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration: getNavBarDecoration(
                      showOpacity: false,
                      decoration: this.decoration,
                      color: this.backgroundColor,
                      opacity: items[selectedIndex].opacity,
                    ),
                    child: SafeArea(
                      top: false,
                      right: false,
                      left: false,
                      bottom: this.navBarHeight == 0.0 ||
                              (this.hideNavigationBar ?? false)
                          ? false
                          : confineToSafeArea ?? true,
                      child: getNavBarStyle(),
                    ),
                  ),
                ),
              ),
            );

  @override
  Widget build(BuildContext context) {
    return this.hideNavigationBar == null
        ? _navBarWidget()
        : OffsetAnimation(
            hideNavigationBar: this.hideNavigationBar,
            navBarHeight: this.navBarHeight,
            onAnimationComplete: (isAnimating, isComplete) {
              this.onAnimationComplete(isAnimating, isComplete);
            },
            child: _navBarWidget(),
          );
  }

  PersistentBottomNavBar copyWith(
      {int selectedIndex,
      double iconSize,
      int previousIndex,
      Color backgroundColor,
      Duration animationDuration,
      List<PersistentBottomNavBarItem> items,
      ValueChanged<int> onItemSelected,
      double navBarHeight,
      NavBarStyle navBarStyle,
      double horizontalPadding,
      NeumorphicProperties neumorphicProperties,
      Widget customNavBarWidget,
      Function(int) popAllScreensForTheSelectedTab,
      bool popScreensOnTapOfSelectedTab,
      NavBarDecoration decoration,
      bool confineToSafeArea,
      ItemAnimationProperties itemAnimationProperties,
      Function onAnimationComplete,
      bool hideNavigationBar,
      EdgeInsets padding}) {
    return PersistentBottomNavBar(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        previousIndex: previousIndex ?? this.previousIndex,
        iconSize: iconSize ?? this.iconSize,
        confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        items: items ?? this.items,
        itemAnimationProperties:
            itemAnimationProperties ?? this.itemAnimationProperties,
        popAllScreensForTheSelectedTab: popAllScreensForTheSelectedTab ??
            this.popAllScreensForTheSelectedTab,
        onItemSelected: onItemSelected ?? this.onItemSelected,
        navBarHeight: navBarHeight ?? this.navBarHeight,
        neumorphicProperties: neumorphicProperties ?? this.neumorphicProperties,
        navBarStyle: navBarStyle ?? this.navBarStyle,
        padding: padding ?? this.padding,
        hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
        customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
        onAnimationComplete: onAnimationComplete ?? this.onAnimationComplete,
        popScreensOnTapOfSelectedTab:
            popScreensOnTapOfSelectedTab ?? this.popScreensOnTapOfSelectedTab,
        decoration: decoration ?? this.decoration);
  }

  bool opaque(int index) {
    return items == null ? true : !(items[index].opacity < 1.0);
  }

  Widget getNavBarStyle() {
    switch (navBarStyle) {
      case NavBarStyle.custom:
        return customNavBarWidget;
      case NavBarStyle.style1:
        return BottomNavStyle1(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style2:
        return BottomNavStyle2(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style3:
        return BottomNavStyle3(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style4:
        return BottomNavStyle4(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style5:
        return BottomNavStyle5(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style6:
        return BottomNavStyle6(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style7:
        return BottomNavStyle7(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style8:
        return BottomNavStyle8(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style9:
        return BottomNavStyle9(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style10:
        return BottomNavStyle10(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
      case NavBarStyle.style11:
        return BottomNavStyle11(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          decoration: this.decoration,
          padding: this.padding,
        );
      case NavBarStyle.style12:
        return BottomNavStyle12(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.style13:
        return BottomNavStyle13(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.style14:
        return BottomNavStyle14(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.style15:
        return BottomNavStyle15(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.style16:
        return BottomNavStyle16(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.style17:
        return BottomNavStyle17(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.style18:
        return BottomNavStyle18(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          decoration: this.decoration,
        );
      case NavBarStyle.neumorphic:
        return NeumorphicBottomNavBar(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
          neumorphicProperties: this.neumorphicProperties,
        );
      default:
        return BottomNavSimple(
          items: this.items,
          backgroundColor: this.backgroundColor,
          iconSize: this.iconSize,
          navBarHeight: this.navBarHeight,
          onItemSelected: this.onItemSelected,
          selectedIndex: this.selectedIndex,
          itemAnimationProperties: itemAnimationProperties,
          previousIndex: this.previousIndex,
          popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
          popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
          padding: this.padding,
        );
    }
  }
}
