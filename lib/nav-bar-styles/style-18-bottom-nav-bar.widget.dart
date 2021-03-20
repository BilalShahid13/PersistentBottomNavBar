part of persistent_bottom_nav_bar;

class BottomNavStyle18 extends StatelessWidget {
  final NavBarEssentials navBarEssentials;
  final NavBarDecoration navBarDecoration;

  BottomNavStyle18({
    Key key,
    this.navBarEssentials = const NavBarEssentials(items: null),
    this.navBarDecoration = const NavBarDecoration(),
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return this.navBarEssentials.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height,
            padding: EdgeInsets.only(
                top: this.navBarEssentials.padding?.top ??
                    this.navBarEssentials.navBarHeight * 0.15,
                bottom: this.navBarEssentials.padding?.bottom ??
                    this.navBarEssentials.navBarHeight * 0.12),
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
                                          color: isSelected
                                              ? (item.activeColorSecondary ==
                                                      null
                                                  ? item.activeColorPrimary
                                                  : item.activeColorSecondary)
                                              : item.inactiveColorPrimary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0),
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
    return this.navBarEssentials.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: MediaQuery.of(context).size.width / 5.0,
            margin: EdgeInsets.only(
                top: this.navBarEssentials.padding?.top ??
                    this.navBarEssentials.navBarHeight * 0.1,
                bottom: this.navBarEssentials.padding?.bottom ??
                    this.navBarEssentials.navBarHeight * 0.1,
                left: 10.0,
                right: 10.0),
            decoration: BoxDecoration(
              color: item.activeColorPrimary ?? Colors.white,
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
                    ],
                  )
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final midIndex = (this.navBarEssentials.items.length / 2).floor();
    return ClipRRect(
      borderRadius: this.navBarDecoration.borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: this.navBarEssentials.navBarHeight,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: this.navBarEssentials.items.map((item) {
                    int index = this.navBarEssentials.items.indexOf(item);
                    return index != midIndex
                        ? Flexible(
                            child: GestureDetector(
                              onTap: () {
                                if (this
                                        .navBarEssentials
                                        .items[index]
                                        .onPressed !=
                                    null) {
                                  this.navBarEssentials.items[index].onPressed(
                                      this
                                          .navBarEssentials
                                          .selectedScreenBuildContext);
                                } else {
                                  this.navBarEssentials.onItemSelected(index);
                                }
                              },
                              child: index == midIndex
                                  ? Opacity(
                                      opacity: 0.0,
                                      child: _buildMiddleItem(
                                          context,
                                          item,
                                          this.navBarEssentials.selectedIndex ==
                                              index,
                                          this.navBarEssentials.navBarHeight))
                                  : _buildItem(
                                      item,
                                      this.navBarEssentials.selectedIndex ==
                                          index,
                                      this.navBarEssentials.navBarHeight),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (this
                                      .navBarEssentials
                                      .items[index]
                                      .onPressed !=
                                  null) {
                                this.navBarEssentials.items[index].onPressed(
                                    this
                                        .navBarEssentials
                                        .selectedScreenBuildContext);
                              } else {
                                this.navBarEssentials.onItemSelected(index);
                              }
                            },
                            child: index == midIndex
                                ? Opacity(
                                    opacity: 0.0,
                                    child: _buildMiddleItem(
                                        context,
                                        item,
                                        this.navBarEssentials.selectedIndex ==
                                            index,
                                        this.navBarEssentials.navBarHeight))
                                : _buildItem(
                                    item,
                                    this.navBarEssentials.selectedIndex ==
                                        index,
                                    this.navBarEssentials.navBarHeight),
                          );
                  }).toList(),
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        if (this.navBarEssentials.items[midIndex].onPressed !=
                            null) {
                          this.navBarEssentials.items[midIndex].onPressed(
                              this.navBarEssentials.selectedScreenBuildContext);
                        } else {
                          this.navBarEssentials.onItemSelected(midIndex);
                        }
                      },
                      child: _buildMiddleItem(
                          context,
                          this.navBarEssentials.items[midIndex],
                          this.navBarEssentials.selectedIndex == midIndex,
                          this.navBarEssentials.navBarHeight)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
