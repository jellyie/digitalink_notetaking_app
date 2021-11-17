import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/q_dollar_recognizer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'stroke/stroke.dart';
import 'canvas/canvas.dart';
import 'state/canvas_state.dart';
import '../q_dollar_recognizer/point.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

/// This class interprets the raw data about the user's input
class CanvasNotifier extends StateNotifier<CanvasState> {
  CanvasNotifier({Canvas? canvas})
      : super(CanvasState.gesture(
          canvas: canvas ?? const Canvas(strokes: []),
        )) {
    state = CanvasState.gesture(
      canvas: canvas ?? const Canvas(strokes: []),
    );

    _languageModelManager.downloadModel(_language);
  }

  final GlobalKey _globalKey = GlobalKey();
  GlobalKey get globalkey => _globalKey;

  // Initiate digital ink recogniser
  final DigitalInkRecogniser _digitalInkRecogniser =
      GoogleMlKit.vision.digitalInkRecogniser();
  final LanguageModelManager _languageModelManager =
      GoogleMlKit.vision.languageModelManager();

  String _recogniseText = ' ';
  final String _language = 'zxx-Zsye-x-emoji';

  // Initiate gesture recogniser
  String _gesture = ' ';
  final QDollarRecognizer _recognizer = QDollarRecognizer();
  List<Point> qpoints = [];

  /// Returns the most recent Offset as a Point
  Point _getPoint(Offset o) {
    return Point(o.dx, o.dy);
  }

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
      state = _completeStroke(state);
    }
    for (Stroke s in state.strokes) {
      qpoints.addAll(s.strokePoints);
    }
  }

  void clear() {
    state = const CanvasState.gesture(canvas: Canvas(strokes: []));
  }

  Future<void> recgoniseText() async {
    List<Offset> points = [];
    for (Stroke s in state.strokes) {
      List<Offset> _p = s.strokePoints.map((p) => p.asOffset).toList();
      points.addAll(_p);
    }

    try {
      final candidates =
          await _digitalInkRecogniser.readText(points, _language);
      _recogniseText = "";
      for (final candidate in candidates) {
        _recogniseText += "\n ${candidate.text}";
      }
    } catch (e) {
      print(e.toString());
    }
    print('Recognised as......$_recogniseText');
  }

  void recogniseShape(List<Gesture> g) {
    _gesture = _recognizer.recognize(Gesture(qpoints), g);
    print('Recognised as......$_gesture');
  }
}
