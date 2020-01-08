import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavSimple extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final bool isIOS;
  final bool isCurved;

  BottomNavSimple(
      {Key key,
      this.selectedIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.isCurved,
      this.isIOS = true});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: 150.0,
      height: this.isIOS ? height / 2.0 : height,
      duration: animationDuration,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: AnimatedContainer(
        duration: animationDuration,
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.3 : height,
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _navBarHeight = 0.0;
    if (this.navBarHeight == 0.0) {
      if (this.isIOS) {
        _navBarHeight = 90.0;
      } else {
        _navBarHeight = 50.0;
      }
    } else {
      _navBarHeight = this.navBarHeight;
    }
    return Container(
      decoration: getNavBarDecoration(
        backgroundColor:
            (backgroundColor == null) ? Colors.white : backgroundColor,
        isCurved: this.isCurved,
        showElevation: this.showElevation,
      ),
      child: Container(
        width: double.infinity,
        height: _navBarHeight,
        padding: this.isIOS
            ? EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: _navBarHeight * 0.12,
                bottom: _navBarHeight * 0.38,
              )
            : EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: _navBarHeight * 0.15,
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment:
              this.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index, _navBarHeight),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
