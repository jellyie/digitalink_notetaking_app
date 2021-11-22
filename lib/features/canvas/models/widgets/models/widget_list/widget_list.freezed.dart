// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widget_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WidgetListTearOff {
  const _$WidgetListTearOff();

  _WidgetList call({required List<Widget> widgets, int? selectedIndex}) {
    return _WidgetList(
      widgets: widgets,
      selectedIndex: selectedIndex,
    );
  }
}

/// @nodoc
const $WidgetList = _$WidgetListTearOff();

/// @nodoc
mixin _$WidgetList {
  List<Widget> get widgets => throw _privateConstructorUsedError;
  int? get selectedIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WidgetListCopyWith<WidgetList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetListCopyWith<$Res> {
  factory $WidgetListCopyWith(
          WidgetList value, $Res Function(WidgetList) then) =
      _$WidgetListCopyWithImpl<$Res>;
  $Res call({List<Widget> widgets, int? selectedIndex});
}

/// @nodoc
class _$WidgetListCopyWithImpl<$Res> implements $WidgetListCopyWith<$Res> {
  _$WidgetListCopyWithImpl(this._value, this._then);

  final WidgetList _value;
  // ignore: unused_field
  final $Res Function(WidgetList) _then;

  @override
  $Res call({
    Object? widgets = freezed,
    Object? selectedIndex = freezed,
  }) {
    return _then(_value.copyWith(
      widgets: widgets == freezed
          ? _value.widgets
          : widgets // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      selectedIndex: selectedIndex == freezed
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$WidgetListCopyWith<$Res> implements $WidgetListCopyWith<$Res> {
  factory _$WidgetListCopyWith(
          _WidgetList value, $Res Function(_WidgetList) then) =
      __$WidgetListCopyWithImpl<$Res>;
  @override
  $Res call({List<Widget> widgets, int? selectedIndex});
}

/// @nodoc
class __$WidgetListCopyWithImpl<$Res> extends _$WidgetListCopyWithImpl<$Res>
    implements _$WidgetListCopyWith<$Res> {
  __$WidgetListCopyWithImpl(
      _WidgetList _value, $Res Function(_WidgetList) _then)
      : super(_value, (v) => _then(v as _WidgetList));

  @override
  _WidgetList get _value => super._value as _WidgetList;

  @override
  $Res call({
    Object? widgets = freezed,
    Object? selectedIndex = freezed,
  }) {
    return _then(_WidgetList(
      widgets: widgets == freezed
          ? _value.widgets
          : widgets // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      selectedIndex: selectedIndex == freezed
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_WidgetList extends _WidgetList with DiagnosticableTreeMixin {
  const _$_WidgetList({required this.widgets, this.selectedIndex}) : super._();

  @override
  final List<Widget> widgets;
  @override
  final int? selectedIndex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WidgetList(widgets: $widgets, selectedIndex: $selectedIndex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WidgetList'))
      ..add(DiagnosticsProperty('widgets', widgets))
      ..add(DiagnosticsProperty('selectedIndex', selectedIndex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetList &&
            const DeepCollectionEquality().equals(other.widgets, widgets) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(widgets), selectedIndex);

  @JsonKey(ignore: true)
  @override
  _$WidgetListCopyWith<_WidgetList> get copyWith =>
      __$WidgetListCopyWithImpl<_WidgetList>(this, _$identity);
}

abstract class _WidgetList extends WidgetList {
  const factory _WidgetList(
      {required List<Widget> widgets, int? selectedIndex}) = _$_WidgetList;
  const _WidgetList._() : super._();

  @override
  List<Widget> get widgets;
  @override
  int? get selectedIndex;
  @override
  @JsonKey(ignore: true)
  _$WidgetListCopyWith<_WidgetList> get copyWith =>
      throw _privateConstructorUsedError;
}
