part of persistent_bottom_nav_bar;

class BottomNavStyle16 extends StatelessWidget {
  const BottomNavStyle16({
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
          : Padding(
              padding: EdgeInsets.only(
                  top: navBarEssentials!.padding?.top ?? 0.0,
                  bottom: navBarEssentials!.padding?.bottom ?? 0.0),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: const Offset(0, -23),
                    child: Center(
                      child: Container(
                        width: height! - 5.0,
                        height: height - 5.0,
                        margin:
                            const EdgeInsets.only(top: 2, left: 6, right: 6),
                        decoration: BoxDecoration(
                          color: item.activeColorPrimary,
                          border:
                              Border.all(color: Colors.transparent, width: 5),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: navBarDecoration!.boxShadow,
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
                                        color: item.activeColorSecondary ??
                                            item.activeColorPrimary,
                                      ),
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
                      ),
                    ),
                  ),
                  if (item.title == null)
                    const SizedBox.shrink()
                  else
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: Alignment.bottomCenter,
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
                                        ? (item.activeColorPrimary)
                                        : item.inactiveColorPrimary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                          )),
                        ),
                      ),
                    )
                ],
              ),
            );

  @override
  Widget build(final BuildContext context) {
    final midIndex = (navBarEssentials!.items!.length / 2).floor();
    return SizedBox(
      width: double.infinity,
      height: navBarEssentials!.navBarHeight,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: navBarDecoration!.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: navBarEssentials!
                      .items![navBarEssentials!.selectedIndex!].filter ??
                  ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
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
                      child: index == midIndex
                          ? Container(width: 150, color: Colors.transparent)
                          : _buildItem(
                              item,
                              navBarEssentials!.selectedIndex == index,
                              navBarEssentials!.navBarHeight),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (navBarEssentials!.navBarHeight == 0)
            const SizedBox.shrink()
          else
            Center(
              child: GestureDetector(
                  onTap: () {
                    if (navBarEssentials!.items![midIndex].onPressed != null) {
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
    );
  }
}
