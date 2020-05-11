import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle2 extends StatelessWidget {
  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarCurve navBarCurve;
  final double bottomPadding;
  final double horizontalPadding;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;

  BottomNavStyle2(
      {Key key,
      this.selectedIndex,
      this.previousIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      this.popScreensOnTapOfSelectedTab,
      this.popAllScreensForTheSelectedTab,
      @required this.items,
      this.onItemSelected,
      this.bottomPadding,
      this.navBarCurve,
      this.horizontalPadding});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: 150.0,
      height: height / 1,
      duration: animationDuration,
      child: AnimatedContainer(
        duration: animationDuration,
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
            Padding(
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
          left: this.horizontalPadding == null
              ? MediaQuery.of(context).size.width * 0.05
              : this.horizontalPadding,
          right: this.horizontalPadding == null
              ? MediaQuery.of(context).size.width * 0.05
              : this.horizontalPadding,
          top: this.navBarHeight * 0.15,
          bottom: this.bottomPadding == null
              ? this.navBarHeight * 0.12
              : this.bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          var index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                if (this.popScreensOnTapOfSelectedTab &&
                    this.previousIndex == index) {
                  this.popAllScreensForTheSelectedTab(index);
                }
                this.onItemSelected(index);
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
