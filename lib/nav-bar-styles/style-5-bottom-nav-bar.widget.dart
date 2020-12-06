part of persistent_bottom_nav_bar;

class BottomNavStyle5 extends StatelessWidget {
  final NavBarEssentials navBarEssentials;

  BottomNavStyle5({
    Key key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarEssentials.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height / 1,
            child: Container(
              alignment: Alignment.center,
              height: height / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconTheme(
                      data: IconThemeData(
                          size: item.iconSize,
                          color: isSelected
                              ? (item.activeColorAlternate == null
                                  ? item.activeColor
                                  : item.activeColorAlternate)
                              : item.inactiveColor == null
                                  ? item.activeColor
                                  : item.inactiveColor),
                      child: item.icon,
                    ),
                  ),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: isSelected
                            ? (item.activeColorAlternate == null
                                ? item.activeColor
                                : item.activeColorAlternate)
                            : Colors.transparent),
                  ),
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
          left: this.navBarEssentials.padding?.left ??
              MediaQuery.of(context).size.width * 0.05,
          right: this.navBarEssentials.padding?.right ??
              MediaQuery.of(context).size.width * 0.05,
          top: this.navBarEssentials.padding?.top ??
              this.navBarEssentials.navBarHeight * 0.06,
          bottom: this.navBarEssentials.padding?.bottom ??
              this.navBarEssentials.navBarHeight * 0.16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this.navBarEssentials.items.map((item) {
          int index = this.navBarEssentials.items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                if (this.navBarEssentials.items[index].onPressed != null) {
                  this.navBarEssentials.items[index].onPressed();
                } else {
                  if (this.navBarEssentials.popScreensOnTapOfSelectedTab &&
                      this.navBarEssentials.previousIndex == index) {
                    this.navBarEssentials.popAllScreensForTheSelectedTab(index);
                  }
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
