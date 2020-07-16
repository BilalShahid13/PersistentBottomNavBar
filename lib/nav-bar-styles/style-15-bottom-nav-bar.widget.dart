part of persistent_bottom_nav_bar;

class BottomNavStyle15 extends StatelessWidget {
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
  final NavBarDecoration decoration;
  final ItemAnimationProperties itemAnimationProperties;

  BottomNavStyle15({
    Key key,
    this.selectedIndex,
    this.previousIndex,
    this.showElevation = false,
    this.iconSize,
    this.itemAnimationProperties,
    this.backgroundColor,
    this.navBarHeight = 60.0,
    this.popAllScreensForTheSelectedTab,
    this.popScreensOnTapOfSelectedTab,
    @required this.items,
    this.onItemSelected,
    this.padding,
    this.decoration,
  });

  Widget _buildItem(BuildContext context, PersistentBottomNavBarItem item,
      bool isSelected, double height) {
    return this.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height,
            color: Colors.transparent,
            padding: EdgeInsets.only(
                top: this.padding?.top ?? this.navBarHeight * 0.15,
                bottom: this.padding?.bottom ?? this.navBarHeight * 0.12),
            child: Container(
              alignment: Alignment.center,
              height: height,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
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
                                  item.title,
                                  style: TextStyle(
                                      color: isSelected
                                          ? (item.activeContentColor == null
                                              ? item.activeColor
                                              : item.activeContentColor)
                                          : item.inactiveColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: item.titleFontSize),
                                )),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          );
  }

  Widget _buildMiddleItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarHeight == 0
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.only(
                top: this.padding?.top ?? 0.0,
                bottom: this.padding?.bottom ?? 0.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0, -23),
                  child: Center(
                    child: Container(
                      width: 150.0,
                      height: height,
                      margin: EdgeInsets.only(top: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.activeColor ?? Colors.white,
                        border:
                            Border.all(color: Colors.transparent, width: 5.0),
                        boxShadow: this.decoration.boxShadow,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: height,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: IconTheme(
                                    data: IconThemeData(
                                        size: iconSize,
                                        color: item.activeContentColor == null
                                            ? item.activeColor
                                            : item.activeContentColor),
                                    child: item.icon,
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
                item.title == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Material(
                            type: MaterialType.transparency,
                            child: FittedBox(
                                child: Text(
                              item.title,
                              style: TextStyle(
                                  color: isSelected
                                      ? (item.activeColor)
                                      : item.inactiveColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: item.titleFontSize),
                            )),
                          ),
                        ),
                      )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final midIndex = (this.items.length / 2).floor();
    return Container(
      width: double.infinity,
      height: this.navBarHeight,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: this.decoration.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: this.items[this.selectedIndex].filter ??
                  ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
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
                            this.popAllScreensForTheSelectedTab(index);
                          }
                          this.onItemSelected(index);
                        }
                      },
                      child: index == midIndex
                          ? Container(width: 150, color: Colors.transparent)
                          : _buildItem(context, item, selectedIndex == index,
                              this.navBarHeight),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          this.navBarHeight == 0
              ? SizedBox.shrink()
              : Center(
                  child: GestureDetector(
                      onTap: () {
                        if (this.items[midIndex].onPressed != null) {
                          this.items[midIndex].onPressed();
                        } else {
                          if (this.popScreensOnTapOfSelectedTab &&
                              this.previousIndex == midIndex) {
                            this.popAllScreensForTheSelectedTab(midIndex);
                          }
                          this.onItemSelected(midIndex);
                        }
                      },
                      child: _buildMiddleItem(items[midIndex],
                          selectedIndex == midIndex, this.navBarHeight)),
                )
        ],
      ),
    );
  }
}
