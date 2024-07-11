// ignore_for_file: avoid_redundant_argument_values

import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";

import "package:persistent_bottom_nav_bar_example_project/main.dart";
import "package:persistent_bottom_nav_bar_example_project/screens.dart";

class CustomWidgetExample extends StatefulWidget {
  const CustomWidgetExample({
    required this.menuScreenContext,
    final Key? key,
  }) : super(key: key);
  final BuildContext menuScreenContext;

  @override
  _CustomWidgetExampleState createState() => _CustomWidgetExampleState();
}

class _CustomWidgetExampleState extends State<CustomWidgetExample> {
  late PersistentTabController _controller;
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  @override
  void dispose() {
    for (final element in _scrollControllers) {
      element.dispose();
    }
    super.dispose();
  }

  List<CustomNavBarScreen> _buildScreens() => [
        CustomNavBarScreen(
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              "/first": (final context) => const MainScreen2(),
              "/second": (final context) => const MainScreen3(),
            },
          ),
          screen: MainScreen(
            menuScreenContext: widget.menuScreenContext,
            scrollController: _scrollControllers.first,
            hideStatus: _hideNavBar,
            showNavBarStyles: false,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ),
        CustomNavBarScreen(
          screen: MainScreen(
            menuScreenContext: widget.menuScreenContext,
            scrollController: _scrollControllers[1],
            hideStatus: _hideNavBar,
            showNavBarStyles: false,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ),
        CustomNavBarScreen(
          screen: MainScreen(
            menuScreenContext: widget.menuScreenContext,
            scrollController: _scrollControllers[2],
            hideStatus: _hideNavBar,
            showNavBarStyles: false,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ),
        CustomNavBarScreen(
          screen: MainScreen(
            menuScreenContext: widget.menuScreenContext,
            scrollController: _scrollControllers[3],
            hideStatus: _hideNavBar,
            showNavBarStyles: false,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ),
        CustomNavBarScreen(
          screen: MainScreen(
            menuScreenContext: widget.menuScreenContext,
            scrollController: _scrollControllers.last,
            hideStatus: _hideNavBar,
            showNavBarStyles: false,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ),
      ];

  // List<PersistentBottomNavBarItem> is just for example here. It can be anything you want like List<YourItemWidget>
  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: "Search",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          title: "Add",
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Navigation Bar Demo")),
        drawer: const Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("This is the Drawer"),
              ],
            ),
          ),
        ),
        body: PersistentTabView.custom(
          context,
          controller: _controller,
          screens: _buildScreens(),
          itemCount: 5,
          isVisible: !_hideNavBar,
          hideOnScrollSettings: HideOnScrollSettings(
            hideNavBarOnScroll: true,
            scrollControllers: _scrollControllers,
          ),
          backgroundColor: Colors.grey.shade900,
          customWidget: CustomNavBarWidget(
            _navBarsItems(),
            onItemSelected: (final index) {
              //Scroll to top
              if (index == _controller.index) {
                _scrollControllers[index].animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              }

              setState(() {
                _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
              });
            },
            selectedIndex: _controller.index,
          ),
        ),
      );
}
