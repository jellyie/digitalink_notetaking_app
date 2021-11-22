import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../canvas/models/canvas_notifier.dart';
import '../canvas/models/state/canvas_state.dart';
import '../canvas/models/widgets/models/widget_list/widget_list.dart';
import '../canvas/models/widgets/widget_notifier.dart';

class FileData extends ChangeNotifier {
  List<StateNotifierProvider<CanvasNotifier, CanvasState>> canvasNotifierList =
      [];
  List<StateNotifierProvider<WidgetNotifier, WidgetList>> widgetNotifierList =
      [];
  List<String> nameList = [];

  String getName(int index) {
    return nameList[index];
  }

  int getLength() {
    return nameList.length;
  }

  StateNotifierProvider<CanvasNotifier, CanvasState> getCanvasNotifierProvider(
      int index) {
    return canvasNotifierList[index];
  }

  StateNotifierProvider<WidgetNotifier, WidgetList> getWidgetNotifierProvider(
      int index) {
    return widgetNotifierList[index];
  }

  void addNewFile(String name) {
    // canvasNotifierList
    final canvasNotifierProvider =
        StateNotifierProvider<CanvasNotifier, CanvasState>(
            (ref) => CanvasNotifier());
    canvasNotifierList.add(canvasNotifierProvider);

    //widgetNotifierList
    final widgetNotifierProvider =
        StateNotifierProvider<WidgetNotifier, WidgetList>(
            (ref) => WidgetNotifier());
    widgetNotifierList.add(widgetNotifierProvider);

    nameList.add(name);

    notifyListeners();
  }
}
