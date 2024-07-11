import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";
import "package:persistent_bottom_nav_bar_example_project/modal_screen.dart";

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.menuScreenContext,
    required this.onScreenHideButtonPressed,
    this.scrollController,
    this.onNavBarStyleChanged,
    final Key? key,
    this.hideStatus = false,
    this.showNavBarStyles = true,
  }) : super(key: key);
  final BuildContext menuScreenContext;
  final VoidCallback onScreenHideButtonPressed;
  final bool hideStatus;
  final ScrollController? scrollController;
  final Function(NavBarStyle)? onNavBarStyleChanged;
  final bool showNavBarStyles;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 6,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Test Text Field"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: const RouteSettings(name: "/home"),
                        screen: const MainScreen2(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.scaleRotate,
                      );
                    },
                    child: const Text(
                      "Go to Second Screen ->",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        useRootNavigator: true,
                        builder: (final context) => Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Exit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Push bottom sheet on TOP of Nav Bar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        useRootNavigator: false,
                        builder: (final context) => Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Exit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Push bottom sheet BEHIND the Nav Bar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushDynamicScreen(context,
                          screen: SampleModalScreen(), withNavBar: true);
                    },
                    child: const Text(
                      "Push Dynamic/Modal Screen",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onScreenHideButtonPressed,
                    child: Text(
                      hideStatus
                          ? "Reveal Navigation Bar"
                          : "Hide Navigation Bar",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(menuScreenContext).pop();
                    },
                    child: const Text(
                      "<- Main Menu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (showNavBarStyles)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Navigation Bar Style",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: List.generate(
                            NavBarStyle.values.length,
                            (final index) => ElevatedButton(
                              onPressed: () => onNavBarStyleChanged
                                  ?.call(NavBarStyle.values[index]),
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.teal)),
                              child: Text(
                                NavBarStyle.values[index].name.toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      );
}

class MainScreen2 extends StatelessWidget {
  const MainScreen2({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const MainScreen3());
                },
                child: const Text(
                  "Go to Third Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Go Back to First Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
}

class MainScreen3 extends StatelessWidget {
  const MainScreen3({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Go Back to Second Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator
                      .popUntilFirstScreenOnSelectedTabScreen(context);
                },
                child: const Text(
                  "Pop back to First screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
}
