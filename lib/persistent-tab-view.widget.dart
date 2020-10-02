// Author: Bilal Shahid
// For queries, contact me at bilalscheema@gmail.com

part of persistent_bottom_nav_bar;

enum popActionScreens { once, all }

///A highly customizable persistent navigation bar for flutter.
///
///To learn more, check out the [Readme](https://github.com/BilalShahid13/PersistentBottomNavBar).
class PersistentTabView extends StatefulWidget {
  PersistentTabView(
      {Key key,
      this.items,
      @required this.screens,
      this.controller,
      this.navBarHeight = kBottomNavigationBarHeight,
      this.margin = EdgeInsets.zero,
      this.backgroundColor = CupertinoColors.white,
      this.iconSize = 26.0,
      this.onItemSelected,
      this.neumorphicProperties,
      this.floatingActionButton,
      this.customWidget,
      this.itemCount,
      this.padding = const NavBarPadding.all(null),
      this.decoration = const NavBarDecoration(),
      this.resizeToAvoidBottomInset = false,
      this.bottomScreenMargin,
      this.onWillPop,
      this.popAllScreensOnTapOfSelectedTab = true,
      this.popActionScreens = popActionScreensType.all,
      this.confineInSafeArea = true,
      this.stateManagement = true,
      this.hideNavigationBarWhenKeyboardShows = true,
      this.handleAndroidBackButtonPress = true,
      this.itemAnimationProperties,
      this.hideNavigationBar,
      this.screenTransitionAnimation = const ScreenTransitionAnimation(),
      this.navBarStyle = NavBarStyle.style1})
      : super(key: key) {
    assert(items != null || navBarStyle == NavBarStyle.custom,
        "Items can only be null in case of custom navigation bar style. Please add the items!");
    assert(items == null && itemCount != null || items != null,
        "In case of custom navigation bar style, the property itemCount is required!");
    assert(screens != null, "screens property is required");
    assert(assertMidButtonStyles(navBarStyle, items.length),
        "NavBar styles 15-18 only accept 3 or 5 PersistentBottomNavBarItem items.");
    assert(navBarStyle == NavBarStyle.custom || items.length == screens.length,
        "screens and items length should be same. If you are using the onPressed callback function of 'PersistentBottomNavBarItem', enter a dummy screen like Container() in its place in the screens");
    assert(navBarStyle == NavBarStyle.custom || items.length >= 2 && items.length <= 6,
        "NavBar should have at least 2 or maximum 6 items (Except for styles 15-18)");
    assert(
        navBarStyle == NavBarStyle.custom && customWidget != null ||
            navBarStyle != NavBarStyle.custom,
        "customWidget shoudl not be null when navBarStyle == NavBarStyle.custom");
  }

  ///List of persistent bottom navigation bar items to be displayed in the navigation bar.
  final List<PersistentBottomNavBarItem> items;

  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  final List<Widget> screens;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  final PersistentTabController controller;

  ///Background color of bottom navigation bar. `white` by default.
  final Color backgroundColor;

  ///Icon size for the `persistent bottom navigation bar items`. `26.0` by default.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double iconSize;

  ///Callback when page or tab change is detected.
  final ValueChanged<int> onItemSelected;

  ///Specifies the curve properties of the NavBar.
  final NavBarDecoration decoration;

  ///`padding` for the persistent navigation bar content. Accepts `NavBarPadding` instead of `EdgeInsets`.
  ///
  ///`USE WITH CAUTION, MAY CAUSE LAYOUT ISSUES`.
  final NavBarPadding padding;

  ///Style for persistent bottom navigation bar. Accepts `NavBarStyle` to determine the theme.
  final NavBarStyle navBarStyle;

  ///Style the `neumorphic` navigation bar item.
  ///
  ///Works only with style `neumorphic`.
  final NeumorphicProperties neumorphicProperties;

  ///A custom widget which is displayed at the bottom right of the display at all times.
  final Widget floatingActionButton;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `kBottomNavigationBarHeight` which is `56.0`.
  final double navBarHeight;

  ///The margin around the navigation bar.
  final EdgeInsets margin;

  ///Custom navigation bar widget. To be only used when `navBarStyle` is set to `NavBarStyle.custom`.
  final Widget customWidget;

  ///If using `custom` navBarStyle, define this instead of the `items` property
  final int itemCount;

  ///Will confine the NavBar's items in the safe area defined by the device.
  final bool confineInSafeArea;

  ///Handles android back button actions. Defaults to `true`.
  ///
  ///Action based on scenarios:
  ///1. If the you are on the first tab with all screens popped of the given tab, the app will close.
  ///2. If you are on another tab with all screens popped of that given tab, you will be switched to first tab.
  ///3. If there are screens pushed on the selected tab, a screen will pop on a respective back button press.
  final bool handleAndroidBackButtonPress;

  ///Bottom margin of the screen.
  final double bottomScreenMargin;

