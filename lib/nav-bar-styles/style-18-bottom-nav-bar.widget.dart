part of persistent_bottom_nav_bar;

class BottomNavStyle18 extends StatelessWidget {
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

  BottomNavStyle18({
    Key key,
    this.selectedIndex,
    this.previousIndex,
    this.showElevation = false,
    this.iconSize,
    this.backgroundColor,
    this.itemAnimationProperties,
    this.navBarHeight = 60.0,
    this.popAllScreensForTheSelectedTab,
    this.popScreensOnTapOfSelectedTab,
    @required this.items,
    this.onItemSelected,
    this.padding,
    this.decoration,
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height,
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

  Widget _buildMiddleItem(BuildContext context, PersistentBottomNavBarItem item,
      bool isSelected, double height) {
    return this.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: MediaQuery.of(context).size.width / 5.0,
            margin: EdgeInsets.only(
                top: this.padding?.top ?? this.navBarHeight * 0.1,
                bottom: this.padding?.bottom ?? this.navBarHeight * 0.1,
                left: 10.0,
                right: 10.0),
            decoration: BoxDecoration(
              color: item.activeColor ?? Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.transparent, width: 5.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  offset: Offset(0, 2.0),
                  color: Colors.black26,
                ),
              ],
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
                    ],
                  )
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final midIndex = (this.items.length / 2).floor();
    return ClipRRect(
      borderRadius: this.decoration.borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: this.navBarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return index != midIndex
                        ? Flexible(
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
                                  ? Opacity(
                                      opacity: 0.0,
                                      child: _buildMiddleItem(
                                          context,
                                          item,
                                          selectedIndex == index,
                                          this.navBarHeight))
                                  : _buildItem(item, selectedIndex == index,
                                      this.navBarHeight),
                            ),
                          )
                        : GestureDetector(
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
                                ? Opacity(
                                    opacity: 0.0,
                                    child: _buildMiddleItem(
                                        context,
                                        item,
                                        selectedIndex == index,
                                        this.navBarHeight))
                                : _buildItem(item, selectedIndex == index,
                                    this.navBarHeight),
                          );
                  }).toList(),
                ),
                Center(
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
                      child: _buildMiddleItem(context, items[midIndex],
                          selectedIndex == midIndex, this.navBarHeight)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
