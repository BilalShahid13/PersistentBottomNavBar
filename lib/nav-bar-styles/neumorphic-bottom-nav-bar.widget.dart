import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

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
  final NavBarCurve navBarCurve;
  final double bottomPadding;
  final double horizontalPadding;
  final CurveType curveType;
  final NeumorphicProperties neumorphicProperties;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;

  NeumorphicBottomNavBar(
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
      this.bottomPadding,
      this.navBarCurve,
      this.horizontalPadding,
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
    return opaque(items, selectedIndex)
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
          left: this.horizontalPadding == null
              ? MediaQuery.of(context).size.width * 0.04
              : this.horizontalPadding,
          right: this.horizontalPadding == null
              ? MediaQuery.of(context).size.width * 0.04
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
              child: _buildItem(
                  context, item, selectedIndex == index, this.navBarHeight),
            ),
          );
        }).toList(),
      ),
    );
  }
}
