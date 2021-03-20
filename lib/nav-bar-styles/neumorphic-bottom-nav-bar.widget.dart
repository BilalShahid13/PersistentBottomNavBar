part of persistent_bottom_nav_bar;

class NeumorphicBottomNavBar extends StatelessWidget {
  final NavBarEssentials navBarEssentials;
  final NeumorphicProperties neumorphicProperties;

  NeumorphicBottomNavBar(
      {Key key,
      this.navBarEssentials,
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
                        size: item.iconSize,
                        color: isSelected
                            ? (item.activeColorSecondary == null
                                ? item.activeColorPrimary
                                : item.activeColorSecondary)
                            : item.inactiveColorPrimary == null
                                ? item.activeColorPrimary
                                : item.inactiveColorPrimary),
                    child:
                        isSelected ? item.icon : item.inactiveIcon ?? item.icon,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Material(
                    type: MaterialType.transparency,
                    child: FittedBox(
                        child: Text(
                      item.title,
                      style: item.textStyle != null
                          ? (item.textStyle.apply(
                              color: isSelected
                                  ? (item.activeColorSecondary == null
                                      ? item.activeColorPrimary
                                      : item.activeColorSecondary)
                                  : item.inactiveColorPrimary))
                          : TextStyle(
                              color: isSelected
                                  ? (item.activeColorSecondary == null
                                      ? item.activeColorPrimary
                                      : item.activeColorSecondary)
                                  : item.inactiveColorSecondary != null
                                      ? item.inactiveColorSecondary
                                      : item.inactiveColorPrimary == null
                                          ? item.activeColorPrimary
                                          : item.inactiveColorPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0),
                    )),
                  ),
                )
              ],
            )
          : IconTheme(
              data: IconThemeData(
                  size: item.iconSize,
                  color: isSelected
                      ? (item.activeColorSecondary == null
                          ? item.activeColorPrimary
                          : item.activeColorSecondary)
                      : item.inactiveColorPrimary == null
                          ? item.activeColorPrimary
                          : item.inactiveColorPrimary),
              child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
            );

  Widget _buildItem(BuildContext context, PersistentBottomNavBarItem item,
      bool isSelected, double height) {
    return this.navBarEssentials.navBarHeight == 0
        ? SizedBox.shrink()
        : opaque(this.navBarEssentials.items,
                this.navBarEssentials.selectedIndex)
            ? NeumorphicContainer(
                decoration: NeumorphicDecoration(
                  borderRadius: BorderRadius.circular(
                      this.neumorphicProperties == null
                          ? 15.0
                          : this.neumorphicProperties.borderRadius),
                  color: this.navBarEssentials.backgroundColor,
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
                      context,
                      this.navBarEssentials.items,
                      this.navBarEssentials.backgroundColor,
                      this.navBarEssentials.selectedIndex),
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
      height: this.navBarEssentials.navBarHeight,
      padding: EdgeInsets.only(
          left: this.navBarEssentials.padding?.left ??
              MediaQuery.of(context).size.width * 0.04,
          right: this.navBarEssentials.padding?.right ??
              MediaQuery.of(context).size.width * 0.04,
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
              child: _buildItem(
                  context,
                  item,
                  this.navBarEssentials.selectedIndex == index,
                  this.navBarEssentials.navBarHeight),
            ),
          );
        }).toList(),
      ),
    );
  }
}
