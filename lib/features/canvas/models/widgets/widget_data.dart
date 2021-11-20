import 'package:flutter/material.dart';
import 'widget_model.dart';
import 'dart:io';

// For storing widget data and methods
class WidgetData extends ChangeNotifier {
  final Map<String, WidgetType?> gestureToType = {
    "SQUARE": WidgetType.heading,
    "BLOCKQUOTE": WidgetType.blockquote,
    "IMAGE": WidgetType.image
  };
  int _selectedNum = -1; // the selected widget index
  final List _allGestureList = [];

  /// {WidgetType? type, String content, param}
  final List _widgetDataList = [];

  //update the currently selected widget number
  void updateSelectedNum(int newNum) {
    _selectedNum = newNum;
    //print(_selectedNum);
    notifyListeners();
  }

  // update content
  void updateContent(String content, int index) {}

  // update param
  void updateParam(int newParam, int index) {
    _widgetDataList[index]["param"] = newParam;
    notifyListeners();
  }

  //add a new widget
  void addNewWidget(WidgetType? newType) {
    _widgetDataList.add({"type": newType, "content": "", "param": 0});
    updateSelectedNum(_widgetDataList.length - 1);
  }

  // for command duplicate
  void insertNewWidget() {
    if (_widgetDataList.isNotEmpty) {
      final data = getWidgetData(_selectedNum);
      _widgetDataList.insert(_selectedNum, data);
      updateSelectedNum(_selectedNum + 1);
    }
  }

  // for command erase
  void deleteWidget() {
    if (_widgetDataList.isNotEmpty) {
      _widgetDataList.removeAt(_selectedNum);
      if (_selectedNum == _widgetDataList.length) {
        updateSelectedNum(_selectedNum - 1);
      } else {
        updateSelectedNum(_selectedNum);
      }
    }
  }

  //for Images: set image
  void setImagePath(String path, int index) {
    _widgetDataList[index]["path"] = path;
    updateParam(1, index);
  }

  // for Images: get image
  String getImagePath(int index) {
    return _widgetDataList[index]["path"];
  }

  //get the length of the widget list
  int getListLength() {
    return _widgetDataList.length;
  }

  Map getWidgetData(int index) {
    return _widgetDataList[index];
  }

  //get the type of the widget from the list
  WidgetType getWidgetType(int index) {
    return _widgetDataList[index]["type"];
  }

  int getParam(int index) {
    return _widgetDataList[index]["param"];
  }

  //add a new gesture
  void addNewGesture(String gestureName) {
    _allGestureList.add(gestureName);

    // for components
    if (gestureToType.containsKey(gestureName)) {
      addNewWidget(gestureToType[gestureName]);
    }

    // for commands
    if (gestureName == "DUPLICATE") {
      if (_widgetDataList.isNotEmpty) {
        insertNewWidget();
      }
    }
    if (gestureName == "ERASE") {
      if (_widgetDataList.isNotEmpty) {
        deleteWidget();
      }
    }
  }

  //reorder the widgets
  void reorderWidgets(int oldIndex, int newIndex) {
    final tempType = _widgetDataList.removeAt(oldIndex);
    _widgetDataList.insert(newIndex, tempType);
    updateSelectedNum(newIndex);
  }

  //is selected or not
  bool isSelected(int index) {
    if (index == _selectedNum) {
      return true;
    } else {
      return false;
    }
  }

  //modify content
  void editContent(String content) {
    if (_selectedNum != -1) {
      _widgetDataList[_selectedNum]["content"] = content;
      notifyListeners();
    }
  }

  String getContent(int index) {
    return _widgetDataList[index]["content"];
  }
}
