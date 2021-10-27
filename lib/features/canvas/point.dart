import 'dart:ui';

class Point {
  final double x, y;
  int? strokeID;
  Point({required this.x, required this.y});

  Offset get asOffset => Offset(x, y);
}
