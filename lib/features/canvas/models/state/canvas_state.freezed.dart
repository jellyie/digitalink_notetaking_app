// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'canvas_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CanvasStateTearOff {
  const _$CanvasStateTearOff();

  GestureMode gesture({required Canvas canvas, Stroke? activeStroke}) {
    return GestureMode(
      canvas: canvas,
      activeStroke: activeStroke,
    );
  }

  HandwritingMode handwriting({required Canvas canvas, Stroke? activeStroke}) {
    return HandwritingMode(
      canvas: canvas,
      activeStroke: activeStroke,
    );
  }
}

/// @nodoc
const $CanvasState = _$CanvasStateTearOff();

/// @nodoc
mixin _$CanvasState {
  Canvas get canvas => throw _privateConstructorUsedError;
  Stroke? get activeStroke => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Canvas canvas, Stroke? activeStroke) gesture,
    required TResult Function(Canvas canvas, Stroke? activeStroke) handwriting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Canvas canvas, Stroke? activeStroke)? gesture,
    TResult Function(Canvas canvas, Stroke? activeStroke)? handwriting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Canvas canvas, Stroke? activeStroke)? gesture,
    TResult Function(Canvas canvas, Stroke? activeStroke)? handwriting,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GestureMode value) gesture,
    required TResult Function(HandwritingMode value) handwriting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GestureMode value)? gesture,
    TResult Function(HandwritingMode value)? handwriting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GestureMode value)? gesture,
    TResult Function(HandwritingMode value)? handwriting,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CanvasStateCopyWith<CanvasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasStateCopyWith<$Res> {
  factory $CanvasStateCopyWith(
          CanvasState value, $Res Function(CanvasState) then) =
      _$CanvasStateCopyWithImpl<$Res>;
  $Res call({Canvas canvas, Stroke? activeStroke});

  $CanvasCopyWith<$Res> get canvas;
  $StrokeCopyWith<$Res>? get activeStroke;
}

/// @nodoc
class _$CanvasStateCopyWithImpl<$Res> implements $CanvasStateCopyWith<$Res> {
  _$CanvasStateCopyWithImpl(this._value, this._then);

  final CanvasState _value;
  // ignore: unused_field
  final $Res Function(CanvasState) _then;

  @override
  $Res call({
    Object? canvas = freezed,
    Object? activeStroke = freezed,
  }) {
    return _then(_value.copyWith(
      canvas: canvas == freezed
          ? _value.canvas
          : canvas // ignore: cast_nullable_to_non_nullable
              as Canvas,
      activeStroke: activeStroke == freezed
          ? _value.activeStroke
          : activeStroke // ignore: cast_nullable_to_non_nullable
              as Stroke?,
    ));
  }

  @override
  $CanvasCopyWith<$Res> get canvas {
    return $CanvasCopyWith<$Res>(_value.canvas, (value) {
      return _then(_value.copyWith(canvas: value));
    });
  }

  @override
  $StrokeCopyWith<$Res>? get activeStroke {
    if (_value.activeStroke == null) {
      return null;
    }

    return $StrokeCopyWith<$Res>(_value.activeStroke!, (value) {
      return _then(_value.copyWith(activeStroke: value));
    });
  }
}

/// @nodoc
abstract class $GestureModeCopyWith<$Res>
    implements $CanvasStateCopyWith<$Res> {
  factory $GestureModeCopyWith(
          GestureMode value, $Res Function(GestureMode) then) =
      _$GestureModeCopyWithImpl<$Res>;
  @override
  $Res call({Canvas canvas, Stroke? activeStroke});

  @override
  $CanvasCopyWith<$Res> get canvas;
  @override
  $StrokeCopyWith<$Res>? get activeStroke;
}

/// @nodoc
class _$GestureModeCopyWithImpl<$Res> extends _$CanvasStateCopyWithImpl<$Res>
    implements $GestureModeCopyWith<$Res> {
  _$GestureModeCopyWithImpl(
      GestureMode _value, $Res Function(GestureMode) _then)
      : super(_value, (v) => _then(v as GestureMode));

  @override
  GestureMode get _value => super._value as GestureMode;

  @override
  $Res call({
    Object? canvas = freezed,
    Object? activeStroke = freezed,
  }) {
    return _then(GestureMode(
      canvas: canvas == freezed
          ? _value.canvas
          : canvas // ignore: cast_nullable_to_non_nullable
              as Canvas,
      activeStroke: activeStroke == freezed
          ? _value.activeStroke
          : activeStroke // ignore: cast_nullable_to_non_nullable
              as Stroke?,
    ));
  }
}

/// @nodoc

class _$GestureMode extends GestureMode with DiagnosticableTreeMixin {
  const _$GestureMode({required this.canvas, this.activeStroke}) : super._();

