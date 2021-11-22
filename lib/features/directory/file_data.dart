import 'package:flutter/material.dart';
import '../canvas/models/widgets/widget_data.dart';

class FileData extends ChangeNotifier {
  List<WidgetData> fileList = [];
  List<String> nameList = [];

  List getList() {
    return fileList;
  }

  WidgetData getWidgetData(int index) {
    return fileList[index];
  }

  String getName(int index) {
    return nameList[index];
  }

  void addNewFile(String name) {
    WidgetData newData = WidgetData();
    fileList.add(newData);
    nameList.add(name);
    notifyListeners();
  }
}
