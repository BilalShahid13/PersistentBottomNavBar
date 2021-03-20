part of persistent_bottom_nav_bar;

class BottomNavStyle2 extends StatelessWidget {
  final NavBarEssentials navBarEssentials;

  BottomNavStyle2({
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
                      : Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: FittedBox(
                                child: Text(
                              isSelected ? item.title : " ",
                              style: item.textStyle != null
                                  ? (item.textStyle.apply(
                                      color: isSelected
                                          ? (item.activeColorSecondary == null
                                              ? item.activeColorPrimary
                                              : item.activeColorSecondary)
                                          : item.inactiveColorPrimary))
                                  : TextStyle(
                                      color: (item.activeColorSecondary == null
                                          ? item.activeColorPrimary
                                          : item.activeColorSecondary),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                            )),
                          ),
                        )
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
              this.navBarEssentials.navBarHeight * 0.15,
          bottom: this.navBarEssentials.padding?.bottom ??
              this.navBarEssentials.navBarHeight * 0.12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this.navBarEssentials.items.map((item) {
          int index = this.navBarEssentials.items.indexOf(item);
          return Flexible(
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
