import '../../q_dollar_recognizer/point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'stroke.freezed.dart';

/// This class holds the user input or touch points as a list of Points
@freezed
class Stroke with _$Stroke {
  const factory Stroke({required List<Point> strokePoints}) = _Stroke;
}
