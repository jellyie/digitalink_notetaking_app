import 'dart:ui';

/// Implements a 2D Point that exposes X, Y, and StrokeID properties.
/// StrokeID is the stroke index the point belongs to (e.g., 0, 1, 2, ...) that is filled by counting pen down/up events.
class Point {
  double x, y; // point coordinates
  int strokeID; // the stroke index to which this point belongs
  int intX = 0,
      intY =
          0; // integer coordinates for LUT indexing (used by $Q's lower bounding optimization; see QPointCloudRecognizer.dart)

  Point(this.x, this.y, [this.strokeID = 0]);

  Offset get asOffset => Offset(x, y);
}
