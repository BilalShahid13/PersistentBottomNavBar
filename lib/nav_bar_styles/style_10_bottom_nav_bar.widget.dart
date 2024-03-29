part of persistent_bottom_nav_bar;

class BottomNavStyle10 extends StatelessWidget {
  const BottomNavStyle10({
    final Key? key,
    this.navBarEssentials,
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: isSelected ? 120 : 50,
              height: height! / 1.5,
              duration: navBarEssentials!.itemAnimationProperties?.duration ??
                  const Duration(milliseconds: 400),
              curve: navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease,
              padding: EdgeInsets.all(item.contentPadding),
              decoration: isSelected
                  ? BoxDecoration(
                      color: isSelected
                          ? item.activeColorPrimary
                          : navBarEssentials!.backgroundColor!.withOpacity(0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    )
                  : BoxDecoration(
                      color: isSelected
                          ? item.activeColorPrimary
                          : navBarEssentials!.backgroundColor!.withOpacity(0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
              child: Container(
                alignment: Alignment.center,
                height: height / 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconTheme(
                        data: IconThemeData(
                            size: item.iconSize,
                            color: isSelected
                                ? (item.activeColorSecondary ??
                                    item.activeColorPrimary)
                                : item.inactiveColorPrimary ??
                                    item.activeColorPrimary),
                        child: item.iconBuilder != null
                            ? item.iconBuilder!(isSelected, item.icon)
                            : isSelected
                                ? item.icon
                                : item.inactiveIcon ?? item.icon,
                      ),
                    ),
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      isSelected
                          ? Flexible(
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
                                          color: item.activeColorSecondary ??
                                              item.activeColorPrimary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                )),
                              ),
                            )
                          : const SizedBox.shrink()
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: navBarEssentials!.navBarHeight,
        padding: EdgeInsets.only(
            top: navBarEssentials!.padding?.top ??
                navBarEssentials!.navBarHeight! * 0.15,
            left: navBarEssentials!.padding?.left ??
                MediaQuery.of(context).size.width * 0.07,
            right: navBarEssentials!.padding?.right ??
                MediaQuery.of(context).size.width * 0.07,
            bottom: navBarEssentials!.padding?.bottom ??
                navBarEssentials!.navBarHeight! * 0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navBarEssentials!.items!.map((final item) {
            final int index = navBarEssentials!.items!.indexOf(item);
            return Flexible(
              flex: navBarEssentials!.selectedIndex == index ? 2 : 1,
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
