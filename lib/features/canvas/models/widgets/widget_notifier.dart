import 'models/widget/widget.dart' as our;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/widget_list/widget_list.dart';

class WidgetNotifier extends StateNotifier<WidgetList> {
  WidgetNotifier({WidgetList? widgetList})
      : super(
          widgetList ?? const WidgetList(widgets: [], selectedIndex: null),
        ) {
    state = widgetList ??
        WidgetList(widgets: [
          const our.Widget.paragraph(data: "Test paragraph"),
          const our.Widget.heading(data: "Test Heading")
        ], selectedIndex: selectedIndex);
  }

  bool onHover = false;

  /// Variables to support selection
  bool selected = false;
  int? selectedIndex;
  our.Widget? selectedWidget;

  void setSelectedIndex(int i) =>
      state.copyWith(selectedIndex: selectedIndex = i);

  WidgetList toggleSelectedWidget() {
    selectedWidget = state.widgets[selectedIndex as int]
        .copyWith(selected: selected = !selected);
    return deleteAndReplace(selectedWidget as our.Widget);
  }

  /// Returns the length of the WidgetList
  int get length => state.widgets.length;

  /// Returns the type of widget as a String where "type" refers to the Union object Widget,
  /// not the WidgetType parameter within the Union object Widget
  // String _parseToString(our.Widget widget) {
  //   String type = widget.toString().split('(').first;
  //   type = (type.split('.').last).toUpperCase();
  //   return type;
  // }

  /// Reorders the widgets according to the oldIndex and newIndex params
  void reorderWidgets(int oldIndex, int newIndex) {
    List<our.Widget> tempList = List.from(state.widgets);
    final element = tempList.removeAt(oldIndex);
    tempList.insert(newIndex, element);
    state = state.copyWith(widgets: tempList);
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
        return state = state.copyWith(
            widgets: [...state.widgets, const our.Widget.paragraph()]);
      case "HEADING":
        return state = state
            .copyWith(widgets: [...state.widgets, const our.Widget.heading()]);
      case "BLOCKQUOTE":
        return state = state.copyWith(
            widgets: [...state.widgets, const our.Widget.blockquote()]);
      case "IMAGE":
        return state = state
            .copyWith(widgets: [...state.widgets, const our.Widget.image()]);
      case "TABLE":
        return state = state
            .copyWith(widgets: [...state.widgets, const our.Widget.table()]);
      case "LIST":
        return state = state.copyWith(
            widgets: [...state.widgets, const our.Widget.bulletedList()]);
      case "BOLD":
        widget = const our.Widget.bold()
            .copyWith(data: (selectedWidget as our.Widget).data);
        return deleteAndReplace(widget);
      case "ITALIC":
        widget = const our.Widget.italicize()
            .copyWith(data: (selectedWidget as our.Widget).data);
        return deleteAndReplace(widget);
      case "NEWLINE":
        final String oldData = (selectedWidget as our.Widget).data.toString();
        widget = (selectedWidget as our.Widget)
            .copyWith(data: '$oldData \n new line');
        return deleteAndReplace(widget);
      case "DUPLICATE":
        widget = (selectedWidget as our.Widget).copyWith(selected: false);
        return state = state.copyWith(widgets: [...state.widgets, widget]);
      case "ERASE":
        return deleteWidget();
    }

    // Return the current WidgetList if gesture is not valid
    print('Not a gesture');
    return state;
  }

  /// Appends the new data to a copy of the widget at the selected index
  WidgetList updateWidgetData(String newData) {
    // Returns the current WidgetList if there is no selected index
    if (selectedIndex == null) return state;

    final updatedWidget =
        (selectedWidget as our.Widget).copyWith(data: newData);
    return deleteAndReplace(updatedWidget);
  }

  /// Removes the widget at the selected index
  WidgetList deleteWidget() {
    List<our.Widget> tempList = List.from(state.widgets);
    tempList.removeAt(selectedIndex as int);
    return state = state.copyWith(widgets: tempList);
  }

  /// Removes the widget at the selected index and replaces it with the specified widget
  WidgetList deleteAndReplace(our.Widget widget) {
    List<our.Widget> tempList = List.from(state.widgets);
    tempList.removeAt(selectedIndex as int);
    tempList.insert(selectedIndex as int, widget);
    return state = state.copyWith(widgets: tempList);
  }

  /// For text candidates
  List<String> candidatesList = [];
  void updateCandidateData(List<String> c) {
    candidatesList = c;
    print(candidatesList);
  }

  // For getting the candidatesList
  List<String> getCandidateData() {
    return candidatesList;
  }
}
