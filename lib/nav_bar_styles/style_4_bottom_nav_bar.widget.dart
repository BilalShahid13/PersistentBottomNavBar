part of persistent_bottom_nav_bar;

class _BottomNavStyle4 extends StatelessWidget {
  const _BottomNavStyle4({
    required this.navBarEssentials,
    final Key? key,
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: 100,
              height: height,
              duration: navBarEssentials.itemAnimationProperties.duration,
              curve: navBarEssentials.itemAnimationProperties.curve,
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: navBarEssentials.itemAnimationProperties.duration,
                curve: navBarEssentials.itemAnimationProperties.curve,
                height: height! / 1.6,
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
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Material(
                          type: MaterialType.transparency,
                          child: DefaultTextStyle.merge(
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
                            child: FittedBox(
                                child: Text(isSelected ? item.title! : " ")),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) {
    final Color selectedItemActiveColor = navBarEssentials
        .items[navBarEssentials.selectedIndex].activeColorPrimary;
    final double itemWidth = (MediaQuery.of(context).size.width -
            ((navBarEssentials.padding.left + navBarEssentials.padding.right) +
                (navBarEssentials.margin.left +
                    navBarEssentials.margin.right))) /
        navBarEssentials.items.length;
    return Container(
      width: double.infinity,
      height: navBarEssentials.navBarHeight,
      padding: navBarEssentials.padding,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: navBarEssentials.itemAnimationProperties.duration,
                curve: navBarEssentials.itemAnimationProperties.curve,
                color: Colors.transparent,
                width: navBarEssentials.selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * navBarEssentials.selectedIndex,
                height: 4,
              ),
              Flexible(
                child: AnimatedContainer(
                  duration: navBarEssentials.itemAnimationProperties.duration,
                  curve: navBarEssentials.itemAnimationProperties.curve,
                  width: itemWidth,
                  height: 4,
                  alignment: Alignment.center,
                  child: Container(
                    height: 4,
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: selectedItemActiveColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
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
                      child: Container(
                        color: Colors.transparent,
                        child: _buildItem(
                            item,
                            navBarEssentials.selectedIndex == index,
                            navBarEssentials.navBarHeight),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
