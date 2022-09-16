part of persistent_bottom_nav_bar;

class NavBarEssentials {
  const NavBarEssentials({
    required this.items,
    this.selectedIndex,
    this.previousIndex,
    this.backgroundColor,
    this.popScreensOnTapOfSelectedTab,
    this.popAllScreensOnTapAnyTabs,
    this.itemAnimationProperties,
    this.navBarHeight = 0.0,
    this.onItemSelected,
    this.padding,
    this.selectedScreenBuildContext,
  });

  final int? selectedIndex;
  final int? previousIndex;
  final Color? backgroundColor;
  final List<PersistentBottomNavBarItem>? items;
  final ValueChanged<int>? onItemSelected;
  final double? navBarHeight;
  final NavBarPadding? padding;
  final bool? popScreensOnTapOfSelectedTab;
  final bool? popAllScreensOnTapAnyTabs;
  final ItemAnimationProperties? itemAnimationProperties;
  final BuildContext? selectedScreenBuildContext;

  NavBarEssentials copyWith({
    final int? selectedIndex,
    final int? previousIndex,
    final double? iconSize,
    final Color? backgroundColor,
    final List<PersistentBottomNavBarItem>? items,
    final ValueChanged<int>? onItemSelected,
    final double? navBarHeight,
    final NavBarPadding? padding,
    final Function(int)? popAllScreensForTheSelectedTab,
    final bool? popScreensOnTapOfSelectedTab,
    final ItemAnimationProperties? itemAnimationProperties,
  }) =>
      NavBarEssentials(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        previousIndex: previousIndex ?? this.previousIndex,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        items: items ?? this.items,
        onItemSelected: onItemSelected ?? this.onItemSelected,
        navBarHeight: navBarHeight ?? this.navBarHeight,
        padding: padding ?? this.padding,
        popScreensOnTapOfSelectedTab:
            popScreensOnTapOfSelectedTab ?? this.popScreensOnTapOfSelectedTab,
        itemAnimationProperties:
            itemAnimationProperties ?? this.itemAnimationProperties,
      );
}
