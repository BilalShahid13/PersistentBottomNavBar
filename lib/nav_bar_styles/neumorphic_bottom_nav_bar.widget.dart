part of persistent_bottom_nav_bar;

class NeumorphicBottomNavBar extends StatelessWidget {
  const NeumorphicBottomNavBar({
    final Key? key,
    this.navBarEssentials,
    this.neumorphicProperties = const NeumorphicProperties(),
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;
  final NeumorphicProperties? neumorphicProperties;

  Widget _getNavItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      neumorphicProperties != null && neumorphicProperties!.showSubtitleText
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
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : PersistentBottomNavigationBarUtilFunctions.opaque(
                  navBarEssentials!.items!, navBarEssentials!.selectedIndex)
              ? NeumorphicContainer(
                  decoration: NeumorphicDecoration(
                    borderRadius: BorderRadius.circular(
                        neumorphicProperties == null
                            ? 15.0
                            : neumorphicProperties!.borderRadius),
                    color: navBarEssentials!.backgroundColor,
                    border: neumorphicProperties == null
                        ? null
                        : neumorphicProperties!.border,
                    shape: neumorphicProperties == null
                        ? BoxShape.rectangle
                        : neumorphicProperties!.shape,
                  ),
                  bevel: neumorphicProperties == null
                      ? 12.0
                      : neumorphicProperties!.bevel,
                  curveType: isSelected
                      ? CurveType.emboss
                      : neumorphicProperties == null
                          ? CurveType.concave
                          : neumorphicProperties!.curveType,
                  height: height! + 20,
                  width: 60,
                  padding: const EdgeInsets.all(6),
                  child: _getNavItem(item, isSelected, height),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: PersistentBottomNavigationBarUtilFunctions
                        .getBackgroundColor(
                            context,
                            navBarEssentials!.items,
                            navBarEssentials!.backgroundColor,
                            navBarEssentials!.selectedIndex),
                  ),
                  height: height! + 20,
                  width: 60,
                  padding: const EdgeInsets.all(6),
                  child: _getNavItem(item, isSelected, height),
                );

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: navBarEssentials!.navBarHeight,
        padding: EdgeInsets.only(
            left: navBarEssentials!.padding?.left ??
                MediaQuery.of(context).size.width * 0.04,
            right: navBarEssentials!.padding?.right ??
                MediaQuery.of(context).size.width * 0.04,
            top: navBarEssentials!.padding?.top ??
                navBarEssentials!.navBarHeight! * 0.15,
            bottom: navBarEssentials!.padding?.bottom ??
                navBarEssentials!.navBarHeight! * 0.12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navBarEssentials!.items!.map((final item) {
            final int index = navBarEssentials!.items!.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  if (navBarEssentials!.items![index].onPressed != null) {
                    navBarEssentials!.items![index].onPressed!(
                        navBarEssentials!.selectedScreenBuildContext);
                  } else {
                    navBarEssentials!.onItemSelected!(index);
                  }
                },
                child: _buildItem(
                    context,
                    item,
                    navBarEssentials!.selectedIndex == index,
                    navBarEssentials!.navBarHeight),
              ),
            );
          }).toList(),
        ),
      );
}
