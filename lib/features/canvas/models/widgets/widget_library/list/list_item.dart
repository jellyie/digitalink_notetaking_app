import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

class ListItem {
  final _listItems = [];
  UnmodifiableListView get listItems => UnmodifiableListView(_listItems);
}