  ///If an already selected tab is pressed/tapped again, all the screens pushed on that particular tab will pop until the first screen in the stack. Defaults to `true`.
  final bool popAllScreensOnTapOfSelectedTab;

  ///If set all pop until to first screen else set once pop once
  final popActionScreensType popActionScreens;

  final bool resizeToAvoidBottomInset;

  ///Preserves the state of each tab's screen. `true` by default.
  final bool stateManagement;

  ///If you want to perform a custom action on Android when exiting the app, you can write your logic here.
  final Future<bool> onWillPop;

  ///Screen transition animation properties when switching tabs.
  final ScreenTransitionAnimation screenTransitionAnimation;

  final bool hideNavigationBarWhenKeyboardShows;

  ///This controls the animation properties of the items of the NavBar.
  final ItemAnimationProperties itemAnimationProperties;

  ///Hides the navigation bar with an transition animation. Use it in conjuction with [Provider](https://pub.dev/packages/provider) for better results.
  final bool hideNavigationBar;

  @override
  _PersistentTabViewState createState() => _PersistentTabViewState();
}

class _PersistentTabViewState extends State<PersistentTabView> {
  List<BuildContext> _contextList;
  PersistentTabController _controller;
  double _navBarHeight;
  int _previousIndex;
  bool _isCompleted;
  bool _isAnimating;

