// Author: Bilal Shahid
// For queries, contact me at bilalscheema@gmail.com

// ignore_for_file: overridden_fields

part of persistent_bottom_nav_bar;

///A highly customizable persistent navigation bar for flutter.
///
///To learn more, check out the [Readme](https://github.com/BilalShahid13/PersistentBottomNavBar).

class PersistentTabView extends PersistentTabViewBase {
  PersistentTabView(this.context,
      {required this.screens,
      final Key? key,
      final List<PersistentBottomNavBarItem>? items,
      this.controller,
      final double navBarHeight = kBottomNavigationBarHeight,
      this.margin = EdgeInsets.zero,
      this.backgroundColor = CupertinoColors.white,
      final ValueChanged<int>? onItemSelected,
      final NeumorphicProperties? neumorphicProperties,
      this.floatingActionButton,
      final NavBarPadding padding = const NavBarPadding.all(null),
      final NavBarDecoration decoration = const NavBarDecoration(),
      this.resizeToAvoidBottomInset = false,
      this.bottomScreenMargin,
      this.selectedTabScreenContext,
      this.hideNavigationBarWhenKeyboardShows = true,
      final bool popAllScreensOnTapOfSelectedTab = true,
      final bool popAllScreensOnTapAnyTabs = false,
      final PopActionScreensType popActionScreens = PopActionScreensType.all,
      this.confineInSafeArea = true,
      this.onWillPop,
      this.stateManagement = true,
      this.handleAndroidBackButtonPress = true,
      final ItemAnimationProperties? itemAnimationProperties,
      this.hideNavigationBar,
      this.screenTransitionAnimation = const ScreenTransitionAnimation(),
      final NavBarStyle navBarStyle = NavBarStyle.style1})
      : assert(items != null,
            "Items can only be null in case of custom navigation bar style. Please add the items!"),
        assert(assertMidButtonStyles(navBarStyle, items!.length),
            "NavBar styles 15-18 only accept 3 or 5 PersistentBottomNavBarItem items."),
        assert(items!.length == screens.length,
            "screens and items length should be same. If you are using the onPressed callback function of 'PersistentBottomNavBarItem', enter a dummy screen like Container() in its place in the screens"),
        assert(items!.length >= 2 && items.length <= 6,
            "NavBar should have at least 2 or maximum 6 items (Except for styles 15-18)"),
        assert(
            handleAndroidBackButtonPress && onWillPop == null ||
                !handleAndroidBackButtonPress && onWillPop != null,
            "If you declare the onWillPop function, you will have to handle the back function functionality yourself as your onWillPop function will override the default function."),
        super(
          key: key,
          context: context,
          screens: screens,
          controller: controller,
          margin: margin,
          items: items,
          padding: padding,
          decoration: decoration,
          hideNavigationBarWhenKeyboardShows:
              hideNavigationBarWhenKeyboardShows,
          itemAnimationProperties: itemAnimationProperties,
          navBarStyle: navBarStyle,
          popActionScreens: popActionScreens,
          popAllScreensOnTapOfSelectedTab: popAllScreensOnTapOfSelectedTab,
          popAllScreensOnTapAnyTabs: popAllScreensOnTapAnyTabs,
          navBarHeight: navBarHeight,
          backgroundColor: backgroundColor,
          onItemSelected: onItemSelected,
          neumorphicProperties: neumorphicProperties,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomScreenMargin: bottomScreenMargin,
          onWillPop: onWillPop,
          isCustomWidget: false,
          confineInSafeArea: confineInSafeArea,
          stateManagement: stateManagement,
          handleAndroidBackButtonPress: handleAndroidBackButtonPress,
          hideNavigationBar: hideNavigationBar,
          screenTransitionAnimation: screenTransitionAnimation,
        );