  @override
  final Canvas canvas;
  @override
  final Stroke? activeStroke;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CanvasState.gesture(canvas: $canvas, activeStroke: $activeStroke)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CanvasState.gesture'))
      ..add(DiagnosticsProperty('canvas', canvas))
      ..add(DiagnosticsProperty('activeStroke', activeStroke));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GestureMode &&
            (identical(other.canvas, canvas) || other.canvas == canvas) &&
            (identical(other.activeStroke, activeStroke) ||
                other.activeStroke == activeStroke));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canvas, activeStroke);

  @JsonKey(ignore: true)
  @override
  $GestureModeCopyWith<GestureMode> get copyWith =>
      _$GestureModeCopyWithImpl<GestureMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Canvas canvas, Stroke? activeStroke) gesture,
    required TResult Function(Canvas canvas, Stroke? activeStroke) handwriting,
  }) {
    return gesture(canvas, activeStroke);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Canvas canvas, Stroke? activeStroke)? gesture,
    TResult Function(Canvas canvas, Stroke? activeStroke)? handwriting,
  }) {
    return gesture?.call(canvas, activeStroke);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Canvas canvas, Stroke? activeStroke)? gesture,
    TResult Function(Canvas canvas, Stroke? activeStroke)? handwriting,
    required TResult orElse(),
  }) {
    if (gesture != null) {
      return gesture(canvas, activeStroke);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GestureMode value) gesture,
    required TResult Function(HandwritingMode value) handwriting,
  }) {
    return gesture(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GestureMode value)? gesture,
    TResult Function(HandwritingMode value)? handwriting,
  }) {
    return gesture?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GestureMode value)? gesture,
    TResult Function(HandwritingMode value)? handwriting,
    required TResult orElse(),
  }) {
    if (gesture != null) {
      return gesture(this);
    }
    return orElse();
  }
}

abstract class GestureMode extends CanvasState {
  const factory GestureMode({required Canvas canvas, Stroke? activeStroke}) =
      _$GestureMode;
  const GestureMode._() : super._();

  @override
  Canvas get canvas;
  @override
  Stroke? get activeStroke;
  @override
  @JsonKey(ignore: true)
  $GestureModeCopyWith<GestureMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandwritingModeCopyWith<$Res>
    implements $CanvasStateCopyWith<$Res> {
  factory $HandwritingModeCopyWith(
          HandwritingMode value, $Res Function(HandwritingMode) then) =
      _$HandwritingModeCopyWithImpl<$Res>;
  @override
  $Res call({Canvas canvas, Stroke? activeStroke});

  @override
  $CanvasCopyWith<$Res> get canvas;
  @override
  $StrokeCopyWith<$Res>? get activeStroke;
}

/// @nodoc
class _$HandwritingModeCopyWithImpl<$Res>
    extends _$CanvasStateCopyWithImpl<$Res>
    implements $HandwritingModeCopyWith<$Res> {
  _$HandwritingModeCopyWithImpl(
      HandwritingMode _value, $Res Function(HandwritingMode) _then)
      : super(_value, (v) => _then(v as HandwritingMode));

  @override
  HandwritingMode get _value => super._value as HandwritingMode;

  @override
  $Res call({
    Object? canvas = freezed,
    Object? activeStroke = freezed,
  }) {
    return _then(HandwritingMode(
      canvas: canvas == freezed
          ? _value.canvas
          : canvas // ignore: cast_nullable_to_non_nullable
              as Canvas,
      activeStroke: activeStroke == freezed
          ? _value.activeStroke
          : activeStroke // ignore: cast_nullable_to_non_nullable
              as Stroke?,
    ));
  }
}

/// @nodoc

class _$HandwritingMode extends HandwritingMode with DiagnosticableTreeMixin {
  const _$HandwritingMode({required this.canvas, this.activeStroke})
      : super._();

  @override
  final Canvas canvas;
  @override
  final Stroke? activeStroke;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CanvasState.handwriting(canvas: $canvas, activeStroke: $activeStroke)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CanvasState.handwriting'))
      ..add(DiagnosticsProperty('canvas', canvas))
      ..add(DiagnosticsProperty('activeStroke', activeStroke));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HandwritingMode &&
            (identical(other.canvas, canvas) || other.canvas == canvas) &&
            (identical(other.activeStroke, activeStroke) ||
                other.activeStroke == activeStroke));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canvas, activeStroke);

  @JsonKey(ignore: true)
  @override
  $HandwritingModeCopyWith<HandwritingMode> get copyWith =>
      _$HandwritingModeCopyWithImpl<HandwritingMode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Canvas canvas, Stroke? activeStroke) gesture,
    required TResult Function(Canvas canvas, Stroke? activeStroke) handwriting,
  }) {
    return handwriting(canvas, activeStroke);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Canvas canvas, Stroke? activeStroke)? gesture,
    TResult Function(Canvas canvas, Stroke? activeStroke)? handwriting,
  }) {
    return handwriting?.call(canvas, activeStroke);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Canvas canvas, Stroke? activeStroke)? gesture,
    TResult Function(Canvas canvas, Stroke? activeStroke)? handwriting,
    required TResult orElse(),
  }) {
    if (handwriting != null) {
      return handwriting(canvas, activeStroke);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GestureMode value) gesture,
    required TResult Function(HandwritingMode value) handwriting,
  }) {
    return handwriting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(GestureMode value)? gesture,
    TResult Function(HandwritingMode value)? handwriting,
  }) {
    return handwriting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GestureMode value)? gesture,
    TResult Function(HandwritingMode value)? handwriting,
    required TResult orElse(),
  }) {
    if (handwriting != null) {
      return handwriting(this);
    }
    return orElse();
  }
}

abstract class HandwritingMode extends CanvasState {
  const factory HandwritingMode(
      {required Canvas canvas, Stroke? activeStroke}) = _$HandwritingMode;
  const HandwritingMode._() : super._();

  @override
  Canvas get canvas;
  @override
  Stroke? get activeStroke;
  @override
  @JsonKey(ignore: true)
  $HandwritingModeCopyWith<HandwritingMode> get copyWith =>
      throw _privateConstructorUsedError;
}
