part of persistent_bottom_nav_bar;

class _CurvedBazier extends StatefulWidget {
  const _CurvedBazier({
    required this.color,
    required this.index,
    required this.numberOfTabItems,
    required this.padding,
    final Key? key,
  }) : super(key: key);

  final Color color;
  final int index;
  final int numberOfTabItems;
  final EdgeInsets padding;

  @override
  State<_CurvedBazier> createState() => _CurvedBazierState();
}

class _CurvedBazierState extends State<_CurvedBazier>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightFactorAnimation;

  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    final initialAnimationValue = widget.index / widget.numberOfTabItems;
    _heightFactorAnimation = Tween<double>(begin: initialAnimationValue, end: 1)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animationHandler() {
    final double lastHeight = _heightFactorAnimation.value;
    final double newHeight = _index / (widget.numberOfTabItems - 1);

    _heightFactorAnimation = Tween<double>(begin: lastHeight, end: newHeight)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_animationController);

    _animationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(final context) {
    const double height = 20;

    if (_index != widget.index) {
      _index = widget.index;
      _animationHandler();
    }
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (final context, final child) => CustomPaint(
          painter: _CurvedBazierPainter(
            color: widget.color,
            index: _index,
            numberOfTabItems: widget.numberOfTabItems,
            heightFactor: _heightFactorAnimation.value,
            width: MediaQuery.of(context).size.width,
            height: height,
            padding: widget.padding,
          ),
          size: Size(MediaQuery.of(context).size.width, height),
        ),
      ),
    );
  }
}

class _CurvedBazierPainter extends CustomPainter {
  _CurvedBazierPainter({
    required this.color,
    required this.index,
    required this.numberOfTabItems,
    required this.heightFactor,
    required this.width,
    required this.height,
    required this.padding,
  });

  final Color color;
  final int index;
  final int numberOfTabItems;
  final double heightFactor;
  final double width;
  final double height;
  final EdgeInsets padding;

  @override
  void paint(final Canvas canvas, final Size size) {
    final painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.butt;

    final bazierPath = Path()
      ..moveTo(0, height * (1 - heightFactor))
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, height * heightFactor)
      ..quadraticBezierTo(
          width * 0.5, height * 1.1, 0, height * (1 - heightFactor))
      ..close();
    canvas.drawPath(bazierPath, painter);
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => true;
}
