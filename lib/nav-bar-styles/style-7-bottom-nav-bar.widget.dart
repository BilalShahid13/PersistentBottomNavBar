part of persistent_bottom_nav_bar;

class BottomNavStyle7 extends StatelessWidget {
  final NavBarEssentials navBarEssentials;

  BottomNavStyle7({
    Key key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarEssentials.navBarHeight == 0
        ? SizedBox.shrink()
        : AnimatedContainer(
            width: isSelected ? 120 : 50,
            height: height / 1.6,
            duration: this.navBarEssentials.itemAnimationProperties?.duration ??
                Duration(milliseconds: 400),
            curve: this.navBarEssentials.itemAnimationProperties?.curve ??
                Curves.ease,
            padding: EdgeInsets.all(item.contentPadding),
            decoration: isSelected
                ? BoxDecoration(
                    color: isSelected
                        ? item.activeColorPrimary
                        : this
                            .navBarEssentials
                            .backgroundColor
                            .withOpacity(0.0),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  )
                : BoxDecoration(
                    color: isSelected
                        ? item.activeColorPrimary
                        : this
                            .navBarEssentials
                            .backgroundColor
                            .withOpacity(0.0),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
            child: Container(
              alignment: Alignment.center,
              height: height / 1.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconTheme(
                      data: IconThemeData(
                          size: item.iconSize,
                          color: isSelected
                              ? (item.activeColorSecondary == null
                                  ? item.activeColorPrimary
                                  : item.activeColorSecondary)
                              : item.inactiveColorPrimary == null
                                  ? item.activeColorPrimary
                                  : item.inactiveColorPrimary),
                      child: isSelected
                          ? item.icon
                          : item.inactiveIcon ?? item.icon,
                    ),
                  ),
                  item.title == null
                      ? SizedBox.shrink()
                      : isSelected
                          ? Flexible(
                              child: Material(
                                type: MaterialType.transparency,
                                child: FittedBox(
                                    child: Text(
                                  item.title,
                                  style: item.textStyle != null
                                      ? (item.textStyle.apply(
                                          color: isSelected
                                              ? (item.activeColorSecondary ==
                                                      null
                                                  ? item.activeColorPrimary
                                                  : item.activeColorSecondary)
                                              : item.inactiveColorPrimary))
                                      : TextStyle(
                                          color:
                                              (item.activeColorSecondary == null
                                                  ? item.activeColorPrimary
                                                  : item.activeColorSecondary),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0),
                                )),
                              ),
                            )
                          : SizedBox.shrink()
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.navBarEssentials.navBarHeight,
      padding: EdgeInsets.only(
          top: this.navBarEssentials.padding?.top ??
              this.navBarEssentials.navBarHeight * 0.15,
          left: this.navBarEssentials.padding?.left ??
              MediaQuery.of(context).size.width * 0.07,
          right: this.navBarEssentials.padding?.right ??
              MediaQuery.of(context).size.width * 0.07,
          bottom: this.navBarEssentials.padding?.bottom ??
              this.navBarEssentials.navBarHeight * 0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this.navBarEssentials.items.map((item) {
          int index = this.navBarEssentials.items.indexOf(item);
          return Flexible(
            flex: this.navBarEssentials.selectedIndex == index ? 2 : 1,
            child: GestureDetector(
              onTap: () {
                if (this.navBarEssentials.items[index].onPressed != null) {
                  this.navBarEssentials.items[index].onPressed(
                      this.navBarEssentials.selectedScreenBuildContext);
                } else {
                  this.navBarEssentials.onItemSelected(index);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: _buildItem(
                    item,
                    this.navBarEssentials.selectedIndex == index,
                    this.navBarEssentials.navBarHeight),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
