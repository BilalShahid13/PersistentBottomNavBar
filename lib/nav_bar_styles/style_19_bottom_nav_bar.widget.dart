part of persistent_bottom_nav_bar;

class BottomNavStyle19 extends StatelessWidget {
  const BottomNavStyle19({
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
              height: height,
              child: Center(
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
            );

  @override
  Widget build(final BuildContext context) {
    final padding = EdgeInsets.only(
      left: navBarEssentials!.padding?.left ??
          MediaQuery.of(context).size.width * 0.05,
      right: navBarEssentials!.padding?.right ??
          MediaQuery.of(context).size.width * 0.05,
      top: navBarEssentials!.padding?.top ??
          navBarEssentials!.navBarHeight! * 0.06,
      bottom: navBarEssentials!.padding?.bottom ??
          navBarEssentials!.navBarHeight! * 0.16,
    );
    final double itemWidth = (MediaQuery.of(context).size.width -
            ((navBarEssentials!.padding?.left ??
                    MediaQuery.of(context).size.width * 0.05) +
                (navBarEssentials!.padding?.right ??
                    MediaQuery.of(context).size.width * 0.05))) /
        navBarEssentials!.items!.length;
    return SizedBox(
      width: double.infinity,
      height: navBarEssentials!.navBarHeight,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -20),
            child: CurvedBazier(
              color: navBarEssentials?.backgroundColor?.withOpacity(
                      navBarEssentials!
                          .items![navBarEssentials!.selectedIndex!].opacity) ??
                  Colors.white,
              index: navBarEssentials?.selectedIndex ?? 0,
              numberOfTabItems: navBarEssentials?.items?.length ?? 0,
              padding: padding,
            ),
          ),
          Padding(
            padding: padding,
            child: Stack(
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration:
                          navBarEssentials!.itemAnimationProperties!.duration ??
                              const Duration(milliseconds: 300),
                      curve: navBarEssentials!.itemAnimationProperties!.curve ??
                          Curves.ease,
                      color: Colors.transparent,
                      width: navBarEssentials!.selectedIndex == 0
                          ? 0
                          : itemWidth * navBarEssentials!.selectedIndex!,
                      height: 4,
                    ),
                    Flexible(
                      child: Transform.translate(
                        offset: const Offset(0, -5),
                        child: Transform.scale(
                          scale: 1.6,
                          child: AnimatedContainer(
                            duration: navBarEssentials!
                                    .itemAnimationProperties!.duration ??
                                const Duration(milliseconds: 300),
                            curve: navBarEssentials!
                                    .itemAnimationProperties!.curve ??
                                Curves.ease,
                            width: itemWidth,
                            height: itemWidth,
                            alignment: Alignment.center,
                            child: Container(
                              height: itemWidth,
                              width: itemWidth,
                              decoration: BoxDecoration(
                                color: navBarEssentials?.backgroundColor
                                        ?.withOpacity(navBarEssentials!
                                            .items![navBarEssentials!
                                                .selectedIndex!]
                                            .opacity) ??
                                    Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: navBarEssentials!.items!.map((final item) {
                    final int index = navBarEssentials!.items!.indexOf(item);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (navBarEssentials!.items![index].onPressed !=
                              null) {
                            navBarEssentials!.items![index].onPressed!(
                                navBarEssentials!.selectedScreenBuildContext);
                          } else {
                            navBarEssentials!.onItemSelected!(index);
                          }
                        },
                        child: _buildItem(
                          item,
                          navBarEssentials!.selectedIndex == index,
                          (navBarEssentials!.navBarHeight ??
                                  kBottomNavigationBarHeight) -
                              20,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
