import 'package:digitalink_notetaking_app/features/canvas/q_dollar_recognizer/templates.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import '../q_dollar_recognizer/point.dart';
import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/q_dollar_recognizer.dart';
import 'painter/stroke.dart';
import 'painter/canvas_painter.dart';

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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    List<Point> p = [];
                    for (Stroke? s in strokes) {
                      if (s == null) continue;
                      for (Point pt in s.strokePoints) {
                        p.add(pt);
                      }
                    }
                    result = qDollarRecognizer.recognize(Gesture(p));
                    final snackBar = SnackBar(
                        content: Text('Gesture was recognized as.... $result'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Recognize Gesture'),
                ),
                buildClearCanvasButton(),
                buildAddGestureButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildClearCanvasButton() {
    return ElevatedButton(
      onPressed: () {
        strokes = <Stroke>[];
        activeStroke = null;
      },
      child: const Text('Clear Canvas'),
    );
  }

// Ignore this method, it's for creating the gesture templates
  Widget buildAddGestureButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: () {
          saveGesture();
        },
        child: const Text('Add gesture'),
      ),
    );
  }

// Ignore this method, it's for creating the gesture templates
  void saveGesture() {
    print('\n\n');

    for (int x = 0; x < strokes.length; ++x) {
      final _stroke = strokes[x];
      if (_stroke == null) continue;
      for (int y = 0; y < _stroke.strokePoints.length - 1; ++y) {
        final p1 = _stroke.strokePoints[y].asOffset;
        print("Stroke: $x Point $y: OFFSET = ${p1.toString()}");
      }
    }
    print('----------------------------------------------------------------');
  }

  // Future<void> _recogniseText() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) => const AlertDialog(
  //             title: Text('Recognising'),
  //           ),
  //       barrierDismissible: true);
  //   try {
  //     // List<Point> points = List<Point>.of(activeStroke!.strokePoints);
  //     // List<Offset> o = [];
  //     // for (Point p in points) {
  //     //   o.add(p.asOffset);
  //     // } MLKIT
  //     // List<Point> p = [];
  //     //     for (Stroke? s in strokes) {
  //     //       if (s == null) continue;
  //     //       for (Point pt in s.strokePoints) {
  //     //         p.add(pt);
  //     //       }
  //     //     }
  //     //     result = qDollarRecognizer.recognize(Gesture(p));
  //     final snackBar =
  //         SnackBar(content: Text('Gesture was recognized as.... $result'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(e.toString()),
  //     ));
  //   }
  //   Navigator.pop(context);
  // }

  Widget buildRecognizeButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          // final snackBar =
          //     SnackBar(content: Text('Gesture was recognized as.... $result'));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        onPanEnd: (details) {
          strokes = List.from(strokes)..add(activeStroke);
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
