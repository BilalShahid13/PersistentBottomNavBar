import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle7 extends StatelessWidget {
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

  BottomNavStyle7(
      {Key key,
      this.selectedIndex,
      this.previousIndex,
      this.showElevation = false,
      this.iconSize,
      this.horizontalPadding,
      this.backgroundColor,
      this.popScreensOnTapOfSelectedTab,
      this.animationDuration = const Duration(milliseconds: 270),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.popAllScreensForTheSelectedTab,
      this.bottomPadding,
      this.navBarCurve});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: isSelected ? 140 : 50,
      height: height / 1.6,
      curve: Curves.ease,
      duration: animationDuration,
      padding: EdgeInsets.all(item.contentPadding),
      decoration: isSelected
          ? BoxDecoration(
              color: isSelected
                  ? item.activeColor
                  : backgroundColor.withOpacity(0.0),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )
          : BoxDecoration(
              color: isSelected
                  ? item.activeColor
                  : backgroundColor.withOpacity(0.0),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
      child: Container(
        alignment: Alignment.center,
        height: height / 1.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8),
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
            isSelected
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
      padding: this.bottomPadding == null
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: this.navBarHeight * 0.15,
            )
          : EdgeInsets.only(
              top: this.navBarHeight * 0.15,
              left: this.horizontalPadding == null
                  ? MediaQuery.of(context).size.width * 0.07
                  : this.horizontalPadding,
              right: this.horizontalPadding == null
                  ? MediaQuery.of(context).size.width * 0.07
                  : this.horizontalPadding,
              bottom: this.bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          var index = items.indexOf(item);
          return Flexible(
            flex: selectedIndex == index ? 2 : 1,
            child: GestureDetector(
              onTap: () {
                this.onItemSelected(index);
                if (this.popScreensOnTapOfSelectedTab &&
                    this.previousIndex == index) {
                  this.popAllScreensForTheSelectedTab(index);
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
