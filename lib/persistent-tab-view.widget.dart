// Author: Bilal Shahid
// For queries, contact: bilalscheema@gmail.com

import 'package:flutter/material.dart';
import 'persistent-tab-view.dart';

///A highly customizable persistent navigation bar for flutter.
///
///To learn more, check out the [Readme](https://github.com/BilalShahid13/PersistentBottomNavBar).
class PersistentTabView extends StatefulWidget {
  PersistentTabView(
      {Key key,
      this.items,
      @required this.screens,
      this.controller,
      this.showElevation = false,
      this.navBarHeight,
      this.backgroundColor = CupertinoColors.white,
      this.iconSize = 26.0,
      this.selectedIndex = 0,
      this.onItemSelected,
      this.bottomPadding,
      this.horizontalPadding,
      this.neumorphicProperties,
      this.floatingActionWidget,
      this.customWidget,
      this.itemCount,
      this.navBarCurve = NavBarCurve.none,
      this.confineInSafeArea = true,
      this.handleAndroidBackButtonPress = true,
      this.navBarStyle = NavBarStyle.style1})
      : super(key: key) {
    assert(items != null || navBarStyle == NavBarStyle.custom);
    assert(items == null && itemCount != null || items != null);
    assert(screens != null);
    assert(navBarStyle == NavBarStyle.custom || items.length == screens.length);
    assert(navBarStyle == NavBarStyle.custom || items.length >= 2 && items.length <= 5);
    assert(navBarStyle == NavBarStyle.custom && customWidget != null || navBarStyle != NavBarStyle.custom && customWidget == null);
  }

  ///List of persistent bottom navigation bar items to be displayed in the navigation bar.
  final List<PersistentBottomNavBarItem> items;

  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  final List<Widget> screens;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  final PersistentTabController controller;

  ///Background color of bottom navigation bar. `white` by default.
  final Color backgroundColor;

  ///Show shadow on the upper part of the navigation bar to give it an elevated feel. `true` by default.
  final bool showElevation;

  ///Icon size for the `persistent bottom navigation bar items`. `26.0` by default.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double iconSize;

  ///Index of the page to be selected. `0` by default.
  final int selectedIndex;

  ///Callback when page or tab change is detected.
  final ValueChanged<int> onItemSelected;

  ///Style for persistent bottom navigation bar. Accepts `NavBarStyle` to determine the theme.
  final NavBarStyle navBarStyle;

  ///Bottom `padding` for the persistent navigation bar items.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double bottomPadding;

  ///Horizontal `padding` for the persistent navigation bar items.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double horizontalPadding;

  ///Style the `neumorphic` navigation bar item.
  ///
  ///Works only with style `neumorphic`.
  final NeumorphicProperties neumorphicProperties;

  ///A custom widget which is displayed at the bottom right of the display at all times.
  final Widget floatingActionWidget;

  ///Specifies if the NavBar's borders should be curved or not.
  ///
  ///Defaults to `none`
  final NavBarCurve navBarCurve;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `60.0` for Android and notchless iPhones and `90.0` for tablets and iPhones with a notch.
  final double navBarHeight;

  ///Custom navigation bar widget. To be only used when `navBarStyle` is set to `NavBarStyle.custom`.
  final Widget customWidget;

  ///If using `custom` navBarStyle, define this instead of the `items` property
  final int itemCount;

  ///Will confine the widget in the safe area defined by the device.
  final bool confineInSafeArea;

  ///Handles android back button actions.
  ///
  ///Action based on scenarios:
  ///1. If the you are on the first tab with all screens popped of the given tab, the app will close.
  ///2. If you are on another tab with all screens popped of that given tab, you will be switched to first tab.
  ///3. If there are screens pushed on the selected tab, a screen will pop on a respective back button press.
  final bool handleAndroidBackButtonPress;

  @override
  _PersistentTabViewState createState() => _PersistentTabViewState();
}

