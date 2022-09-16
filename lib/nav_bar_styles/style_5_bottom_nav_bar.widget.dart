part of persistent_bottom_nav_bar;

class BottomNavStyle5 extends StatelessWidget {
  const BottomNavStyle5({
    final Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : SizedBox(
              width: 150,
              height: height! / 1,
              child: Container(
                alignment: Alignment.center,
                height: height / 1,
                child: Column(
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
                        child: isSelected
                            ? item.icon
                            : item.inactiveIcon ?? item.icon,
                      ),
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isSelected
                              ? (item.activeColorSecondary ??
                                  item.activeColorPrimary)
                              : Colors.transparent),
                    ),
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: navBarEssentials!.navBarHeight,
        padding: EdgeInsets.only(
            left: navBarEssentials!.padding?.left ??
                MediaQuery.of(context).size.width * 0.05,
            right: navBarEssentials!.padding?.right ??
                MediaQuery.of(context).size.width * 0.05,
            top: navBarEssentials!.padding?.top ??
                navBarEssentials!.navBarHeight! * 0.06,
            bottom: navBarEssentials!.padding?.bottom ??
                navBarEssentials!.navBarHeight! * 0.16),
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
                child: Container(
                  color: Colors.transparent,
                  child: _buildItem(
                      item,
                      navBarEssentials!.selectedIndex == index,
                      navBarEssentials!.navBarHeight),
                ),
              ),
            );
          }).toList(),
        ),
      );
}
