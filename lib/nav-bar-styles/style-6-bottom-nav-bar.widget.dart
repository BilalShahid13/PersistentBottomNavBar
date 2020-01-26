import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle6 extends StatelessWidget {
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

  BottomNavStyle6(
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
      this.horizontalPadding,
      this.isCurved,
      this.isIOS = true});

  bool opaque() {
    for (int i = 0; i < items.length; ++i) {
      if (items[i].isTranslucent) {
        return false;
      }
    }
    return true;
  }

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: 150.0,
      height: this.isIOS ? height / 1.5 : height,
      duration: animationDuration,
      child: Transform.scale(
        scale: isSelected ? 1.18 : 0.95,
        child: AnimatedContainer(
          duration: animationDuration,
          alignment: Alignment.center,
          height: this.isIOS ? height / 1.5 : height,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isCurved ? 15.0 : 0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          decoration: getNavBarDecoration(
            backgroundColor:
                (backgroundColor == null) ? Colors.white : backgroundColor,
            isCurved: this.isCurved,
            showElevation: this.showElevation,
          ),
          child: Container(
            width: double.infinity,
            height: this.navBarHeight,
            padding: this.isIOS
                ? EdgeInsets.only(
                    left: this.horizontalPadding == null
                        ? MediaQuery.of(context).size.width * 0.04
                        : this.horizontalPadding,
                    right: this.horizontalPadding == null
                        ? MediaQuery.of(context).size.width * 0.04
                        : this.horizontalPadding,
                    top: this.navBarHeight * 0.12,
                    bottom: this.bottomPadding == null
                        ? this.navBarHeight * 0.38
                        : this.bottomPadding)
                : EdgeInsets.only(
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
