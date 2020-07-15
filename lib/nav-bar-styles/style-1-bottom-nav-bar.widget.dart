part of persistent_bottom_nav_bar;

class BottomNavStyle1 extends StatelessWidget {
  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarPadding padding;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;
  final ItemAnimationProperties itemAnimationProperties;

  BottomNavStyle1({
    Key key,
    this.selectedIndex,
    this.previousIndex,
    this.showElevation = false,
    this.iconSize,
    this.backgroundColor,
    this.itemAnimationProperties,
    this.popScreensOnTapOfSelectedTab,
    this.navBarHeight = 0.0,
    @required this.items,
    this.onItemSelected,
    this.padding,
    this.popAllScreensForTheSelectedTab,
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarHeight == 0
        ? SizedBox.shrink()
        : AnimatedContainer(
            width: isSelected ? 120 : 50,
            height: height / 1.6,
            duration: itemAnimationProperties?.duration ??
                Duration(milliseconds: 400),
            curve: itemAnimationProperties?.curve ?? Curves.ease,
            padding: EdgeInsets.all(item.contentPadding),
            decoration: BoxDecoration(
              color: isSelected
                  ? item.activeColor.withOpacity(0.2)
                  : backgroundColor.withOpacity(0.0),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Container(
              alignment: Alignment.center,
              height: height / 1.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: item.title == null ? 0.0 : 8),
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
                                  style: TextStyle(
                                      color: (item.activeContentColor == null
                                          ? item.activeColor
                                          : item.activeContentColor),
                                      fontWeight: FontWeight.w400,
                                      fontSize: item.titleFontSize),
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
        height: this.navBarHeight,
        padding: this.padding == null
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: this.navBarHeight * 0.15,
              )
            : EdgeInsets.only(
                top: this.padding?.top ?? this.navBarHeight * 0.15,
                left: this.padding?.left ??
                    MediaQuery.of(context).size.width * 0.07,
                right: this.padding?.right ??
                    MediaQuery.of(context).size.width * 0.07,
                bottom: this.padding?.bottom ?? this.navBarHeight * 0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Flexible(
              flex: selectedIndex == index ? 2 : 1,
              child: GestureDetector(
                onTap: () {
                  if (this.items[index].onPressed != null) {
                    this.items[index].onPressed();
                  } else {
                    if (this.popScreensOnTapOfSelectedTab &&
                        this.previousIndex == index) {
                      this.popAllScreensForTheSelectedTab(index);
                    }
                    this.onItemSelected(index);
                  }
                },
                child:
                    _buildItem(item, selectedIndex == index, this.navBarHeight),
              ),
            );
          }).toList(),
        ));
  }
}
