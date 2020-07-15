part of persistent_bottom_nav_bar;

class NeumorphicBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarPadding padding;
  final CurveType curveType;
  final NeumorphicProperties neumorphicProperties;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;
  final ItemAnimationProperties itemAnimationProperties;

  NeumorphicBottomNavBar(
      {Key key,
      this.selectedIndex,
      this.previousIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.itemAnimationProperties,
      this.popScreensOnTapOfSelectedTab,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.padding,
      this.popAllScreensForTheSelectedTab,
      this.curveType = CurveType.concave,
      this.neumorphicProperties = const NeumorphicProperties()});

  Widget _getNavItem(
          PersistentBottomNavBarItem item, bool isSelected, double height) =>
      this.neumorphicProperties != null &&
              this.neumorphicProperties.showSubtitleText
          ? Column(
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
                Padding(
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
          : IconTheme(
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
            );

  Widget _buildItem(BuildContext context, PersistentBottomNavBarItem item,
      bool isSelected, double height) {
    return this.navBarHeight == 0
        ? SizedBox.shrink()
        : opaque(items, selectedIndex)
            ? NeumorphicContainer(
                decoration: NeumorphicDecoration(
                  borderRadius: BorderRadius.circular(
                      this.neumorphicProperties == null
                          ? 15.0
                          : this.neumorphicProperties.borderRadius),
                  color: backgroundColor,
                  border: this.neumorphicProperties == null
                      ? null
                      : this.neumorphicProperties.border,
                  shape: this.neumorphicProperties == null
                      ? BoxShape.rectangle
                      : this.neumorphicProperties.shape,
                ),
                bevel: this.neumorphicProperties == null
                    ? 12.0
                    : this.neumorphicProperties.bevel,
                curveType: isSelected
                    ? CurveType.emboss
                    : this.neumorphicProperties == null
                        ? CurveType.concave
                        : this.neumorphicProperties.curveType,
                height: height + 20,
                width: 60.0,
                padding: EdgeInsets.all(6.0),
                child: _getNavItem(item, isSelected, height),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: getBackgroundColor(
                      context, items, backgroundColor, selectedIndex),
                ),
                height: height + 20,
                width: 60.0,
                padding: EdgeInsets.all(6.0),
                child: _getNavItem(item, isSelected, height),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.navBarHeight,
      padding: EdgeInsets.only(
          left: this.padding?.left ?? MediaQuery.of(context).size.width * 0.04,
          right:
              this.padding?.right ?? MediaQuery.of(context).size.width * 0.04,
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
                    this.popAllScreensForTheSelectedTab(index);
                  }
                  this.onItemSelected(index);
                }
              },
              child: _buildItem(
                  context, item, selectedIndex == index, this.navBarHeight),
            ),
          );
        }).toList(),
      ),
    );
  }
}
