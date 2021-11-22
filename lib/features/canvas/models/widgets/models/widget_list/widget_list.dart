import '../widget/widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'widget_list.freezed.dart';

@freezed
class WidgetList with _$WidgetList {
  const WidgetList._();
  const factory WidgetList(
      {required List<Widget> widgets, int? selectedIndex}) = _WidgetList;
}
