import 'dart:async';

import '../q_dollar_recognizer/templates.dart';

import 'widgets/widget_notifier.dart';
import 'package:flutter/widgets.dart';

import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/q_dollar_recognizer.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'stroke/stroke.dart';
import 'canvas/canvas.dart';
import 'state/canvas_state.dart';
import '../q_dollar_recognizer/point.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

/// Load in geometric shapes training set for gesture recognition
final List<Gesture> _trainingSet = Templates.templates;

/// This class interprets the raw data about the user's input
class CanvasNotifier extends StateNotifier<CanvasState> {
  CanvasNotifier({Canvas? canvas})
      : super(CanvasState.gesture(
          canvas: canvas ?? const Canvas(strokes: []),
          ignore: false,
        )) {
    state = CanvasState.gesture(
      canvas: canvas ?? const Canvas(strokes: []),
      ignore: ignore,
    );
    _languageModelManager.downloadModel(_language);
  }

  final Stopwatch _timer = Stopwatch();

  late WidgetNotifier _notifier;

  final GlobalKey _globalKey = GlobalKey();
  GlobalKey get globalkey => _globalKey;

  /// Used to switch between the Canvas layer and the WidgetListBuilder layer
  /// due to Stack terminating Hit Testing after the first widget (visually)
  /// on top of another widget in the same stack is hit
  bool ignore = false;
  CanvasState toggleIgnore() =>
      state = state.copyWith(ignore: ignore = !ignore);

  // Initiate digital ink recogniser
  final DigitalInkRecogniser _digitalInkRecogniser =
      GoogleMlKit.vision.digitalInkRecogniser();
  final LanguageModelManager _languageModelManager =
      GoogleMlKit.vision.languageModelManager();

  String _recogniseText = ' ';
  final String _language = 'en-US';

  // Initiate gesture recogniser
  String _gesture = ' ';
  final QDollarRecognizer _recognizer = QDollarRecognizer();
  List<Point> qpoints = [];

  /// Returns the most recent Offset as a Point
  Point _getPoint(Offset o) {
    return Point(o.dx, o.dy);
  }

  /// Access the WidgetNotifier from the same context
  void readWidgetNotifier(WidgetNotifier notifier) {
    _notifier = notifier;
  }

  /// Return the WidgetNotifier obtained from the same context
  WidgetNotifier get getWidgetNotifier => _notifier;

  /// Returns a copy of the state with the new Point appended to a copy of the active Stroke
  CanvasState _addPoint(Offset o, CanvasState state) {
    // Return the current state if there isn't an active Stroke
    if (state is GestureMode && state.activeStroke == null) return state;

    // Else return a copy of the state with the new Point appended to a copy of the active Stroke
    final stroke = (state as GestureMode).activeStroke!;
    return state.copyWith(
      activeStroke: stroke.copyWith(
        strokePoints: [
          ...stroke.strokePoints,
          _getPoint(o),
        ],
      ),
    );
  }

  /// Returns a copy of the state with the new Stroke appended
  CanvasState _completeStroke(CanvasState state) {
    // Return the current state if there isn't an active Stroke
    if ((state as GestureMode).activeStroke == null) {
      return state;
    }
    // Return a copy of the state with the new Stroke appended
    return state.copyWith(
        activeStroke: null,
        canvas: state.canvas.copyWith(
          strokes: [...state.canvas.strokes, state.activeStroke!],
        ));
  }

  /// Create a copy of the state with a new Stroke appended
  void onPanStart(DragStartDetails d) {
    if (state is GestureMode) {
      // _timer.stop();
      state = state.copyWith(
        activeStroke: Stroke(strokePoints: [_getPoint(d.localPosition)]),
      );
    }
  }

  /// Update the state with the new point and append a new stroke
  void onPanUpdate(DragUpdateDetails d) {
    if (state is GestureMode) {
      state = _addPoint(d.localPosition, state);
      state = state.copyWith(activeStroke: state.activeStroke);
    }
  }

  /// Complete the current stroke
  void onPanEnd(DragEndDetails d) {
    if (state is GestureMode) {
      // print('is timer running? ${_timer.isRunning}');
      // print(_timer.elapsed);
      state = _completeStroke(state);
      // if (_timer.isRunning && _timer.elapsedMilliseconds > 1000) {
      //   print('recognise?');
      //   _timer.stop();
      //   recogniseShape(_trainingSet);
      // }
    }
  }

  /// Clear the state or reset the canvas
  CanvasState clear() {
    return state =
        CanvasState.gesture(canvas: const Canvas(strokes: []), ignore: ignore);
  }

  /// Return the value of the handwritten text as recognised string
  Future<void> recogniseText() async {
    List<Offset> points = [];
    List<String> _candidatesList = [];
    for (Stroke s in state.strokes) {
      List<Offset> _p = s.strokePoints.map((p) => p.asOffset).toList();
      points.addAll(_p);
    }

    try {
      final candidates =
          await _digitalInkRecogniser.readText(points, _language);
      _recogniseText = (candidates.first).text;

      _candidatesList = [];
      // store the first 5 candidates
      for (int i = 0; i < 5; i++) {
        _candidatesList.add(candidates[i].text);
      }
    } catch (e) {
      print(e.toString());
    }
    _notifier.updateWidgetData(_recogniseText);
    //update the candidateList
    _notifier.updateCandidateData(_candidatesList);
    print('Recognised as......$_recogniseText');
  }

  /// Return the value of the drawn shape as a string
  void recogniseShape(List<Gesture> g) {
    for (Stroke s in state.strokes) {
      qpoints.addAll(s.strokePoints);
    }
    _gesture = _recognizer.recognize(Gesture(qpoints), g);
    qpoints = []; // reset after recognition
    print('Recognised as......$_gesture');
    _notifier.addWidget(_gesture);
  }

  void onTapDown(TapDownDetails details) {
    toggleIgnore();
  }
}
