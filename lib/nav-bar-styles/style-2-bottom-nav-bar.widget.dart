part of persistent_bottom_nav_bar;

class BottomNavStyle2 extends StatelessWidget {
  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarPadding padding;
  final Function(int) popActionScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;
  final ItemAnimationProperties itemAnimationProperties;

  BottomNavStyle2({
    Key key,
    this.selectedIndex,
    this.previousIndex,
    this.showElevation = false,
    this.iconSize,
    this.backgroundColor,
    this.itemAnimationProperties,
    this.navBarHeight = 0.0,
    this.popScreensOnTapOfSelectedTab,
    this.popActionScreensForTheSelectedTab,
    @required this.items,
    this.onItemSelected,
    this.padding,
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarHeight == 0
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
                          size: iconSize,
                          color: isSelected
                              ? (item.activeContentColor == null
                                  ? item.activeColor
                                  : item.activeContentColor)
                              : item.inactiveColor == null
                                  ? item.activeColor
                                  : item.inactiveColor),
                      child: item.icon,
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
                              style: TextStyle(
                                  color: (item.activeContentColor == null
                                      ? item.activeColor
                                      : item.activeContentColor),
                                  fontWeight: FontWeight.w400,
                                  fontSize: item.titleFontSize),
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
      height: this.navBarHeight,
      padding: EdgeInsets.only(
          left: this.padding?.left ?? MediaQuery.of(context).size.width * 0.05,
          right:
              this.padding?.right ?? MediaQuery.of(context).size.width * 0.05,
          top: this.padding?.top ?? this.navBarHeight * 0.15,
          bottom: this.padding?.bottom ?? this.navBarHeight * 0.12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          var index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                if (this.items[index].onPressed != null) {
                  this.items[index].onPressed();
                } else {
                  if (this.popScreensOnTapOfSelectedTab &&
                      this.previousIndex == index) {
                    this.popActionScreensForTheSelectedTab(index);
                  }
                  this.onItemSelected(index);
                }
              },
              child: Container(
                color: Colors.transparent,
                child:
                    _buildItem(item, selectedIndex == index, this.navBarHeight),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
