part of persistent_bottom_nav_bar;

class BottomNavStyle12 extends StatefulWidget {
  const BottomNavStyle12({
    final Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;

  @override
  _BottomNavStyle12State createState() => _BottomNavStyle12State();
}

class _BottomNavStyle12State extends State<BottomNavStyle12>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllerList;
  late List<Animation<Offset>> _animationList;

  int? _lastSelectedIndex;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = 0;
    _selectedIndex = 0;
    _animationControllerList = List<AnimationController>.empty(growable: true);
    _animationList = List<Animation<Offset>>.empty(growable: true);

    for (int i = 0; i < widget.navBarEssentials!.items!.length; ++i) {
      _animationControllerList.add(AnimationController(
          duration:
              widget.navBarEssentials!.itemAnimationProperties?.duration ??
                  const Duration(milliseconds: 400),
          vsync: this));
      _animationList.add(Tween(
              begin: Offset(0, widget.navBarEssentials!.navBarHeight!),
              end: Offset.zero)
          .chain(CurveTween(
              curve: widget.navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease))
          .animate(_animationControllerList[i]));
    }

    WidgetsBinding.instance.addPostFrameCallback((final _) {
      _animationControllerList[_selectedIndex!].forward();
    });
  }

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height, final int itemIndex) =>
      widget.navBarEssentials!.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedBuilder(
              animation: _animationList[itemIndex],
              builder: (final context, final child) => SizedBox(
                width: 150,
                height: height,
                child: Container(
                  alignment: Alignment.center,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: IconTheme(
                          data: IconThemeData(
                              size: item.iconSize,
                              color: isSelected
                                  ? (item.activeColorSecondary ??
                                      item.activeColorPrimary)
                                  : item.inactiveColorPrimary ??
                                      item.activeColorPrimary),
                          child: item.iconBuilder != null
                              ? item.iconBuilder!(isSelected, item.icon)
                              : isSelected
                                  ? item.icon
                                  : item.inactiveIcon ?? item.icon,
                        ),
                      ),
                      if (item.title == null)
                        const SizedBox.shrink()
                      else
                        Transform.translate(
                          offset: _animationList[itemIndex].value,
                          child: AnimatedContainer(
                            duration: widget.navBarEssentials!
                                    .itemAnimationProperties?.duration ??
                                const Duration(milliseconds: 400),
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: isSelected
                                    ? (item.activeColorSecondary ??
                                        item.activeColorPrimary)
                                    : Colors.transparent),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );

  @override
  void dispose() {
    for (int i = 0; i < widget.navBarEssentials!.items!.length; ++i) {
      _animationControllerList[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    if (widget.navBarEssentials!.items!.length !=
        _animationControllerList.length) {
      _animationControllerList =
          List<AnimationController>.empty(growable: true);
      _animationList = List<Animation<Offset>>.empty(growable: true);

      for (int i = 0; i < widget.navBarEssentials!.items!.length; ++i) {
        _animationControllerList.add(AnimationController(
            duration:
                widget.navBarEssentials!.itemAnimationProperties?.duration ??
                    const Duration(milliseconds: 400),
            vsync: this));
        _animationList.add(Tween(
                begin: Offset(0, widget.navBarEssentials!.navBarHeight!),
                end: Offset.zero)
            .chain(CurveTween(
                curve:
                    widget.navBarEssentials!.itemAnimationProperties?.curve ??
                        Curves.ease))
            .animate(_animationControllerList[i]));
      }
    }
    if (widget.navBarEssentials!.selectedIndex != _selectedIndex) {
      _lastSelectedIndex = _selectedIndex;
      _selectedIndex = widget.navBarEssentials!.selectedIndex;
      _animationControllerList[_selectedIndex!].forward();
      _animationControllerList[_lastSelectedIndex!].reverse();
    }
    return Container(
      width: double.infinity,
      height: widget.navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          left: widget.navBarEssentials!.padding?.left ??
              MediaQuery.of(context).size.width * 0.04,
          right: widget.navBarEssentials!.padding?.right ??
              MediaQuery.of(context).size.width * 0.04,
          top: widget.navBarEssentials!.padding?.top ??
              widget.navBarEssentials!.navBarHeight! * 0.15,
          bottom: widget.navBarEssentials!.padding?.bottom ??
              widget.navBarEssentials!.navBarHeight! * 0.12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.navBarEssentials!.items!.map((final item) {
          final int index = widget.navBarEssentials!.items!.indexOf(item);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.navBarEssentials!.items![index].onPressed != null) {
                  widget.navBarEssentials!.items![index].onPressed!(
                      widget.navBarEssentials!.selectedScreenBuildContext);
                } else {
                  if (index != _selectedIndex) {
                    _lastSelectedIndex = _selectedIndex;
                    _selectedIndex = index;
                    _animationControllerList[_selectedIndex!].forward();
                    _animationControllerList[_lastSelectedIndex!].reverse();
                  }
                  widget.navBarEssentials!.onItemSelected!(index);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: _buildItem(
                    item,
                    widget.navBarEssentials!.selectedIndex == index,
                    widget.navBarEssentials!.navBarHeight,
                    index),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
