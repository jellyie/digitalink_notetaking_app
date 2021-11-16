// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'canvas.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CanvasTearOff {
  const _$CanvasTearOff();

  _Canvas call({required List<Stroke> strokes}) {
    return _Canvas(
      strokes: strokes,
    );
  }
}

/// @nodoc
const $Canvas = _$CanvasTearOff();

/// @nodoc
mixin _$Canvas {
  List<Stroke> get strokes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CanvasCopyWith<Canvas> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasCopyWith<$Res> {
  factory $CanvasCopyWith(Canvas value, $Res Function(Canvas) then) =
      _$CanvasCopyWithImpl<$Res>;
  $Res call({List<Stroke> strokes});
}

/// @nodoc
class _$CanvasCopyWithImpl<$Res> implements $CanvasCopyWith<$Res> {
  _$CanvasCopyWithImpl(this._value, this._then);

  final Canvas _value;
  // ignore: unused_field
  final $Res Function(Canvas) _then;

  @override
  $Res call({
    Object? strokes = freezed,
  }) {
    return _then(_value.copyWith(
      strokes: strokes == freezed
          ? _value.strokes
          : strokes // ignore: cast_nullable_to_non_nullable
              as List<Stroke>,
    ));
  }
}

/// @nodoc
abstract class _$CanvasCopyWith<$Res> implements $CanvasCopyWith<$Res> {
  factory _$CanvasCopyWith(_Canvas value, $Res Function(_Canvas) then) =
      __$CanvasCopyWithImpl<$Res>;
  @override
  $Res call({List<Stroke> strokes});
}

/// @nodoc
class __$CanvasCopyWithImpl<$Res> extends _$CanvasCopyWithImpl<$Res>
    implements _$CanvasCopyWith<$Res> {
  __$CanvasCopyWithImpl(_Canvas _value, $Res Function(_Canvas) _then)
      : super(_value, (v) => _then(v as _Canvas));

  @override
  _Canvas get _value => super._value as _Canvas;

  @override
  $Res call({
    Object? strokes = freezed,
  }) {
    return _then(_Canvas(
      strokes: strokes == freezed
          ? _value.strokes
          : strokes // ignore: cast_nullable_to_non_nullable
              as List<Stroke>,
    ));
  }
}

/// @nodoc

class _$_Canvas with DiagnosticableTreeMixin implements _Canvas {
  const _$_Canvas({required this.strokes});

  @override
  final List<Stroke> strokes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Canvas(strokes: $strokes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Canvas'))
      ..add(DiagnosticsProperty('strokes', strokes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Canvas &&
            const DeepCollectionEquality().equals(other.strokes, strokes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(strokes));

  @JsonKey(ignore: true)
  @override
  _$CanvasCopyWith<_Canvas> get copyWith =>
      __$CanvasCopyWithImpl<_Canvas>(this, _$identity);
}

abstract class _Canvas implements Canvas {
  const factory _Canvas({required List<Stroke> strokes}) = _$_Canvas;

  @override
  List<Stroke> get strokes;
  @override
  @JsonKey(ignore: true)
  _$CanvasCopyWith<_Canvas> get copyWith => throw _privateConstructorUsedError;
}