class _PersistentTabViewState extends State<PersistentTabView> {
  List<BuildContext> _contextList;
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _contextList = List<BuildContext>(widget.items == null ? widget.itemCount ?? 0 : widget.items.length);
    if (widget.controller == null) {
      _controller = PersistentTabController(initialIndex: 0);
    } else {
      _controller = widget.controller;
    }
  }

  Widget navigationBarWidget() => PersistentTabScaffold(
        controller: _controller,
        itemCount: widget.items == null ? widget.itemCount ?? 0 : widget.items.length,
        tabBar: PersistentBottomNavBar(
          showElevation: widget.showElevation,
          items: widget.items,
          backgroundColor: widget.backgroundColor,
          iconSize: widget.iconSize,
          navBarHeight: widget.navBarHeight ?? kToolbarHeight,
          selectedIndex: widget.selectedIndex,
          navBarCurve: widget.navBarCurve,
          bottomPadding: widget.bottomPadding,
          horizontalPadding: widget.horizontalPadding,
          navBarStyle: widget.navBarStyle,
          neumorphicProperties: widget.neumorphicProperties,
          customNavBarWidget: widget.customWidget,
          onItemSelected: widget.onItemSelected != null
              ? (int index) {
                  widget.onItemSelected(index);
                }
              : (int index) {
                  //DO NOTHING
                },
        ),
        tabBuilder: (BuildContext context, int index) {
          return widget.floatingActionWidget == null
              ? CupertinoTabView(builder: (BuildContext screenContext) {
                  _contextList[index] = screenContext;
                  return Material(child: widget.screens[index]);
                })
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SizedBox.expand(
                      child: CupertinoTabView(
                        builder: (BuildContext screenContext) {
                          _contextList[index] = screenContext;
                          return Material(child: widget.screens[index]);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: widget.navBarCurve != NavBarCurve.none ? 25.0 : 10.0,
                      right: 10.0,
                      child: widget.floatingActionWidget,
                    ),
                  ],
                );
        },
      );

  @override
  Widget build(BuildContext context) {
    if (widget.handleAndroidBackButtonPress && widget.confineInSafeArea) {
      return WillPopScope(
        onWillPop: () async {
          if (_controller.index == 0 && !Navigator.canPop(_contextList.first)) {
            return true;
          } else {
            if (Navigator.canPop(_contextList[_controller.index])) {
              Navigator.pop(_contextList[_controller.index]);
            } else {
              if (widget.onItemSelected != null) {
                widget.onItemSelected(0);
              }
              setState(() {
                _controller.index = 0;
              });
            }
            return false;
          }
        },
        child: Container(
          color: widget.backgroundColor,
          child: SafeArea(top: false, child: navigationBarWidget()),
        ),
      );
    } else if (widget.handleAndroidBackButtonPress && !widget.confineInSafeArea) {
      return WillPopScope(
        onWillPop: () async {
          if (_controller.index == 0 && !Navigator.canPop(_contextList.first)) {
            return true;
          } else {
            if (Navigator.canPop(_contextList[_controller.index])) {
              Navigator.pop(_contextList[_controller.index]);
            } else {
              if (widget.onItemSelected != null) {
                widget.onItemSelected(0);
              }
              setState(() {
                _controller.index = 0;
              });
            }
            return false;
          }
        },
        child: navigationBarWidget(),
      );
    } else if (!widget.handleAndroidBackButtonPress && widget.confineInSafeArea) {
      return Container(
        color: widget.backgroundColor,
        child: SafeArea(top: false, child: navigationBarWidget()),
      );
    } else {
      return navigationBarWidget();
    }
  }
}

Future<T> pushNewScreen<T extends Object>(BuildContext context, {@required Widget screen, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(CupertinoPageRoute(builder: (BuildContext context) => screen));
}

Future<T> pushDynamicScreen<T extends Object>(BuildContext context, {@required dynamic screen, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(screen);
}

Future<T> pushNewScreenWithRouteSettings<T extends Object>(BuildContext context,
    {@required Widget screen, @required RouteSettings settings, bool withNavBar, bool platformSpecific = false}) {
  if (platformSpecific && withNavBar == null) {
    withNavBar = Platform.isAndroid ? false : true;
  } else if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push(CupertinoPageRoute(settings: settings, builder: (BuildContext context) => screen));
}
