import 'models/widget/widget.dart' as our;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/widget/widget.dart';
import 'models/widget_list/widget_list.dart';

class WidgetNotifier extends StateNotifier<WidgetList> {
  WidgetNotifier({WidgetList? widgetList})
      : super(
          widgetList ?? const WidgetList(widgets: []),
        ) {
    state = widgetList ??
        const WidgetList(widgets: [
          our.Widget.paragraph(data: "Test paragraph"),
          our.Widget.heading(data: "Test Heading")
        ]);
  }

  bool onHover = false;

  int? selectedIndex;

  void setSelectedIndex(int i) => selectedIndex = i;

  our.Widget getSelectedWidget() {
    return state.widgets[selectedIndex as int];
  }

  /// Returns the length of the WidgetList
  int get length => state.widgets.length;

  /// Returns the type of widget as a String where "type" refers to the Union object Widget,
  /// not the WidgetType parameter within the Union object Widget
  String _parseToString(our.Widget widget) {
    String type = widget.toString().split('(').first;
    type = (type.split('.').last).toUpperCase();
    return type;
  }

  /// Reorders the widgets according to the oldIndex and newIndex params
  void reorderWidgets(int oldIndex, int newIndex) {
    List<our.Widget> tempList = List.from(state.widgets);
    final element = tempList.removeAt(oldIndex);
    tempList.insert(newIndex, element);
    print(tempList);
    state = state.copyWith(widgets: tempList);
    print(state);
    print('reorder');
  }

  /// Returns a copy of the WidgetList with the new widget appended
  WidgetList addWidget(String gesture) {
    // Returns the current WidgetList if the gesture is empty
    if (gesture.isEmpty) return state;

    // Check if the gesture is a valid gesture
    final our.Widget widget;

    // Match the new widget to the correct gesture and add it to the WidgetList
    switch (gesture) {
      case "PARAGRAPH":
        widget = const our.Widget.paragraph();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "HEADING":
        widget = const our.Widget.heading();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "BLOCKQUOTE":
        widget = const our.Widget.blockquote();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "IMAGE":
        widget = const our.Widget.image();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "TABLE":
        widget = const our.Widget.table();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "LIST":
        widget = const our.Widget.bulletedList();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "BOLD":
        widget = const our.Widget.bold();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "ITALICIZE":
        widget = const our.Widget.italicize();
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "DUPLICATE":
        // Duplicate
        return state;
    }

    // Return the current WidgetList if gesture is not valid
    print('Not a gesture');
    return state;
  }

  /// Appends the new data to a copy of the widget at the specified index
  WidgetList updateWidgetData(String newData) {
    // Returns the current WidgetList if the index is null
    // if (selectedIndex != null) return state;
    if (state.widgets[selectedIndex as int].type == WidgetType.command) {
      return state;
    }
    List<our.Widget> tempList = List.from(state.widgets);
    final updatedWidget = getSelectedWidget().copyWith(data: newData);
    print('update widget to => $updatedWidget');
    tempList.removeAt(selectedIndex as int);
    tempList.insert(selectedIndex as int, updatedWidget);
    return state = state.copyWith(widgets: tempList);
  }

  /// Removes the widget at the specified index
  WidgetList deleteWidget() {
    print(selectedIndex);
    List<our.Widget> tempList = List.from(state.widgets);
    tempList.removeAt(selectedIndex as int);
    return state = state.copyWith(widgets: tempList);
  }
}
