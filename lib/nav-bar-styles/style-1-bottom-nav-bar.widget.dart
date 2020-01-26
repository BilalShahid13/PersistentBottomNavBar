import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle1 extends StatelessWidget {
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

  BottomNavStyle1(
      {Key key,
      this.selectedIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 270),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.bottomPadding,
      this.isCurved,
      this.horizontalPadding,
      this.isIOS = true});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: isSelected ? 140 : 50,
      height: this.isIOS ? height / 2.3 : height / 1.6,
      duration: animationDuration,
      padding: EdgeInsets.all(item.contentPadding),
      decoration: BoxDecoration(
        color: isSelected
            ? item.activeColor.withOpacity(0.2)
            : backgroundColor.withOpacity(0.0),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Container(
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.3 : height / 1.6,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
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
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4.0),
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
                          ? MediaQuery.of(context).size.width * 0.07
                          : this.horizontalPadding,
                      right: this.horizontalPadding == null
                          ? MediaQuery.of(context).size.width * 0.07
                          : this.horizontalPadding,
                      top: this.navBarHeight * 0.12,
                      bottom: this.bottomPadding == null
                          ? this.navBarHeight * 0.38
                          : this.bottomPadding)
                  : this.bottomPadding == null
                      ? EdgeInsets.symmetric(
                          horizontal: this.horizontalPadding == null
                              ? MediaQuery.of(context).size.width * 0.07
                              : this.horizontalPadding,
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
                crossAxisAlignment: this.isIOS
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: items.map((item) {
                  var index = items.indexOf(item);
                  return Flexible(
                    flex: selectedIndex == index ? 2 : 1,
                    child: GestureDetector(
                      onTap: () {
                        this.onItemSelected(index);
                      },
                      child: _buildItem(
                          item, selectedIndex == index, this.navBarHeight),
                    ),
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }
}
