/// Based on the code by Ivan Cherepanov
/// https://medium.com/flutter-community/neumorphic-designs-in-flutter-eab9a4de2059
part of persistent_bottom_nav_bar;

enum CurveType {
  concave,
  convex,
  emboss,
  flat,
}

class NeumorphicContainer extends StatelessWidget {
  NeumorphicContainer({
    this.child,
    this.bevel = 12.0,
    this.curveType = CurveType.convex,
    Color color,
    NeumorphicDecoration decoration,
    this.alignment,
    this.width,
    this.height,
    BoxConstraints constraints,
    this.margin,
    this.padding,
    this.transform,
    Key key,
  })  : decoration = decoration ?? NeumorphicDecoration(color: color),
        constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints,
        super(key: key);

  final Widget child;

  /// Elevation relative to parent. Main constituent of Neumorphism
  final double bevel;
  final CurveType curveType;

  /// The decoration to paint behind the [child].
  ///
  /// A shorthand for specifying just a solid color is available in the
  /// constructor: set the `color` argument instead of the `decoration`
  /// argument.
  final NeumorphicDecoration decoration;

  final AlignmentGeometry alignment;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final EdgeInsets padding;
  final Matrix4 transform;

  @override
  Widget build(BuildContext context) {
    final color = decoration?.color ?? Theme.of(context).backgroundColor;
    final emboss = curveType == CurveType.emboss;

    Color colorValue = color;

    List<BoxShadow> shadowList = [
      BoxShadow(
        color: _getAdjustColor(color, emboss ? 0 - bevel : bevel),
        offset: Offset(0 - bevel, 0 - bevel),
        blurRadius: bevel,
      ),
      BoxShadow(
        color: _getAdjustColor(color, emboss ? bevel : 0 - bevel),
        offset: Offset(bevel, bevel),
        blurRadius: bevel,
      )
    ];

    if (emboss) {
      shadowList = [
        BoxShadow(
          color: _getAdjustColor(color, bevel),
          offset: Offset(bevel / 4, bevel / 4),
          blurRadius: bevel / 4,
        ),
        BoxShadow(
          color: _getAdjustColor(color, 0 - bevel),
          offset: Offset(0 - bevel / 6, 0 - bevel / 6),
          blurRadius: bevel / 6,
        ),
      ];

      colorValue = _getAdjustColor(colorValue, 0 - bevel / 2);
    }

    Gradient gradient;
    switch (curveType) {
      case CurveType.concave:
        gradient = _getConcaveGradients(colorValue, bevel);
        break;
      case CurveType.convex:
        gradient = _getConvexGradients(colorValue, bevel);
        break;
      case CurveType.emboss:
      case CurveType.flat:
        gradient = _getFlatGradients(colorValue, bevel);
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      alignment: alignment,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      padding: padding,
      transform: transform,
      decoration: BoxDecoration(
        borderRadius: decoration.borderRadius,
        gradient: gradient,
        boxShadow: shadowList,
        shape: decoration.shape,
        border: decoration.border,
      ),
      child: child,
    );
  }

  Color _getAdjustColor(Color baseColor, double amount) {
    Map<String, int> colors = {
      'r': baseColor.red,
      'g': baseColor.green,
      'b': baseColor.blue
    };

    colors = colors.map((key, value) {
      if (value + amount < 0) {
        return MapEntry(key, 0);
      }
      if (value + amount > 255) {
        return MapEntry(key, 255);
      }
      return MapEntry(key, (value + amount).floor());
    });
    return Color.fromRGBO(colors['r'], colors['g'], colors['b'], 1);
  }

  Gradient _getFlatGradients(Color baseColor, double depth) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor,
          baseColor,
        ],
      );

  Gradient _getConcaveGradients(Color baseColor, double depth) =>
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _getAdjustColor(baseColor, 0 - depth),
          _getAdjustColor(baseColor, depth),
        ],
      );

  Gradient _getConvexGradients(Color baseColor, double depth) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _getAdjustColor(baseColor, depth),
          _getAdjustColor(baseColor, 0 - depth),
        ],
      );
}

class NeumorphicDecoration {
  const NeumorphicDecoration({
    this.color,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.border,
  });

  final Color color;
  final BorderRadiusGeometry borderRadius;
  final BoxShape shape;
  final BoxBorder border;
}
