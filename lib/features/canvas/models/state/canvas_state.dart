import '../canvas/canvas.dart';
import '../stroke/stroke.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'canvas_state.freezed.dart';

/// This class defines a custom state for the Canvas
@freezed
class CanvasState with _$CanvasState {
  const CanvasState._();

  const factory CanvasState.gesture({
    required Canvas canvas,
    Stroke? activeStroke,
  }) = GestureMode;

  const factory CanvasState.handwriting({
    required Canvas canvas,
    Stroke? activeStroke,
  }) = HandwritingMode;

  // Return a List of Strokes
  List<Stroke> get strokes => map(
      gesture: (g) => g.activeStroke == null
          ? canvas.strokes
          : [...canvas.strokes, g.activeStroke!],
      handwriting: (h) => h.canvas.strokes);
}
