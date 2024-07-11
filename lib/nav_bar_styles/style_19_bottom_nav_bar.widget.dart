part of persistent_bottom_nav_bar;

class _BottomNavStyle19 extends StatelessWidget {
  const _BottomNavStyle19({
    required this.navBarEssentials,
    final Key? key,
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
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
    final double itemWidth = (MediaQuery.of(context).size.width -
            ((navBarEssentials.padding.left + navBarEssentials.padding.right) +
                (navBarEssentials.margin.left +
                    navBarEssentials.margin.right))) /
        navBarEssentials.items.length;
    return SizedBox(
      width: double.infinity,
      height: navBarEssentials.navBarHeight,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -20),
            child: _CurvedBazier(
              color: navBarEssentials.backgroundColor.withOpacity(
                  navBarEssentials
                      .items[navBarEssentials.selectedIndex].opacity),
              index: navBarEssentials.selectedIndex,
              numberOfTabItems: navBarEssentials.items.length,
              padding: navBarEssentials.padding,
            ),
          ),
          Padding(
            padding: navBarEssentials.padding,
            child: Stack(
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration:
                          navBarEssentials.itemAnimationProperties.duration,
                      curve: navBarEssentials.itemAnimationProperties.curve,
                      color: Colors.transparent,
                      width: navBarEssentials.selectedIndex == 0
                          ? 0
                          : itemWidth * navBarEssentials.selectedIndex,
                      height: 4,
                    ),
                    Flexible(
                      child: Transform.translate(
                        offset: const Offset(0, -5),
                        child: Transform.scale(
                          scale: 1.6,
                          child: AnimatedContainer(
                            duration: navBarEssentials
                                .itemAnimationProperties.duration,
                            curve:
                                navBarEssentials.itemAnimationProperties.curve,
                            width: itemWidth,
                            height: itemWidth,
                            alignment: Alignment.center,
                            child: Container(
                              height: itemWidth,
                              width: itemWidth,
                              decoration: BoxDecoration(
                                color: navBarEssentials.backgroundColor
                                    .withOpacity(navBarEssentials
                                        .items[navBarEssentials.selectedIndex]
                                        .opacity),
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
                  children: navBarEssentials.items.map((final item) {
                    final int index = navBarEssentials.items.indexOf(item);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (index != navBarEssentials.selectedIndex) {
                            navBarEssentials
                                .items[index].iconAnimationController
                                ?.forward();
                            navBarEssentials
                                .items[navBarEssentials.selectedIndex]
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
                          item,
                          navBarEssentials.selectedIndex == index,
                          navBarEssentials.navBarHeight - 20,
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
