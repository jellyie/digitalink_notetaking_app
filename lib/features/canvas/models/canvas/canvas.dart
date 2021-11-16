import '../stroke/stroke.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'canvas.freezed.dart';

/// This class holds the list of Strokes on the Canvas
@freezed
class Canvas with _$Canvas {
  const factory Canvas({required List<Stroke> strokes}) = _Canvas;
}
