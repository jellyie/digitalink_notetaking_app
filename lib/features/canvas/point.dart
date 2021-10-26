import 'dart:ui';

class Point {
  final double x, y;
  int? strokeID;
  int? _intX, _intY;
  Point({required this.x, required this.y});

  Point.c1(this.x, this.y, this.strokeID);

  Offset get asOffset => Offset(x, y);

  int? get intX => _intX;
  int? get intY => _intY;
}