  const PersistentTabView.custom(
    this.context, {
    required final Widget customWidget,
    required final int itemCount,
    required this.screens,
    final Key? key,
    this.controller,
    this.margin = EdgeInsets.zero,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = false,
    this.bottomScreenMargin,
    this.selectedTabScreenContext,
    this.hideNavigationBarWhenKeyboardShows = true,
    this.backgroundColor = CupertinoColors.white,
    final CustomWidgetRouteAndNavigatorSettings routeAndNavigatorSettings =
        const CustomWidgetRouteAndNavigatorSettings(),
    this.confineInSafeArea = true,
    this.onWillPop,
    this.stateManagement = true,
    this.handleAndroidBackButtonPress = true,
    this.hideNavigationBar,
    this.screenTransitionAnimation = const ScreenTransitionAnimation(),
  })  : assert(itemCount == screens.length,
            "screens and items length should be same. If you are using the onPressed callback function of 'PersistentBottomNavBarItem', enter a dummy screen like Container() in its place in the screens"),
        assert(
            handleAndroidBackButtonPress && onWillPop == null ||
                !handleAndroidBackButtonPress && onWillPop != null,
            "If you declare the onWillPop function, you will have to handle the back function functionality yourself as your onWillPop function will override the defualt function."),
        super(
          key: key,
          context: context,
          screens: screens,
          controller: controller,
          margin: margin,
          routeAndNavigatorSettings: routeAndNavigatorSettings,
          backgroundColor: backgroundColor,
          floatingActionButton: floatingActionButton,
          customWidget: customWidget,
          itemCount: itemCount,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomScreenMargin: bottomScreenMargin,
          onWillPop: onWillPop,
          confineInSafeArea: confineInSafeArea,
          stateManagement: stateManagement,
          handleAndroidBackButtonPress: handleAndroidBackButtonPress,
          hideNavigationBar: hideNavigationBar,
          screenTransitionAnimation: screenTransitionAnimation,
          isCustomWidget: true,
          decoration: const NavBarDecoration(),
        );

  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  @override
  final List<Widget> screens;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  @override
  final PersistentTabController? controller;

  ///Background color of bottom navigation bar. `white` by default.
  @override
  final Color backgroundColor;

  ///A custom widget which is displayed at the bottom right of the display at all times.
  @override
  final Widget? floatingActionButton;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `kBottomNavigationBarHeight` which is `56.0`.
  //final double navBarHeight;

  ///The margin around the navigation bar.
  @override
  final EdgeInsets margin;

  ///Will confine the NavBar's items in the safe area defined by the device.
  @override
  final bool confineInSafeArea;

  ///Handles android back button actions. Defaults to `true`.
  ///
  ///Action based on scenarios:
  ///1. If the you are on the first tab with all screens popped of the given tab, the app will close.
  ///2. If you are on another tab with all screens popped of that given tab, you will be switched to first tab.
  ///3. If there are screens pushed on the selected tab, a screen will pop on a respective back button press.
  @override
  final bool handleAndroidBackButtonPress;

  ///Bottom margin of the screen.
  @override
  final double? bottomScreenMargin;

  @override
  final bool resizeToAvoidBottomInset;

  ///Preserves the state of each tab's screen. `true` by default.
  @override
  final bool stateManagement;

  ///If you want to perform a custom action on Android when exiting the app, you can write your logic here. Returns context of the selected screen.
  @override
  final Future<bool> Function(BuildContext?)? onWillPop;

  ///Returns the context of the selected tab.
  @override
  final Function(BuildContext?)? selectedTabScreenContext;

  ///Screen transition animation properties when switching tabs.
  @override
  final ScreenTransitionAnimation screenTransitionAnimation;

  @override
  final bool hideNavigationBarWhenKeyboardShows;

  ///Hides the navigation bar with an transition animation. Use it in conjuction with [Provider](https://pub.dev/packages/provider) for better results.
  @override
  final bool? hideNavigationBar;

  @override
  final BuildContext context;
}

class PersistentTabViewBase extends StatefulWidget {
  const PersistentTabViewBase({
    final Key? key,
    this.screens,
    this.controller,
    this.floatingActionButton,
    this.margin,
    this.confineInSafeArea,
    this.handleAndroidBackButtonPress,
    this.bottomScreenMargin,
    this.resizeToAvoidBottomInset,
    this.stateManagement,
    this.screenTransitionAnimation,
    this.hideNavigationBar,
    this.context,
    this.items,
    this.backgroundColor,
    this.onItemSelected,
    this.decoration,
    this.padding,
    this.navBarStyle,
    this.neumorphicProperties,
    this.navBarHeight,
    this.customWidget,
    this.itemCount,
    this.popAllScreensOnTapOfSelectedTab,
    this.popAllScreensOnTapAnyTabs,
    this.popActionScreens,
    this.onWillPop,
    this.hideNavigationBarWhenKeyboardShows,
    this.itemAnimationProperties,
    this.isCustomWidget,
    this.selectedTabScreenContext,
    this.routeAndNavigatorSettings,
  }) : super(key: key);

