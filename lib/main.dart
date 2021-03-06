import 'package:digitalink_notetaking_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/directory/directory_ui.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      title: 'A Digital Ink-Based Notetaking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DirectoryUI(),
    );
  }
}
