import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle10 extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final bool isIOS;
  final NavBarCurve navBarCurve;
  final double bottomPadding;
  final double horizontalPadding;

  BottomNavStyle10(
      {Key key,
      this.selectedIndex,
      this.showElevation = false,
      this.iconSize,
      this.horizontalPadding,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 270),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.bottomPadding,
      this.navBarCurve,
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
      width: isSelected ? 140 : 50,
      height: this.isIOS ? height / 2.1 : height / 1.5,
      duration: animationDuration,
      padding: EdgeInsets.all(item.contentPadding),
      decoration: isSelected
          ? BoxDecoration(
              color: isSelected
                  ? item.activeColor
                  : backgroundColor.withOpacity(0.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                  BoxShadow(
                      blurRadius: 7,
                      color: Colors.black12,
                      offset: Offset(0, 2.0))
                ])
          : BoxDecoration(
              color: isSelected
                  ? item.activeColor
                  : backgroundColor.withOpacity(0.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
      child: Container(
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.1 : height / 1.5,
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
      decoration: getNavBarDecoration(
        navBarCurve: this.navBarCurve,
        showElevation: this.showElevation,
      ),
      child: ClipRRect(
        borderRadius: getClipRectBorderRadius(navBarCurve: this.navBarCurve),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color: getBackgroundColor(
                context, items, backgroundColor, selectedIndex),
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
                      top: this.navBarHeight * 0.16,
                      bottom: this.bottomPadding == null
                          ? this.navBarHeight * 0.18
                          : this.bottomPadding)
                  : this.bottomPadding == null
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
      ),
    );
  }
}