  @override
  void initState() {
    super.initState();
    _contextList =
        List<BuildContext>(widget.items == null ? widget.itemCount ?? 0 : widget.items.length);
    if (widget.controller == null) {
      _controller = PersistentTabController(initialIndex: 0);
    } else {
      _controller = widget.controller;
    }
    _previousIndex = _controller.index;

    _isCompleted = false;
    _isAnimating = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildScreen(int index) => widget.floatingActionButton != null
      ? Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SizedBox.expand(
              child: CustomTabView(
                builder: (BuildContext screenContext) {
                  _contextList[index] = screenContext;
                  return Material(elevation: 0, child: widget.screens[index]);
                },
              ),
            ),
            Positioned(
              bottom: widget.decoration.borderRadius != BorderRadius.zero ? 25.0 : 10.0,
              right: 10.0,
              child: widget.floatingActionButton,
            ),
          ],
        )
      : widget.navBarStyle == NavBarStyle.style15
          ? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SizedBox.expand(
                  child: CustomTabView(
                    builder: (BuildContext screenContext) {
                      _contextList[index] = screenContext;
                      return Material(elevation: 0, child: widget.screens[index]);
                    },
                  ),
                ),
                _navBarHeight == 0
                    ? SizedBox.shrink()
                    : Positioned(
                        bottom: 0.0,
                        child: GestureDetector(
                          onTap: () {
                            if (widget.items[(widget.items.length / 2).floor()].onPressed != null) {
                              widget.items[(widget.items.length / 2).floor()].onPressed();
                            } else {
                              setState(() {
                                _controller.index = (widget.items.length / 2).floor();
                              });
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 21.0 +
                                  min(
                                      widget.navBarHeight,
                                      max(widget.decoration.borderRadius.topRight.y ?? 0.0,
                                              widget.decoration.borderRadius.topLeft.y ?? 0.0) +
                                          (widget.decoration?.border != null
                                              ? widget.decoration.border.dimensions.vertical
                                              : 0.0)),
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 2 -
                                      (MediaQuery.of(context).size.width / 5.0 - 30.0) / 2),
                              width: MediaQuery.of(context).size.width / 5.0 - 30.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100.0),
                                    topRight: Radius.circular(100.0),
                                  )),
                            ),
                          ),
                        ),
                      ),
              ],
            )
          : widget.navBarStyle == NavBarStyle.style16
              ? Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SizedBox.expand(
                      child: CustomTabView(
                        builder: (BuildContext screenContext) {
                          _contextList[index] = screenContext;
                          return Material(elevation: 0, child: widget.screens[index]);
                        },
                      ),
                    ),
                    _navBarHeight == 0
                        ? SizedBox.shrink()
                        : Positioned(
                            bottom: 0.0,
                            child: GestureDetector(
                              onTap: () {
                                if (widget.items[(widget.items.length / 2).floor()].onPressed !=
                                    null) {
                                  widget.items[(widget.items.length / 2).floor()].onPressed();
                                } else {
                                  setState(() {
                                    _controller.index = (widget.items.length / 2).floor();
                                  });
                                }
                              },
                              child: Center(
                                child: Container(
                                  height: 21 +
                                      min(
                                          widget.navBarHeight,
                                          max(widget.decoration.borderRadius.topRight.y ?? 0.0,
                                                  widget.decoration.borderRadius.topLeft.y ?? 0.0) +
                                              (widget.decoration?.border != null
                                                  ? widget.decoration.border.dimensions.vertical
                                                  : 0.0)),
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width / 2 -
                                          (MediaQuery.of(context).size.width / 5.0 - 30.0) / 2),
                                  width: MediaQuery.of(context).size.width / 5.0 - 30.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              : CustomTabView(builder: (BuildContext screenContext) {
                  _contextList[index] = screenContext;
                  return Material(elevation: 0, child: widget.screens[index]);
                });

  Widget navigationBarWidget() => CupertinoPageScaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        child: PersistentTabScaffold(
          controller: _controller,
          itemCount: widget.items == null ? widget.itemCount ?? 0 : widget.items.length,
          bottomScreenMargin: widget.hideNavigationBar != null && widget.hideNavigationBar
              ? 0.0
              : widget.bottomScreenMargin,
          stateManagement: widget.stateManagement,
          screenTransitionAnimation: widget.screenTransitionAnimation,
          hideNavigationBarWhenKeyboardShows: widget.hideNavigationBarWhenKeyboardShows,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          animatePadding: _isAnimating || _isCompleted,
          tabBar: PersistentBottomNavBar(
            items: widget.items,
            backgroundColor: widget.backgroundColor,
            iconSize: widget.iconSize,
            navBarHeight: _navBarHeight,
            margin: widget.margin,
            selectedIndex: _controller.index,
            previousIndex: _previousIndex,
            decoration: widget.decoration,
            padding: widget.padding,
            itemAnimationProperties: widget.itemAnimationProperties,
            confineToSafeArea: widget.confineInSafeArea,
            hideNavigationBar: widget.hideNavigationBar,
            navBarStyle: widget.navBarStyle,
            popScreensOnTapOfSelectedTab:
                widget.popAllScreensOnTapOfSelectedTab ?? true,
            popActionScreens:
                widget.popActionScreens ?? popActionScreensType.all,
            neumorphicProperties: widget.neumorphicProperties,
            customNavBarWidget: widget.customWidget,
            onAnimationComplete: (isAnimating, isCompleted) {
              if (_isAnimating != isAnimating) {
                setState(() {
                  _isAnimating = isAnimating;
                });
              }
              if (_isCompleted != isCompleted) {
                setState(() {
                  _isCompleted = isCompleted;
                });
              }
            },
            popAllScreensForTheSelectedTab: (index) {
              if (widget.popAllScreensOnTapOfSelectedTab) {
                if (widget.items[_controller.index]
                            .onSelectedTabPressWhenNoScreensPushed !=
                        null &&
                    !Navigator.of(_contextList[_controller.index]).canPop()) {
                  widget.items[_controller.index]
                      .onSelectedTabPressWhenNoScreensPushed();
                }

                if (widget.popActionScreens == PopActionScreensType.once) {
                  if (Navigator.of(_contextList[_controller.index]).canPop()) {
                    Navigator.of(_contextList[_controller.index]).pop(context);
                    return;
                  }
                } else {
                  Navigator.popUntil(
                      _contextList[_controller.index],
                      ModalRoute.withName(widget.routeName ??
                          '/9f580fc5-c252-45d0-af25-9429992db112'));
                }
              }
            },
            onItemSelected: widget.onItemSelected != null
                ? (int index) {
                    if (_controller.index != _previousIndex) {
                      setState(() {
                        _previousIndex = _controller.index;
                      });
                    }
                    widget.onItemSelected(index);
                  }
                : (int index) {
                    if (_controller.index != _previousIndex) {
                      setState(() {
                        _previousIndex = _controller.index;
                      });
                    }
                  },
          ),
          tabBuilder: (BuildContext context, int index) {
            return SafeArea(
              top: false,
              right: false,
              left: false,
              bottom: (widget.items != null && widget.items[_controller.index].opacity < 1.0) ||
                      (widget.hideNavigationBar != null && _isCompleted)
                  ? false
                  : widget.confineInSafeArea ?? false,
              child: _buildScreen(index),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    _navBarHeight = (widget.resizeToAvoidBottomInset &&
            MediaQuery.of(context).viewInsets.bottom > 0 &&
            widget.hideNavigationBarWhenKeyboardShows)
        ? 0.0
        : widget.navBarHeight ?? kBottomNavigationBarHeight;
    if (_contextList.length != widget.itemCount ?? widget.items.length) {
      _contextList =
          List<BuildContext>(widget.items == null ? widget.itemCount ?? 0 : widget.items.length);
    }
    if (widget.handleAndroidBackButtonPress) {
      return WillPopScope(
        onWillPop: widget.onWillPop != null
            ? widget.onWillPop
            : () async {
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
    } else {
      return navigationBarWidget();
    }
  }
}

//asserts

bool assertMidButtonStyles(NavBarStyle navBarStyle, int itemCount) {
  if (navBarStyle == NavBarStyle.style15 ||
      navBarStyle == NavBarStyle.style16 ||
      navBarStyle == NavBarStyle.style17 ||
      navBarStyle == NavBarStyle.style18) {
    if (itemCount % 2 != 0) {
      return true;
    } else {
      return false;
    }
  }
  return true;
}
