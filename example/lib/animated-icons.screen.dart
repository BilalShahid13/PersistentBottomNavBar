import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";
import "package:persistent_bottom_nav_bar_example_project/screens.dart";

class AnimatedIconScreen extends StatefulWidget {
  const AnimatedIconScreen({required this.menuScreenContext, super.key});
  final BuildContext menuScreenContext;

  @override
  State<AnimatedIconScreen> createState() => _AnimatedIconScreenState();
}

class _AnimatedIconScreenState extends State<AnimatedIconScreen>
    with TickerProviderStateMixin {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  late final List<AnimationController> _animationControllers;

  late final List<Animation<double>> _animationValues;

  NavBarStyle _navBarStyle = NavBarStyle.simple;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();

    _animationControllers = [
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    ];

    _animationValues = [
      Tween<double>(begin: 0.toDouble(), end: 1.toDouble())
          .animate(_animationControllers.first),
      Tween<double>(begin: 0.toDouble(), end: 1.toDouble())
          .animate(_animationControllers[1]),
      Tween<double>(begin: 0.toDouble(), end: 1.toDouble())
          .animate(_animationControllers[2]),
      Tween<double>(begin: 0.toDouble(), end: 1.toDouble())
          .animate(_animationControllers[3]),
      Tween<double>(begin: 0.toDouble(), end: 1.toDouble())
          .animate(_animationControllers.last),
    ];
    _hideNavBar = false;
  }

  @override
  void dispose() {
    for (final element in _scrollControllers) {
      element.dispose();
    }
    for (final element in _animationControllers) {
      element.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildScreens() => [
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          scrollController: _scrollControllers.first,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
          onNavBarStyleChanged: (final value) =>
              setState(() => _navBarStyle = value),
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          scrollController: _scrollControllers[1],
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
          onNavBarStyleChanged: (final value) =>
              setState(() => _navBarStyle = value),
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          scrollController: _scrollControllers[2],
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
          onNavBarStyleChanged: (final value) =>
              setState(() => _navBarStyle = value),
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          scrollController: _scrollControllers[3],
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
          onNavBarStyleChanged: (final value) =>
              setState(() => _navBarStyle = value),
        ),
        MainScreen(
          menuScreenContext: widget.menuScreenContext,
          scrollController: _scrollControllers.last,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
          onNavBarStyleChanged: (final value) =>
              setState(() => _navBarStyle = value),
        ),
      ];

  Color? _getSecondaryItemColorForSpecificStyles() =>
      _navBarStyle == NavBarStyle.style7 ||
              _navBarStyle == NavBarStyle.style10 ||
              _navBarStyle == NavBarStyle.style15 ||
              _navBarStyle == NavBarStyle.style16 ||
              _navBarStyle == NavBarStyle.style17 ||
              _navBarStyle == NavBarStyle.style18
          ? Colors.white
          : null;

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: AnimatedIcon(
            icon: AnimatedIcons.home_menu,
            progress: _animationValues.first,
          ),
          iconAnimationController: _animationControllers.first,
          title: "Home",
          activeColorPrimary: Colors.blue,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedIcon(
            icon: AnimatedIcons.search_ellipsis,
            progress: _animationValues[1],
          ),
          iconAnimationController: _animationControllers[1],
          title: "Search",
          activeColorPrimary: Colors.teal,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedIcon(
            icon: AnimatedIcons.event_add,
            progress: _animationValues[2],
          ),
          iconAnimationController: _animationControllers[2],
          title: "Add",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: _getSecondaryItemColorForSpecificStyles(),
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: _animationValues[3],
          ),
          iconAnimationController: _animationControllers[3],
          title: "Messages",
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedIcon(
            icon: AnimatedIcons.list_view,
            progress: _animationValues.last,
          ),
          iconAnimationController: _animationControllers.last,
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Navigation Bar Demo"),
          backgroundColor: Colors.grey.shade900,
        ),
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
        body: PersistentTabView(
          context,
          controller: _controller,
          padding: const EdgeInsets.only(top: 8),
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          // hideOnScrollSettings: const HideOnScrollSettings(hideNavBarOnScroll: true),
          onWillPop: (final context) async {
            await showDialog(
              context: context ?? this.context,
              useSafeArea: true,
              builder: (final context) => Container(
                height: 50,
                width: 50,
                color: Colors.white,
                child: ElevatedButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
            return false;
          },
          backgroundColor: Colors.grey.shade900,
          isVisible: !_hideNavBar,
          navBarStyle:
              _navBarStyle, // Choose the nav bar style with this property
        ),
      );
}
