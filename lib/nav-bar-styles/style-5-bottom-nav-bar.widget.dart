import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle5 extends StatelessWidget {
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

  BottomNavStyle5(
      {Key key,
      this.selectedIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.horizontalPadding,
      this.bottomPadding,
      this.isCurved,
      this.isIOS = true});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: 150.0,
      height: this.isIOS ? height / 2.0 : height / 1,
      duration: animationDuration,
      child: AnimatedContainer(
        duration: animationDuration,
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.0 : height / 1,
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
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: isSelected
                          ? (item.activeContentColor == null
                              ? item.activeColor
                              : item.activeContentColor)
                          : Colors.transparent),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool opaque() {
    for (int i = 0; i < items.length; ++i) {
      if (items[i].isTranslucent) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isCurved ? 15.0 : 0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          decoration: getNavBarDecoration(
            backgroundColor: opaque()
                ? (backgroundColor == null) ? Colors.white : backgroundColor
                : (backgroundColor == null)
                    ? Colors.white.withOpacity(0.7)
                    : backgroundColor.withOpacity(0.7),
            isCurved: this.isCurved,
            showElevation: this.showElevation,
          ),
          child: Container(
            width: double.infinity,
            height: this.navBarHeight,
            padding: this.isIOS
                ? EdgeInsets.only(
                    left: this.horizontalPadding == null
                        ? MediaQuery.of(context).size.width * 0.05
                        : this.horizontalPadding,
                    right: this.horizontalPadding == null
                        ? MediaQuery.of(context).size.width * 0.05
                        : this.horizontalPadding,
                    top: this.navBarHeight * 0.12,
                    bottom: this.bottomPadding == null
                        ? this.navBarHeight * 0.04
                        : this.bottomPadding)
                : EdgeInsets.only(
                    left: this.horizontalPadding == null
                        ? MediaQuery.of(context).size.width * 0.05
                        : this.horizontalPadding,
                    right: this.horizontalPadding == null
                        ? MediaQuery.of(context).size.width * 0.05
                        : this.horizontalPadding,
                    top: this.navBarHeight * 0.06,
                    bottom: this.bottomPadding == null
                        ? this.navBarHeight * 0.16
                        : this.bottomPadding),
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
                        item, selectedIndex == index, this.navBarHeight),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
