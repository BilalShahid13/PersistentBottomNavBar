import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle4 extends StatelessWidget {
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

  BottomNavStyle4(
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
      width: 100.0,
      height: this.isIOS ? height / 2.0 : height,
      duration: animationDuration,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: AnimatedContainer(
        duration: animationDuration,
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.0 : height / 1.6,
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
                            ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor)
                            : item.inactiveColor == null
                                ? item.activeColor
                                : item.inactiveColor),
                    child: item.icon,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Material(
                    type: MaterialType.card,
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                          color: isSelected
                              ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor)
                              : item.inactiveColor,
                          fontWeight: FontWeight.w400,
                          fontSize: item.titleFontSize),
                      child:
                          FittedBox(child: Text(isSelected ? item.title : " ")),
                    ),
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
    final bgColor = (backgroundColor == null) ? Colors.white : backgroundColor;
    Color selectedItemActiveColor = items[selectedIndex].activeColor;
    double itemWidth = (MediaQuery.of(context).size.width / items.length) -
        ((MediaQuery.of(context).size.width * 0.03) / 3);
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
      decoration: this.isCurved
          ? BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              boxShadow: [
                if (showElevation)
                  BoxShadow(color: Colors.black12, blurRadius: 2)
              ],
            )
          : BoxDecoration(
              color: bgColor,
              boxShadow: [
                if (showElevation)
                  BoxShadow(color: Colors.black12, blurRadius: 2)
              ],
            ),
      child: Container(
        width: double.infinity,
        height: _navBarHeight,
        padding: this.isIOS
            ? EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: 1.0,
                bottom: _navBarHeight * 0.34,
              )
            : EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                bottom: _navBarHeight * 0.02,
              ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  color: backgroundColor,
                  width: (selectedIndex == 0
                      ? MediaQuery.of(context).size.width * 0.0
                      : itemWidth * (selectedIndex) -
                          MediaQuery.of(context).size.width * 0.025),
                  height: 4.0,
                ),
                Flexible(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: itemWidth,
                    height: 4.0,
                    alignment: Alignment.center,
                    child: Container(
                      height: 4.0,
                      width: itemWidth * 1.0,
                      decoration: BoxDecoration(
                        color: selectedItemActiveColor,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: this.isIOS
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return Flexible(
                      child: GestureDetector(
                        onTap: () {
                          this.onItemSelected(index);
                        },
                        child: _buildItem(
                            item, selectedIndex == index, _navBarHeight),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
