import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle9 extends StatelessWidget {
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

  BottomNavStyle9(
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

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: isSelected ? 120 : 50,
      height: this.isIOS ? height / 2.1 : height / 1.5,
      duration: animationDuration,
      padding: EdgeInsets.all(item.contentPadding),
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.15) : backgroundColor.withOpacity(0.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.3 : height / 1.6,
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
                        ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor)
                        : item.inactiveColor == null ? item.activeColor : item.inactiveColor),
                child: item.icon,
              ),
            ),
            isSelected
                ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Material(
                        type: MaterialType.transparency,
                        child: FittedBox(
                          child: Text(
                            item.title,
                            style: TextStyle(
                                color: (item.activeContentColor == null ? item.activeColor : item.activeContentColor),
                                fontWeight: FontWeight.w400,
                                fontSize: item.titleFontSize),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink()
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
                        left: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.07 : this.horizontalPadding,
                        right: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.07 : this.horizontalPadding,
                        top: this.navBarHeight * 0.16,
                        bottom: this.bottomPadding == null ? this.navBarHeight * 0.18 : this.bottomPadding)
                    : this.bottomPadding == null
                        ? EdgeInsets.symmetric(
                            horizontal: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.07 : this.horizontalPadding,
                            vertical: this.navBarHeight * 0.15,
                          )
                        : EdgeInsets.only(
                            top: this.navBarHeight * 0.15,
                            left: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.07 : this.horizontalPadding,
                            right: this.horizontalPadding == null ? MediaQuery.of(context).size.width * 0.07 : this.horizontalPadding,
                            bottom: this.bottomPadding),
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
                        child: _buildItem(item, selectedIndex == index, this.navBarHeight),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )),
    );
  }
}
