part of persistent_bottom_nav_bar;

class BottomNavStyle18 extends StatelessWidget {
  const BottomNavStyle18({
    final Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
    this.navBarDecoration = const NavBarDecoration(),
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;
  final NavBarDecoration? navBarDecoration;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : Container(
              width: 150,
              height: height,
              padding: EdgeInsets.only(
                  top: navBarEssentials!.padding?.top ??
                      navBarEssentials!.navBarHeight! * 0.15,
                  bottom: navBarEssentials!.padding?.bottom ??
                      navBarEssentials!.navBarHeight! * 0.12),
              child: Container(
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

  Widget _buildMiddleItem(
          final BuildContext context,
          final PersistentBottomNavBarItem item,
          final bool isSelected,
          final double? height) =>
      navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : Container(
              width: MediaQuery.of(context).size.width / 5.0,
              margin: EdgeInsets.only(
                  top: navBarEssentials!.padding?.top ??
                      navBarEssentials!.navBarHeight! * 0.1,
                  bottom: navBarEssentials!.padding?.bottom ??
                      navBarEssentials!.navBarHeight! * 0.1,
                  left: 10,
                  right: 10),
              decoration: BoxDecoration(
                color: item.activeColorPrimary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent, width: 5),
              ),
              child: Container(
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
                      ],
                    )
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) {
    final midIndex = (navBarEssentials!.items!.length / 2).floor();
    return ClipRRect(
      borderRadius: navBarDecoration!.borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: navBarEssentials!.navBarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: navBarEssentials!.items!.map((final item) {
                    final int index = navBarEssentials!.items!.indexOf(item);
                    return index != midIndex
                        ? Flexible(
                            child: GestureDetector(
                              onTap: () {
                                if (navBarEssentials!.items![index].onPressed !=
                                    null) {
                                  navBarEssentials!.items![index].onPressed!(
                                      navBarEssentials!
                                          .selectedScreenBuildContext);
                                } else {
                                  navBarEssentials!.onItemSelected!(index);
                                }
                              },
                              child: index == midIndex
                                  ? Opacity(
                                      opacity: 0,
                                      child: _buildMiddleItem(
                                          context,
                                          item,
                                          navBarEssentials!.selectedIndex ==
                                              index,
                                          navBarEssentials!.navBarHeight))
                                  : _buildItem(
                                      item,
                                      navBarEssentials!.selectedIndex == index,
                                      navBarEssentials!.navBarHeight),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (navBarEssentials!.items![index].onPressed !=
                                  null) {
                                navBarEssentials!.items![index].onPressed!(
                                    navBarEssentials!
                                        .selectedScreenBuildContext);
                              } else {
                                navBarEssentials!.onItemSelected!(index);
                              }
                            },
                            child: index == midIndex
                                ? Opacity(
                                    opacity: 0,
                                    child: _buildMiddleItem(
                                        context,
                                        item,
                                        navBarEssentials!.selectedIndex ==
                                            index,
                                        navBarEssentials!.navBarHeight))
                                : _buildItem(
                                    item,
                                    navBarEssentials!.selectedIndex == index,
                                    navBarEssentials!.navBarHeight),
                          );
                  }).toList(),
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        if (navBarEssentials!.items![midIndex].onPressed !=
                            null) {
                          navBarEssentials!.items![midIndex].onPressed!(
                              navBarEssentials!.selectedScreenBuildContext);
                        } else {
                          navBarEssentials!.onItemSelected!(midIndex);
                        }
                      },
                      child: _buildMiddleItem(
                          context,
                          navBarEssentials!.items![midIndex],
                          navBarEssentials!.selectedIndex == midIndex,
                          navBarEssentials!.navBarHeight)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
