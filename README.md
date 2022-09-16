# Persistent Bottom Navigation Bar

[![pub package version](https://img.shields.io/pub/v/persistent_bottom_nav_bar)](https://pub.dev/packages/persistent_bottom_nav_bar)
[![license](https://img.shields.io/github/license/BilalShahid13/PersistentBottomNavBar)](https://github.com/BilalShahid13/PersistentBottomNavBar/blob/master/LICENSE)
[![github stars](https://img.shields.io/github/stars/BilalShahid13/PersistentBottomNavBar?style=social)](https://github.com/BilalShahid13/PersistentBottomNavBar/stargazers)

A persistent/static bottom navigation bar for Flutter.

NOTE: Those migrating from **pre 2.0.0** version should check the latest Readme and instructions as there are many breaking changes introduced in the 2.0.0 update

![Persistent Behavior](gifs/persistent.gif)

## Styles

| Style15  | Style16 |
| ------------- | ------------- |
| ![style1](gifs/style-15.gif)  | ![style10](gifs/style-16.gif)  |

| Style1  | Style9 |
| ------------- | ------------- |
| ![style1](gifs/style-1.gif)  | ![style10](gifs/style-9.gif)  |

| Style7  | Style10 |
| ------------- | ------------- |
| ![style3](gifs/style-7.gif)  | ![style5](gifs/style-10.gif)  |

| Style12  | Style13 |
| ------------- | ------------- |
| ![style6](gifs/style-12.gif)  | ![style8](gifs/style-13.gif)  |

| Style3 | Style6 |
| ------------- | ------------- |
| ![style6](gifs/style-3.gif)  | ![style8](gifs/style-6.gif)  |

| Neumorphic  | Neumorphic without subtitle |
| ------------- | ------------- |
| ![neumorphic1](gifs/neumorphic.gif)  | ![neumorphic2](gifs/neumorphic-nosubs.gif)  |

### Note: These do not include all style variations

## Features

- Highly customizable `persistent` bottom navigation bar.
- Ability to push new screens with or without bottom navigation bar.
- 20 styles for the bottom navigation bar.
- Includes functions for pushing screen with or without the bottom navigation bar i.e. pushNewScreen() and pushNewScreenWithRouteSettings().
- Based on flutter's Cupertino(iOS) bottom navigation bar.
- Can be `translucent` for a particular tab.
- Custom styling for the navigation bar. Click [here](#custom-navigation-bar-styling) for more information.
- Handles hardware/software Android back button.

## Getting Started

In your flutter project add the dependency:

```yaml
dependencies:
  persistent_bottom_nav_bar: any
```

Import the package:

```dart
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
```

Persistent bottom navigation bar uses `PersistentTabController` as its controller. Here is how to declare it:

```dart
PersistentTabController _controller;

_controller = PersistentTabController(initialIndex: 0);

```

The main widget then to be declared is `PersistentTabView`. NOTE: This widget includes SCAFFOLD (based on `CupertinoTabScaffold`), so no need to declare it. Following is an example for demonstration purposes:

```dart

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

```

```dart

    List<Widget> _buildScreens() {
        return [
          MainScreen(),
          SettingsScreen()
        ];
    }

```

```dart

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.settings),
                title: ("Settings"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }

```

## Navigator Functions

**Note: You still can use regular Navigator functions like 'pushNamed' but be sure to check the argument `routeAndNavigatorSettings` your `PersistentBottomNavBarItem` for route settings and some other navigator related properties**
To push a new screen, use the following functions to control the `visibility` of bottom navigation bar on a particular screen. You can use your own logic to implement `platform-specific` behavior. One of the solutions could be to use the property `withNavBar` and toggle it according to the Platform.

In `platform-specific` behavior, while pushing a new screen, on `Android` it will push the screen WITHOUT the bottom navigation bar but on `iOS` it will persist the bottom navigation bar. This is the default behavior specified by each platform.

```dart

    PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MainScreen(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );

```

```dart

    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: MainScreen.routeName),
        screen: MainScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );

```

If you are pushing a new `modal` screen, use the following function:

```dart

    PersistentNavBarNavigator.pushDynamicScreen(
        context,
        screen: HomeModalScreen(),
        withNavBar: true,
    );

```

### Some Useful Tips

- Pop to any screen in the navigation graph for a given tab:

    ```dart
        Navigator.of(context).popUntil((route) {
            return route.settings.name == "ScreenToPopBackTo";
        });
    ```

- Pop back to first screen in the navigation graph for a given tab:

    ```dart
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
    ```

    ```dart
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return FirstScreen();
            },
          ),
          (_) => false,
        );
    ```

- To push bottom sheet on top of the Navigation Bar, use showModalBottomScreen and set it's property `useRootNavigator` to true. See example project for an illustration.

## Custom Navigation Bar Styling

If you want to have your own style for the navigation bar, follow these steps:

1. Declare your custom widget. Please keep in mind that you will have to handle the function `onSelectedItem` and the integer `selectedIndex` yourself to maintain full functionality. Also please note that you can define your own model for the navigation bar item instead of the provided `PersistentBottomNavBarItem`. See this example below for better understanding:

    ```dart

        class CustomNavBarWidget extends StatelessWidget {
            final int selectedIndex;
            final List<PersistentBottomNavBarItem> items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
            final ValueChanged<int> onItemSelected;

            CustomNavBarWidget(
                {Key key,
                this.selectedIndex,
                @required this.items,
                this.onItemSelected,});

            Widget _buildItem(
                PersistentBottomNavBarItem item, bool isSelected) {
                return Container(
                alignment: Alignment.center,
                height: 60.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                    Flexible(
                        child: IconTheme(
                        data: IconThemeData(
                            size: 26.0,
                            color: isSelected
                                ? (item.activeColorSecondary == null
                                    ? item.activeColorPrimary
                                    : item.activeColorSecondary)
                                : item.inactiveColorPrimary == null
                                    ? item.activeColorPrimary
                                    : item.inactiveColorPrimary),
                        child: item.icon,
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Material(
                        type: MaterialType.transparency,
                        child: FittedBox(
                            child: Text(
                            item.title,
                            style: TextStyle(
                                color: isSelected
                                    ? (item.activeColorSecondary == null
                                        ? item.activeColorPrimary
                                        : item.activeColorSecondary)
                                    : item.inactiveColorPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                        )),
                        ),
                    )
                    ],
                ),
                );
            }

            @override
            Widget build(BuildContext context) {
                return Container(
                color: Colors.white,
                child: Container(
                    width: double.infinity,
                    height: 60.0,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: items.map((item) {
                        int index = items.indexOf(item);
                        return Flexible(
                        child: GestureDetector(
                            onTap: () {
                            this.onItemSelected(index);
                            },
                            child: _buildItem(
                                item, selectedIndex == index),
                        ),
                        );
                    }).toList(),
                    ),
                ),
                );
            }
        }

    ```

2. In the main `PersistentTabView` widget, set the `navBarStyle` property as `NavBarStyle.custom` and pass on the custom widget you just created in the `customWidget` property like this:

    ```dart

    class MyApp extends StatelessWidget {
        const MyApp({Key key}) : super(key: key);

        @override
        Widget build(BuildContext context) {
            return PersistentTabView.custom(
                context,
                controller: _controller,
                itemCount: items.length, // This is required in case of custom style! Pass the number of items for the nav bar.
                screens: _buildScreens(),
                confineInSafeArea: true,
                handleAndroidBackButtonPress: true,
                onItemSelected: (int) {
                    setState(() {}); // This is required to update the nav bar if Android back button is pressed
                },
                customWidget: CustomNavBarWidget( // Your custom widget goes here
                    items: _navBarsItems(),
                    selectedIndex: _controller.index,
                    onItemSelected: (index) {
                        setState(() {
                            _controller.index = index; // NOTE: THIS IS CRITICAL!! Don't miss it!
                        });
                    },
                ),
            );
        }
    }

    ```

    `NOTE: In the 'onSelected' function of the customWidget, don't forgot to change the index of the controller`

3. Done! As we can see, some of the other properties like `iconSize`, `items` are not required here so you can skip those properties. To control the **bottom padding** of the screen, use `bottomScreenPadding`. If you give too much `bottomScreenPadding` but less height in the custom widget or vice versa, layout issues might appear.

For better understanding, refer to the [example project](https://github.com/BilalShahid13/PersistentBottomNavBar/tree/master/example) in the official git repo.