import 'dart:async';
import 'dart:ui';

import 'package:digitalink_notetaking_app/features/canvas/point.dart';
import 'package:digitalink_notetaking_app/features/canvas/stroke.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CanvasScreen extends StatefulWidget {
  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<Stroke?> strokes = <Stroke>[];
  Stroke? singleStroke;

  StreamController<List<Stroke?>> linesStreamController =
      StreamController<List<Stroke?>>.broadcast();
  StreamController<Stroke?> currentLineStreamController =
      StreamController<Stroke?>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Canvas Screen'),
      ),
      body: Stack(
        children: [
          buildAllStrokes(context),
          buildActiveStroke(context),
        ],
      ),
    );
  }

  Widget buildAllStrokes(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.topLeft,
        child: StreamBuilder<List<Stroke?>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: CanvasPainter(
                strokes: strokes,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildActiveStroke(BuildContext context) {
    return GestureDetector(
        onPanStart: (details) {
          final Offset _localPosition = details.localPosition;
          final _p = Point(x: _localPosition.dx, y: _localPosition.dy);
          singleStroke = Stroke(strokePoints: [_p]);
        },
        onPanUpdate: (details) {
          final Offset _localPosition = details.localPosition;
          final _p = Point(x: _localPosition.dx, y: _localPosition.dy);
          // Stroke _s = Stroke(strokePoints: );
          final _s = singleStroke!.strokePoints;

          List<Point> _points = List.from(_s)..add(_p);
          singleStroke = Stroke(strokePoints: _points);
          currentLineStreamController.add(singleStroke);
        },
        onPanEnd: (details) {
          strokes = List.from(strokes)..add(singleStroke);
        },
        child: RepaintBoundary(
          child: Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(4.0),
            color: Colors.transparent,
            child: StreamBuilder<Stroke?>(
              stream: currentLineStreamController.stream,
              builder: (context, snapshot) {
                return CustomPaint(
                    painter: CanvasPainter(
                  strokes: [singleStroke],
                ));
              },
            ),
          ),
        ));
  }
}

class CanvasPainter extends CustomPainter {
  final List<Stroke?> strokes;

  CanvasPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      ..isAntiAlias = true;

    for (int x = 0; x < strokes.length; ++x) {
      final stroke = strokes[x];
      if (stroke == null) continue;
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