  ///List of persistent bottom navigation bar items to be displayed in the navigation bar.
  final List<PersistentBottomNavBarItem>? items;

  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  final List<Widget>? screens;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  final PersistentTabController? controller;

  ///Background color of bottom navigation bar. `white` by default.
  final Color? backgroundColor;

  ///Callback when page or tab change is detected.
  final ValueChanged<int>? onItemSelected;

  ///Specifies the curve properties of the NavBar.
  final NavBarDecoration? decoration;

  ///`padding` for the persistent navigation bar content. Accepts `NavBarPadding` instead of `EdgeInsets`.
  ///
  ///`USE WITH CAUTION, MAY CAUSE LAYOUT ISSUES`.
  final NavBarPadding? padding;

  ///Style for persistent bottom navigation bar. Accepts `NavBarStyle` to determine the theme.
  final NavBarStyle? navBarStyle;

  ///Style the `neumorphic` navigation bar item.
  ///
  ///Works only with style `neumorphic`.
  final NeumorphicProperties? neumorphicProperties;

  ///A custom widget which is displayed at the bottom right of the display at all times.
  final Widget? floatingActionButton;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `kBottomNavigationBarHeight` which is `56.0`.
  final double? navBarHeight;

  ///The margin around the navigation bar.
  final EdgeInsets? margin;

  ///Custom navigation bar widget. To be only used when `navBarStyle` is set to `NavBarStyle.custom`.
  final Widget? customWidget;

  ///If using `custom` navBarStyle, define this instead of the `items` property
  final int? itemCount;

  ///Will confine the NavBar's items in the safe area defined by the device.
  final bool? confineInSafeArea;

  ///Handles android back button actions. Defaults to `true`.
  ///
  ///Action based on scenarios:
  ///1. If the you are on the first tab with all screens popped of the given tab, the app will close.
  ///2. If you are on another tab with all screens popped of that given tab, you will be switched to first tab.
  ///3. If there are screens pushed on the selected tab, a screen will pop on a respective back button press.
  final bool? handleAndroidBackButtonPress;

  ///Bottom margin of the screen.
  final double? bottomScreenMargin;

  ///If an already selected tab is pressed/tapped again, all the screens pushed on that particular tab will pop until the first screen in the stack. Defaults to `true`.
  final bool? popAllScreensOnTapOfSelectedTab;

  ///All the screens pushed on that particular tab will pop until the first screen in the stack, whether the tab is already selected or not. Defaults to `false`.
  final bool? popAllScreensOnTapAnyTabs;

  ///If set all pop until to first screen else set once pop once
  final PopActionScreensType? popActionScreens;

  final bool? resizeToAvoidBottomInset;

  ///Preserves the state of each tab's screen. `true` by default.
  final bool? stateManagement;

  ///If you want to perform a custom action on Android when exiting the app, you can write your logic here.
  final Future<bool> Function(BuildContext)? onWillPop;

  ///Screen transition animation properties when switching tabs.
  final ScreenTransitionAnimation? screenTransitionAnimation;

  final bool? hideNavigationBarWhenKeyboardShows;

  ///This controls the animation properties of the items of the NavBar.
  final ItemAnimationProperties? itemAnimationProperties;

  ///Hides the navigation bar with an transition animation. Use it in conjuction with [Provider](https://pub.dev/packages/provider) for better results.
  final bool? hideNavigationBar;

  ///Define navigation bar route name and settings here.
  ///
  ///If you want to programmatically pop to initial screen on a specific use this route name when popping.
  final CustomWidgetRouteAndNavigatorSettings? routeAndNavigatorSettings;

  final bool? isCustomWidget;

  final BuildContext? context;

  final Function(BuildContext)? selectedTabScreenContext;

  @override
  _PersistentTabViewState createState() => _PersistentTabViewState();
}

