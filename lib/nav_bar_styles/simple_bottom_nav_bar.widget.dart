part of persistent_bottom_nav_bar;

class BottomNavSimple extends StatelessWidget {
  const BottomNavSimple({
    final Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: 150,
              height: height,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.center,
                height: height,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
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
                        if (item.title == null)
                          const SizedBox.shrink()
                        else
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
                                            : item.inactiveColorPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                              )),
                            ),
                          )
                      ],
                    )
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
                    item,
                    navBarEssentials!.selectedIndex == index,
                    navBarEssentials!.navBarHeight),
              ),
            );
          }).toList(),
        ),
      );
}
