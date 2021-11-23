import 'dart:async';

import 'package:flutter/material.dart';

import '../../../providers.dart';
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

  final oneSec = const Duration(seconds: 1);
  late Timer _timer;
  bool _timerInitialized = false;

  late WidgetNotifier _notifier;

  final GlobalKey _globalKey = GlobalKey();
  GlobalKey get globalkey => _globalKey;

  /// Used to switch between the Canvas layer and the WidgetListBuilder layer
  /// due to Stack terminating Hit Testing after the first widget (visually)
  /// on top of another widget in the same stack is hit
  bool ignore = false;
  CanvasState toggleIgnore() {
    String c = "Canvas Layer", w = "Widget Layer";
    SnackBar snackBar = SnackBar(
        content:
            Text((ignore) ? "You are now on the $c" : "You are now on the $w"));
    snackbarKey.currentState?.showSnackBar(snackBar);
    return state = state.copyWith(ignore: ignore = !ignore);
  }

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
      if (_timerInitialized == true) {
        _timer.cancel();
        _timerInitialized = false;
        debugPrint("new pen input, timer stops");
      }
    }
    state = state.copyWith(
      activeStroke: Stroke(strokePoints: [_getPoint(d.localPosition)]),
    );
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
      state = _completeStroke(state);
      _timerInitialized = true;
      _timer = Timer(const Duration(milliseconds: 1500), () {
        const SnackBar snackBar =
            SnackBar(content: Text("One sec, recognizing your input..."));
        snackbarKey.currentState?.showSnackBar(snackBar);
        if (_timerInitialized) {
          if (_notifier.selected) {
            recogniseText();
            clear();
          } else {
            recogniseShape(_trainingSet);
            clear();
          }
        }
      });
    }
  }

  /// Clear the state or reset the canvas
  CanvasState clear() {
    return state =
        CanvasState.gesture(canvas: const Canvas(strokes: []), ignore: ignore);
  }

  /// --------------------------------------------------------------------- ///
  /// ----------------- Handwriting to Text Recognition ------------------- ///
  /// --------------------------------------------------------------------- ///
  /// Return the value of the handwritten text as recognised string
  List<String> _candidatesList = [];
  Future<void> recogniseText() async {
    List<Offset> points = [];
    for (Stroke s in state.strokes) {
      List<Offset> _p = s.strokePoints.map((p) => p.asOffset).toList();
      points.addAll(_p);
    }

    try {
      if (points.isNotEmpty) {
        final candidates =
            await _digitalInkRecogniser.readText(points, _language);
        _recogniseText = (candidates.first).text;

        _candidatesList = [];
        // store the first 5 candidates
        for (int i = 0; i < 5; i++) {
          _candidatesList.add(candidates[i].text);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    SnackBar snackBar =
        SnackBar(content: Text("Text was recognized as $_recogniseText"));
    snackbarKey.currentState?.showSnackBar(snackBar);
    _notifier.updateWidgetData(_recogniseText);
    updateCandidateData(_candidatesList);
    debugPrint('Recognised as......$_recogniseText');
  }

  // For getting the candidatesList
  List<String> get candidatesList => _candidatesList;
  void updateCandidateData(List<String> c) {
    _candidatesList = c;
    //print(_candidatesList);
  }

  /// --------------------------------------------------------------------- ///
  /// -------------------------- Shapes Recognition ----------------------- ///
  /// --------------------------------------------------------------------- ///

  /// Return the value of the drawn shape as a string
  void recogniseShape(List<Gesture> g) {
    for (Stroke s in state.strokes) {
      qpoints.addAll(s.strokePoints);
    }
    _gesture = _recognizer.recognize(Gesture(qpoints), g);
    qpoints = []; // reset after recognition
    debugPrint('Recognised as......$_gesture');
    SnackBar snackBar =
        SnackBar(content: Text("Shape was recognized as... $_gesture"));
    snackbarKey.currentState?.showSnackBar(snackBar);
    _notifier.addWidget(_gesture);
  }
}
