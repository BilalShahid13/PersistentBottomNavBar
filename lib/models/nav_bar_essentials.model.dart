part of persistent_bottom_nav_bar;

class _NavBarEssentials {
  const _NavBarEssentials({
    required this.items,
    required this.selectedIndex,
    required this.previousIndex,
    required this.backgroundColor,
    required this.itemAnimationProperties,
    required this.onItemSelected,
    required this.padding,
    required this.margin,
    required this.navBarItemsAlignment,
    this.selectedScreenBuildContext,
    this.navBarHeight = 0.0,
  });

  final int selectedIndex;
  final int previousIndex;
  final Color backgroundColor;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int>? onItemSelected;
  final double navBarHeight;
  final EdgeInsets padding;
  final ItemAnimationSettings itemAnimationProperties;
  final BuildContext? selectedScreenBuildContext;
  final MainAxisAlignment navBarItemsAlignment;
  final EdgeInsets margin;

  _NavBarEssentials copyWith({
    final int? selectedIndex,
    final int? previousIndex,
    final double? iconSize,
    final Color? backgroundColor,
    final List<PersistentBottomNavBarItem>? items,
    final ValueChanged<int>? onItemSelected,
    final double? navBarHeight,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final Function(int)? popAllScreensForTheSelectedTab,
    final ItemAnimationSettings? itemAnimationProperties,
    final BuildContext? selectedScreenBuildContext,
    final MainAxisAlignment? navBarItemsAlignment,
  }) =>
      _NavBarEssentials(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        previousIndex: previousIndex ?? this.previousIndex,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        items: items ?? this.items,
        onItemSelected: onItemSelected ?? this.onItemSelected,
        navBarHeight: navBarHeight ?? this.navBarHeight,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        itemAnimationProperties:
            itemAnimationProperties ?? this.itemAnimationProperties,
        selectedScreenBuildContext:
            selectedScreenBuildContext ?? this.selectedScreenBuildContext,
        navBarItemsAlignment: navBarItemsAlignment ?? this.navBarItemsAlignment,
      );
}
