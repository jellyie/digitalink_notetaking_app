import '../../models/state/canvas_state.dart';
import 'package:flutter/material.dart';

import '../../models/stroke/stroke.dart';

class CanvasPainter extends CustomPainter {
  final CanvasState state;

  CanvasPainter({required this.state});

  List<Stroke> get strokes => state.strokes;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      ..isAntiAlias = true;

    for (int x = 0; x < strokes.length; ++x) {
      final stroke = strokes[x];
      // ignore: unnecessary_null_comparison
      if (stroke.strokePoints.isEmpty) continue;
      for (int y = 0; y < stroke.strokePoints.length - 1; ++y) {
        final p1 = stroke.strokePoints[y].asOffset;
        final p2 = stroke.strokePoints[y + 1].asOffset;
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) =>
      oldDelegate.strokes != strokes;
}
