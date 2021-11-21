import 'dart:math';

import 'package:flutter/material.dart';
import 'widget_model.dart';

// For storing widget data and methods
class WidgetData extends ChangeNotifier {
  // ------------------------------------------------------------------------//
  // -------------- initializations -----------------------------------------//
  // ------------------------------------------------------------------------//
  final Map<String, WidgetType?> gestureToType = {
    "SQUARE": WidgetType.heading,
    "BLOCKQUOTE": WidgetType.blockquote,
    "IMAGE": WidgetType.image,
    "TABLE": WidgetType.table,
    "LIST": WidgetType.bulletlist,
  };

  int _selectedNum = -1; // the selected widget index
  final List _allGestureList = [];

  /// { WidgetType? type, String content, param, (optional) addtional info }
  /// Heading: "param": heading style
  /// Image: "path": String path (when param ==1)
  /// Table: "table": List[][] cell (when param == 1)
  /// List:  "list": List[] listInfo (when param == 1)
  final List _widgetDataList = [];

  // ------------------------------------------------------------------------//
  // -------------- Update methods ------------------------------------------//
  // ------------------------------------------------------------------------//
  // update the currently selected widget index
  void updateSelectedNum(int newNum) {
    _selectedNum = newNum;
    //print(_selectedNum);
    notifyListeners();
  }

  // update content
  void updateContent(String content, int index) {
    if (_selectedNum != -1) {
      _widgetDataList[index]["content"] = content;
      notifyListeners();
    }
  }

  // update param
  void updateParam(int newParam, int index) {
    _widgetDataList[index]["param"] = newParam;
    notifyListeners();
  }

  // reorder the widgets
  void reorderWidgets(int oldIndex, int newIndex) {
    final tempType = _widgetDataList.removeAt(oldIndex);
    _widgetDataList.insert(newIndex, tempType);
    updateSelectedNum(newIndex);
  }

  // ------------------------------------------------------------------------//
  // -------------- Commands (duplicate and erase) --------------------------//
  // ------------------------------------------------------------------------//
  // DUPLICATE
  void duplicateWidget() {
    if (_widgetDataList.isNotEmpty) {
      final data = getWidgetData(_selectedNum);
      _widgetDataList.insert(_selectedNum, data);
      updateSelectedNum(_selectedNum + 1);
    }
  }

  // ERASE
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

  // ------------------------------------------------------------------------//
  // -------------- Specific widget gets and sets ---------------------------//
  // -------------- Image, table, bullet list -------------------------------//
  // ------------------------------------------------------------------------//
  //for Image: set image
  void setImagePath(String path, int index) {
    _widgetDataList[index]["path"] = path;
    updateParam(1, index);
  }

  // for Image: get image
  String getImagePath(int index) {
    return _widgetDataList[index]["path"];
  }

  // for Table: get table
  List<List<String>> getTable(int index) {
    return _widgetDataList[index]["table"];
  }

  // for Table: set table
  void setTable(int index, List<List<String>> tableList) {
    _widgetDataList[index]["table"] = tableList;
    notifyListeners();
  }

  // for List: get list
  List getList(int index) {
    return _widgetDataList[index]["list"];
  }

  // for List: add bullet point
  void addBulletPoint(int index, int subIndex) {
    List bulletList = _widgetDataList[index]['list'];
    bulletList.insert(subIndex + 1, "bullet point");
    _widgetDataList[index]['list'] = bulletList;
    notifyListeners();
  }

  // for List: delete bullet point
  void deleteBulletPoint(int index, int subIndex) {
    List bulletList = _widgetDataList[index]['list'];
    if (bulletList.length == 1) {
      // delete the widget
      deleteWidget();
    } else {
      // delete the bullet point
      bulletList.removeAt(subIndex);
      _widgetDataList[index]['list'] = bulletList;
    }
    notifyListeners();
  }

  // ------------------------------------------------------------------------//
  // -------------- General widget gets -------------------------------------//
  // ------------------------------------------------------------------------//
  // get the length of the widget list
  int getListLength() {
    return _widgetDataList.length;
  }

  // get the data {} of the specific widget
  Map getWidgetData(int index) {
    return _widgetDataList[index];
  }

  // get the type of the widget from the list
  WidgetType getWidgetType(int index) {
    return _widgetDataList[index]["type"];
  }

  // get the content of the widget
  String getContent(int index) {
    return _widgetDataList[index]["content"];
  }

  // get the param
  int getParam(int index) {
    return _widgetDataList[index]["param"];
  }

  // is selected or not
  bool isSelected(int index) {
    if (index == _selectedNum) {
      return true;
    } else {
      return false;
    }
  }

  // ------------------------------------------------------------------------//
  // -------------- Add methods ---------------------------------------------//
  // ------------------------------------------------------------------------//
  // add a new widget
  void addNewWidget(WidgetType? newType) {
    switch (newType) {
      case (WidgetType.bulletlist):
        {
          // Initialize the bullet list
          _widgetDataList.add({
            "type": newType,
            "content": "",
            "param": 0,
            "list": ["bullet point"]
          });
          break;
        }
      case (WidgetType.table):
        {
          // Initialize the table
          _widgetDataList.add({
            "type": newType,
            "content": "",
            "param": 0,
            "table": [
              ["cell"],
            ]
          });
          break;
        }
      default:
        {
          _widgetDataList.add({"type": newType, "content": "", "param": 0});
        }
    }
    updateSelectedNum(_widgetDataList.length - 1);
  }

  // add a new gesture
  void addNewGesture(String gestureName) {
    _allGestureList.add(gestureName);

    // for components
    if (gestureToType.containsKey(gestureName)) {
      addNewWidget(gestureToType[gestureName]);
    }

    // for commands
    if (gestureName == "DUPLICATE") {
      if (_widgetDataList.isNotEmpty) {
        duplicateWidget();
      }
    }
    if (gestureName == "ERASE") {
      if (_widgetDataList.isNotEmpty) {
        deleteWidget();
      }
    }
  }
}
