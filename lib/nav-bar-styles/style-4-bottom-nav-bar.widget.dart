import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle4 extends StatelessWidget {
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

  BottomNavStyle4(
      {Key key,
      this.selectedIndex,
      this.previousIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.popScreensOnTapOfSelectedTab,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.popAllScreensForTheSelectedTab,
      this.horizontalPadding,
      this.bottomPadding,
      this.navBarCurve});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: 100.0,
      height: height,
      duration: animationDuration,
      child: AnimatedContainer(
        duration: animationDuration,
        alignment: Alignment.center,
        height: height / 1.6,
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
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                      color: isSelected
                          ? (item.activeContentColor == null
                              ? item.activeColor
                              : item.activeContentColor)
                          : item.inactiveColor,
                      fontWeight: FontWeight.w400,
                      fontSize: item.titleFontSize),
                  child: FittedBox(child: Text(isSelected ? item.title : " ")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color selectedItemActiveColor = items[selectedIndex].activeColor;
    double itemWidth = (MediaQuery.of(context).size.width / items.length) -
        ((MediaQuery.of(context).size.width * 0.03) / 3);
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
          bottom: this.bottomPadding == null
              ? this.navBarHeight * 0.1
              : this.bottomPadding),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                color: Colors.transparent,
                width: (selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * (selectedIndex) -
                        MediaQuery.of(context).size.width * 0.032),
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
                    width: itemWidth * 0.96,
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
                        child: _buildItem(
                            item, selectedIndex == index, this.navBarHeight),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
