part of persistent_bottom_nav_bar;

class _NeumorphicBottomNavBar extends StatelessWidget {
  const _NeumorphicBottomNavBar({
    required this.navBarEssentials,
    required this.neumorphicProperties,
    final Key? key,
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;
  final NeumorphicProperties neumorphicProperties;

  Widget _getNavItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      neumorphicProperties.showSubtitleText
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: IconTheme(
                    data: IconThemeData(
                        size: item.iconSize,
                        color: isSelected
                            ? (item.activeColorSecondary ??
                                item.activeColorPrimary)
                            : item.inactiveColorPrimary ??
                                item.activeColorPrimary),
                    child:
                        isSelected ? item.icon : item.inactiveIcon ?? item.icon,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Material(
                    type: MaterialType.transparency,
                    child: FittedBox(
                        child: Text(
                      item.title!,
                      style: item.textStyle != null
                          ? (item.textStyle!.apply(
                              color: isSelected
                                  ? (item.activeColorSecondary ??
                                      item.activeColorPrimary)
                                  : item.inactiveColorPrimary))
                          : TextStyle(
                              color: isSelected
                                  ? (item.activeColorSecondary ??
                                      item.activeColorPrimary)
                                  : item.inactiveColorPrimary ??
                                      item.activeColorPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                    )),
                  ),
                )
              ],
            )
          : IconTheme(
              data: IconThemeData(
                  size: item.iconSize,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
            );

  Widget _buildItem(
          final BuildContext context,
          final PersistentBottomNavBarItem item,
          final bool isSelected,
          final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : _PersistentBottomNavigationBarUtilFunctions.opaque(
                  navBarEssentials.items, navBarEssentials.selectedIndex)
              ? _NeumorphicContainer(
                  decoration: NeumorphicDecoration(
                    borderRadius: BorderRadius.circular(
                        neumorphicProperties.borderRadius),
                    color: navBarEssentials.backgroundColor,
                    border: neumorphicProperties.border,
                    shape: neumorphicProperties.shape,
                  ),
                  bevel: neumorphicProperties.bevel,
                  curveType: isSelected
                      ? CurveType.emboss
                      : neumorphicProperties.curveType,
                  height: height! + 20,
                  width: 60,
                  padding: const EdgeInsets.all(6),
                  child: _getNavItem(item, isSelected, height),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _PersistentBottomNavigationBarUtilFunctions
                        .getBackgroundColor(
                            context,
                            navBarEssentials.items,
                            navBarEssentials.backgroundColor,
                            navBarEssentials.selectedIndex),
                  ),
                  height: height! + 20,
                  width: 60,
                  padding: const EdgeInsets.all(6),
                  child: _getNavItem(item, isSelected, height),
                );

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: navBarEssentials.navBarHeight,
        padding: navBarEssentials.padding,
        child: Row(
          mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
          children: navBarEssentials.items.map((final item) {
            final int index = navBarEssentials.items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  if (index != navBarEssentials.selectedIndex) {
                    navBarEssentials.items[index].iconAnimationController
                        ?.forward();
                    navBarEssentials.items[navBarEssentials.selectedIndex]
                        .iconAnimationController
                        ?.reverse();
                  }
                  if (navBarEssentials.items[index].onPressed != null) {
                    navBarEssentials.items[index].onPressed!(
                        navBarEssentials.selectedScreenBuildContext);
                  } else {
                    navBarEssentials.onItemSelected?.call(index);
                  }
                },
                child: _buildItem(
                    context,
                    item,
                    navBarEssentials.selectedIndex == index,
                    navBarEssentials.navBarHeight),
              ),
            );
          }).toList(),
        ),
      );
}
