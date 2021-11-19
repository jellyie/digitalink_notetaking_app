import 'package:flutter/material.dart';
import 'widget_model.dart';

// For storing widget data and methods
class WidgetData extends ChangeNotifier {
  int _selectedNum = -1;
  List _allWidgetList = []; //typelist
  List _widgetContent = [];

  //update the currently selected widget number
  void updateSelectedNum(int newNum) {
    _selectedNum = newNum;
    //print(_selectedNum);
    notifyListeners();
  }

  //add a new widget
  void addNewWidget(WidgetType? newType) {
    _allWidgetList.add(newType);
    _widgetContent.add("");
    updateSelectedNum(_allWidgetList.length - 1);
  }

  //get the widget list
  List getWidgetList() {
    return _allWidgetList;
  }

  //get the length of the widget list
  int getListLength() {
    return _allWidgetList.length;
  }

  //get the type of the widget from the list
  WidgetType getWidgetType(int index) {
    return _allWidgetList[index];
  }

  //reorder the widgets
  void reorderWidgets(int oldIndex, int newIndex) {
    final tempType = _allWidgetList.removeAt(oldIndex);
    _allWidgetList.insert(newIndex, tempType);
    String tempContent = _widgetContent.removeAt(oldIndex);
    _widgetContent.insert(newIndex, tempContent);
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
      _widgetContent[_selectedNum] = content;
      notifyListeners();
    }
  }

  String getContent(int index) {
    return _widgetContent[index];
  }
}
