import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class NeumorphicBottomNavBar extends StatelessWidget {
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
  final double bottomPadding;
  final double horizontalPadding;
  final CurveType curveType;
  final NeumorphicProperties neumorphicProperties;

  NeumorphicBottomNavBar(
      {Key key,
      this.selectedIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.bottomPadding,
      this.isCurved,
      this.horizontalPadding,
      this.curveType = CurveType.concave,
      this.neumorphicProperties,
      this.isIOS = true});

  Widget _getNavItem(PersistentBottomNavBarItem item, bool isSelected, double height) => this.neumorphicProperties.showSubtitleText
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconTheme(
                data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor)
                        : item.inactiveColor == null ? item.activeColor : item.inactiveColor),
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
                      color: isSelected ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor) : item.inactiveColor,
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
                  ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor)
                  : item.inactiveColor == null ? item.activeColor : item.inactiveColor),
          child: item.icon,
        );

  Widget _buildItem(BuildContext context, PersistentBottomNavBarItem item, bool isSelected, double height) {
    return opaque(items, selectedIndex) ? NeumorphicContainer(
      decoration: NeumorphicDecoration(
        borderRadius: BorderRadius.circular(this.
        neumorphicProperties.borderRadius),
        color: backgroundColor,
        border: this.neumorphicProperties.border,
        shape: this.neumorphicProperties.shape,
      ),
      bevel: this.neumorphicProperties.bevel,
      curveType: isSelected ? CurveType.emboss : this.neumorphicProperties.curveType,
      height: this.isIOS ? height / 1.8 + 20 : height + 20,
      width: 60.0,
      padding: EdgeInsets.all(6.0),
      child: _getNavItem(item, isSelected, height),
    ) : Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: getBackgroundColor(context, items, backgroundColor, selectedIndex),
      ),
      height: this.isIOS ? height / 1.8 + 20 : height + 20,
      width: 60.0,
      padding: EdgeInsets.all(6.0),
      child: _getNavItem(item, isSelected, height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getNavBarDecoration(
        isCurved: this.isCurved,
        showElevation: this.showElevation,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isCurved ? 15.0 : 0.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color: getBackgroundColor(context, items, backgroundColor, selectedIndex),
            child: Container(
              width: double.infinity,
              height: this.navBarHeight,
              padding: this.isIOS
                  ? EdgeInsets.only(
                      left: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.04 : this.horizontalPadding,
                      right: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.04 : this.horizontalPadding,
                      top: this.navBarHeight * 0.12,
                      bottom: this.bottomPadding == null ? this.navBarHeight * 0.26 : this.bottomPadding,
                    )
                  : EdgeInsets.only(
                      left: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.04 : this.horizontalPadding,
                      right: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.04 : this.horizontalPadding,
                      top: this.navBarHeight * 0.15,
                      bottom: this.bottomPadding == null ? this.navBarHeight * 0.12 : this.bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: this.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: items.map((item) {
                  var index = items.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        this.onItemSelected(index);
                      },
                      child: _buildItem(context, item, selectedIndex == index, this.navBarHeight),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
