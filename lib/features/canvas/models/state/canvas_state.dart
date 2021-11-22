import 'package:digitalink_notetaking_app/features/canvas/ui/components/widget_list_builder.dart';

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
    required WidgetListBuilder widgetListBuilder,
  }) = HandwritingMode;

  // Return a List of Strokes
  List<Stroke> get strokes => map(
      gesture: (g) => g.activeStroke == null
          ? canvas.strokes
          : [...canvas.strokes, g.activeStroke!],
      handwriting: (h) => []);
}
