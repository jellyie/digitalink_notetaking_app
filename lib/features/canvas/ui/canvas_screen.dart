import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import '../q_dollar_recognizer/point.dart';
import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/q_dollar_recognizer.dart';
import '../stroke.dart';

// ignore: use_key_in_widget_constructors
class CanvasScreen extends StatefulWidget {
  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<Stroke?> strokes = <Stroke>[];
  Stroke? activeStroke;

  StreamController<List<Stroke?>> strokesStreamController =
      StreamController<List<Stroke?>>.broadcast();
  StreamController<Stroke?> activeStrokeStreamController =
      StreamController<Stroke?>.broadcast();

  QDollarRecognizer qDollarRecognizer = QDollarRecognizer();
  String result = 'try again :(';

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
          buildRecognizeButton()
        ],
      ),
    );
  }

  Widget buildRecognizeButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () async {
          final snackBar =
              SnackBar(content: Text('Gesture was recognized as.... $result'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Recognize Gesture'),
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
          stream: strokesStreamController.stream,
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
          final _p = Point(_localPosition.dx, _localPosition.dy);
          activeStroke = Stroke(strokePoints: [_p]);
        },
        onPanUpdate: (details) {
          final Offset _localPosition = details.localPosition;
          final _p = Point(_localPosition.dx, _localPosition.dy);
          final _s = activeStroke!.strokePoints;

          List<Point> _points = List.from(_s)..add(_p);
          activeStroke = Stroke(strokePoints: _points);
          activeStrokeStreamController.add(activeStroke);
        },
        onPanEnd: (details) async {
          strokes = List.from(strokes)..add(activeStroke);
          List<Point> p = [];
          for (Stroke? s in strokes) {
            if (s == null) continue;
            for (Point pt in s.strokePoints) {
              p.add(pt);
            }
          }
          result = await qDollarRecognizer.recognize(Gesture(p));
        },
        child: RepaintBoundary(
          child: Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(4.0),
            color: Colors.transparent,
            child: StreamBuilder<Stroke?>(
              stream: activeStrokeStreamController.stream,
              builder: (context, snapshot) {
                return CustomPaint(
                    painter: CanvasPainter(
                  strokes: [activeStroke],
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
