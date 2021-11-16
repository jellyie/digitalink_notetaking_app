// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stroke.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StrokeTearOff {
  const _$StrokeTearOff();

  _Stroke call({required List<Point> strokePoints}) {
    return _Stroke(
      strokePoints: strokePoints,
    );
  }
}

/// @nodoc
const $Stroke = _$StrokeTearOff();

/// @nodoc
mixin _$Stroke {
  List<Point> get strokePoints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StrokeCopyWith<Stroke> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrokeCopyWith<$Res> {
  factory $StrokeCopyWith(Stroke value, $Res Function(Stroke) then) =
      _$StrokeCopyWithImpl<$Res>;
  $Res call({List<Point> strokePoints});
}

/// @nodoc
class _$StrokeCopyWithImpl<$Res> implements $StrokeCopyWith<$Res> {
  _$StrokeCopyWithImpl(this._value, this._then);

  final Stroke _value;
  // ignore: unused_field
  final $Res Function(Stroke) _then;

  @override
  $Res call({
    Object? strokePoints = freezed,
  }) {
    return _then(_value.copyWith(
      strokePoints: strokePoints == freezed
          ? _value.strokePoints
          : strokePoints // ignore: cast_nullable_to_non_nullable
              as List<Point>,
    ));
  }
}

/// @nodoc
abstract class _$StrokeCopyWith<$Res> implements $StrokeCopyWith<$Res> {
  factory _$StrokeCopyWith(_Stroke value, $Res Function(_Stroke) then) =
      __$StrokeCopyWithImpl<$Res>;
  @override
  $Res call({List<Point> strokePoints});
}

/// @nodoc
class __$StrokeCopyWithImpl<$Res> extends _$StrokeCopyWithImpl<$Res>
    implements _$StrokeCopyWith<$Res> {
  __$StrokeCopyWithImpl(_Stroke _value, $Res Function(_Stroke) _then)
      : super(_value, (v) => _then(v as _Stroke));

  @override
  _Stroke get _value => super._value as _Stroke;

  @override
  $Res call({
    Object? strokePoints = freezed,
  }) {
    return _then(_Stroke(
      strokePoints: strokePoints == freezed
          ? _value.strokePoints
          : strokePoints // ignore: cast_nullable_to_non_nullable
              as List<Point>,
    ));
  }
}

/// @nodoc

class _$_Stroke with DiagnosticableTreeMixin implements _Stroke {
  const _$_Stroke({required this.strokePoints});

  @override
  final List<Point> strokePoints;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Stroke(strokePoints: $strokePoints)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Stroke'))
      ..add(DiagnosticsProperty('strokePoints', strokePoints));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Stroke &&
            const DeepCollectionEquality()
                .equals(other.strokePoints, strokePoints));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(strokePoints));

  @JsonKey(ignore: true)
  @override
  _$StrokeCopyWith<_Stroke> get copyWith =>
      __$StrokeCopyWithImpl<_Stroke>(this, _$identity);
}

abstract class _Stroke implements Stroke {
  const factory _Stroke({required List<Point> strokePoints}) = _$_Stroke;

  @override
  List<Point> get strokePoints;
  @override
  @JsonKey(ignore: true)
  _$StrokeCopyWith<_Stroke> get copyWith => throw _privateConstructorUsedError;
}
