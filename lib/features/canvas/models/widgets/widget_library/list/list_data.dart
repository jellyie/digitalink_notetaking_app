import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_library/list/list_item.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ListData extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<ListItem> _items = [
    ListItem(data: 'Example list'),
    ListItem(data: 'Another list item')
  ];

  UnmodifiableListView<ListItem> get items => UnmodifiableListView(_items);

  int get length => _items.length;

  void addItem(String newData) {
    _items.add(ListItem(data: newData));
  }

  void updateItem(String newData, int index) {
    _items.insert(index, _items.removeAt(index));
  }

  void deleteItem(ListItem item) {
    _items.remove(item);
  }
}