class _PersistentTabViewState extends State<PersistentTabView> {
  late List<BuildContext?> _contextList;
  PersistentTabController? _controller;
  double? _navBarHeight;
  int? _previousIndex;
  int? _currentIndex;
  bool? _isCompleted;
  bool? _isAnimating;
  late bool _sendScreenContext;

  @override
  void initState() {
    super.initState();

    _contextList = List<BuildContext?>.filled(
        widget.items == null ? widget.itemCount ?? 0 : widget.items!.length,
        null);

    if (widget.controller == null) {
      _controller = PersistentTabController();
    } else {
      _controller = widget.controller;
    }

    _previousIndex = _controller!.index;
    _currentIndex = _controller!.index;

    _isCompleted = false;
    _isAnimating = false;
    _sendScreenContext = false;

    _controller!.addListener(() {
      if (_controller!.index != _currentIndex) {
        if (widget.selectedTabScreenContext != null) {
          _sendScreenContext = true;
        }
        if (mounted) {
          setState(
            () => _currentIndex = _controller!.index,
          );
        }
      }
    });
    if (widget.selectedTabScreenContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((final _) {
        widget.selectedTabScreenContext!(_contextList[_controller!.index]);
      });
    }
  }

  Widget _buildScreen(final int index) {
    final RouteAndNavigatorSettings routeAndNavigatorSettings = widget
            .isCustomWidget!
        ? RouteAndNavigatorSettings(
            defaultTitle: widget.routeAndNavigatorSettings!.defaultTitle,
            initialRoute: widget.routeAndNavigatorSettings!.initialRoute,
            navigatorKey:
                widget.routeAndNavigatorSettings!.navigatorKeys == null
                    ? null
                    : widget.routeAndNavigatorSettings!
                        .navigatorKeys![_controller!.index],
            navigatorObservers:
                widget.routeAndNavigatorSettings!.navigatorObservers,
            onGenerateRoute: widget.routeAndNavigatorSettings!.onGenerateRoute,
            onUnknownRoute: widget.routeAndNavigatorSettings!.onUnknownRoute,
            routes: widget.routeAndNavigatorSettings!.routes,
          )
        : widget.items![index].routeAndNavigatorSettings;

    if (widget.floatingActionButton != null) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SizedBox.expand(
            child: CustomTabView(
              routeAndNavigatorSettings: routeAndNavigatorSettings,
              builder: (final screenContext) {
                _contextList[index] = screenContext;
                if (_sendScreenContext) {
                  _sendScreenContext = false;
                  widget.selectedTabScreenContext!(_contextList[index]);
                }
                return Material(child: widget.screens[index]);
              },
            ),
          ),
          Positioned(
            bottom: widget.decoration!.borderRadius != BorderRadius.zero
                ? 25.0
                : 10.0,
            right: 10,
            child: widget.floatingActionButton!,
          ),
        ],
      );
    } else if (widget.navBarStyle == NavBarStyle.style15) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SizedBox.expand(
            child: CustomTabView(
              routeAndNavigatorSettings: routeAndNavigatorSettings,
              builder: (final screenContext) {
                _contextList[index] = screenContext;
                if (_sendScreenContext) {
                  _sendScreenContext = false;
                  widget.selectedTabScreenContext!(_contextList[index]);
                }
                return Material(child: widget.screens[index]);
              },
            ),
          ),
          if (_navBarHeight == 0)
            const SizedBox.shrink()
          else
            Positioned(
              bottom: (_navBarHeight! -
                      (widget.bottomScreenMargin ??
                          _navBarHeight! + widget.margin.top))
                  .abs(),
              child: GestureDetector(
                onTap: () {
                  if (widget.items![(widget.items!.length / 2).floor()]
                          .onPressed !=
                      null) {
                    widget.items![(widget.items!.length / 2).floor()]
                        .onPressed!(_contextList[_controller!.index]);
                  } else {
                    _controller!.index = (widget.items!.length / 2).floor();
                  }
                },
                child: Center(
                  child: Container(
                    height: 21.0 +
                        min(
                            widget.navBarHeight!,
                            max(
                                    widget.decoration!.borderRadius!.topRight.y,
                                    widget
                                        .decoration!.borderRadius!.topLeft.y) +
                                (widget.decoration?.border != null
                                    ? widget
                                        .decoration!.border!.dimensions.vertical
                                    : 0.0)),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2 -
                            (MediaQuery.of(context).size.width / 5.0 - 30.0) /
                                2),
                    width: MediaQuery.of(context).size.width / 5.0 - 30.0,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                        )),
                  ),
                ),
              ),
            ),
        ],
      );
    } else if (widget.navBarStyle == NavBarStyle.style16) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SizedBox.expand(
            child: CustomTabView(
              routeAndNavigatorSettings: routeAndNavigatorSettings,
              builder: (final screenContext) {
                _contextList[index] = screenContext;
                if (_sendScreenContext) {
                  _sendScreenContext = false;
                  widget.selectedTabScreenContext!(_contextList[index]);
                }
                return Material(child: widget.screens[index]);
              },
            ),
          ),
          if (_navBarHeight == 0)
            const SizedBox.shrink()
          else
            Positioned(
              bottom: (_navBarHeight! -
                      (widget.bottomScreenMargin ??
                          _navBarHeight! + widget.margin.top))
                  .abs(),
              child: GestureDetector(
                onTap: () {
                  if (widget.items![(widget.items!.length / 2).floor()]
                          .onPressed !=
                      null) {
                    widget.items![(widget.items!.length / 2).floor()]
                        .onPressed!(_contextList[_controller!.index]);
                  } else {
                    _controller!.index = (widget.items!.length / 2).floor();
                  }
                },
                child: Center(
                  child: Container(
                    height: 21 +
                        min(
                            widget.navBarHeight!,
                            max(
                                    widget.decoration!.borderRadius!.topRight.y,
                                    widget
                                        .decoration!.borderRadius!.topLeft.y) +
                                (widget.decoration?.border != null
                                    ? widget
                                        .decoration!.border!.dimensions.vertical
                                    : 0.0)),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2 -
                            (MediaQuery.of(context).size.width / 5.0 - 30.0) /
                                2),
                    width: MediaQuery.of(context).size.width / 5.0 - 30.0,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    } else {
      return CustomTabView(
          routeAndNavigatorSettings: routeAndNavigatorSettings,
          builder: (final screenContext) {
            _contextList[index] = screenContext;
            if (_sendScreenContext) {
              _sendScreenContext = false;
              widget.selectedTabScreenContext!(_contextList[index]);
            }
            return Material(child: widget.screens[index]);
          });
    }
  }

  Widget navigationBarWidget() => PersistentTabScaffold(
        controller: _controller,
        itemCount:
            widget.items == null ? widget.itemCount ?? 0 : widget.items!.length,
        bottomScreenMargin:
            widget.hideNavigationBar != null && widget.hideNavigationBar!
                ? 0.0
                : widget.bottomScreenMargin,
        stateManagement: widget.stateManagement,
        screenTransitionAnimation: widget.screenTransitionAnimation,
        hideNavigationBarWhenKeyboardShows:
            widget.hideNavigationBarWhenKeyboardShows,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        animatePadding: _isAnimating! || _isCompleted!,
        tabBar: PersistentBottomNavBar(
          navBarEssentials: NavBarEssentials(
            selectedIndex: _controller!.index,
            previousIndex: _previousIndex,
            padding: widget.padding,
            selectedScreenBuildContext: _contextList[_controller!.index],
            itemAnimationProperties: widget.itemAnimationProperties,
            items: widget.items,
            backgroundColor: widget.backgroundColor,
            navBarHeight: _navBarHeight,
            popScreensOnTapOfSelectedTab:
                widget.popAllScreensOnTapOfSelectedTab ?? true,
            popAllScreensOnTapAnyTabs:
                widget.popAllScreensOnTapAnyTabs ?? false,
            onItemSelected: widget.onItemSelected != null
                ? (final index) {
                    if (_controller!.index != _previousIndex) {
                      _previousIndex = _controller!.index;
                    }
                    if (((widget.popAllScreensOnTapOfSelectedTab ?? true) &&
                            _previousIndex == index) ||
                        (widget.popAllScreensOnTapAnyTabs ?? false)) {
                      popAllScreens();
                    }
                    _controller!.index = index;
                    widget.onItemSelected!(index);
                  }
                : (final index) {
                    if (_controller!.index != _previousIndex) {
                      _previousIndex = _controller!.index;
                    }
                    if (((widget.popAllScreensOnTapOfSelectedTab ?? true) &&
                            _previousIndex == index) ||
                        (widget.popAllScreensOnTapAnyTabs ?? false)) {
                      popAllScreens();
                    }
                    // popAllScreens();
                    _controller!.index = index;
                  },
          ),
          isCustomWidget: widget.isCustomWidget,
          navBarDecoration: widget.decoration,
          margin: widget.margin,
          confineToSafeArea: widget.confineInSafeArea,
          hideNavigationBar: widget.hideNavigationBar,
          navBarStyle: widget.navBarStyle,
          neumorphicProperties: widget.neumorphicProperties,
          customNavBarWidget: widget.customWidget,
          onAnimationComplete: (final isAnimating, final isCompleted) {
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
        ),
        tabBuilder: (final context, final index) => SafeArea(
          top: false,
          right: false,
          left: false,
          bottom: (widget.items != null &&
                      widget.items![_controller!.index].opacity < 1.0) ||
                  (widget.hideNavigationBar != null && _isCompleted!)
              ? false
              : widget.margin.bottom > 0
                  ? false
                  : widget.confineInSafeArea,
          child: _buildScreen(index),
        ),
      );

  @override
  Widget build(final BuildContext context) {
    _navBarHeight = (widget.resizeToAvoidBottomInset &&
            MediaQuery.of(widget.context).viewInsets.bottom > 0 &&
            widget.hideNavigationBarWhenKeyboardShows)
        ? 0.0
        : widget.navBarHeight ?? kBottomNavigationBarHeight;
    if (_contextList.length != (widget.itemCount ?? widget.items!.length)) {
      _contextList = List<BuildContext?>.filled(
          widget.items == null ? widget.itemCount ?? 0 : widget.items!.length,
          null);
    }

    if (widget.handleAndroidBackButtonPress || widget.onWillPop != null) {
      return WillPopScope(
        onWillPop: !widget.handleAndroidBackButtonPress &&
                widget.onWillPop != null
            ? widget.onWillPop!(_contextList[_controller!.index])
                as Future<bool> Function()?
            : widget.handleAndroidBackButtonPress && widget.onWillPop != null
                ? () async {
                    if (_controller!.index == 0 &&
                        !Navigator.canPop(_contextList.first!)) {
                      return widget.onWillPop!(_contextList.first);
                    } else {
                      if (Navigator.canPop(_contextList[_controller!.index]!)) {
                        Navigator.pop(_contextList[_controller!.index]!);
                      } else {
                        widget.onItemSelected?.call(0);
                        _controller!.index = 0;
                      }
                      return false;
                    }
                  }
                : () async {
                    if (_controller!.index == 0 &&
                        !Navigator.canPop(_contextList.first!)) {
                      return true;
                    } else {
                      if (Navigator.canPop(_contextList[_controller!.index]!)) {
                        Navigator.pop(_contextList[_controller!.index]!);
                      } else {
                        widget.onItemSelected?.call(0);
                        _controller!.index = 0;
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

  void popAllScreens() {
    if (widget.popAllScreensOnTapOfSelectedTab! ||
        widget.popAllScreensOnTapAnyTabs!) {
      if (widget.items![_controller!.index]
                  .onSelectedTabPressWhenNoScreensPushed !=
              null &&
          !Navigator.of(_contextList[_controller!.index]!).canPop()) {
        widget.items![_controller!.index]
            .onSelectedTabPressWhenNoScreensPushed!();
      }

      if (widget.popActionScreens == PopActionScreensType.once) {
        if (Navigator.of(_contextList[_controller!.index]!).canPop()) {
          Navigator.of(_contextList[_controller!.index]!).pop(context);
          return;
        }
      } else {
        Navigator.popUntil(
            _contextList[_controller!.index]!,
            ModalRoute.withName(widget.isCustomWidget!
                ? (widget.routeAndNavigatorSettings?.initialRoute ??
                    "/9f580fc5-c252-45d0-af25-9429992db112")
                : widget.items![_controller!.index].routeAndNavigatorSettings
                        .initialRoute ??
                    "/9f580fc5-c252-45d0-af25-9429992db112"));
      }
    }
  }
}

//asserts

bool assertMidButtonStyles(final NavBarStyle navBarStyle, final int itemCount) {
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
