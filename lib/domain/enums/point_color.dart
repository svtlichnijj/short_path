import 'dart:ui';

class PointColor {
  static get(PointColorTypes type, {double opacity = 1.0}) {
    String prefix = '0x' + (opacity.clamp(0.0, 1.0) * 255).round().toRadixString(16).toUpperCase();

    return Color(int.parse(type.value.replaceFirst('#', prefix)));
  }
}

// enhanced enum is more like a constant class
enum PointColorTypes {
  starting('#64FFDA'),
  ending('#009688'),
  blocked('#000000'),
  shortestPath('#4CAF50'),
  empty('#FFFFFF');

  // can add more properties or getters/methods if needed
  final String value;

  // can use named parameters if you want
  const PointColorTypes(this.value);
}
