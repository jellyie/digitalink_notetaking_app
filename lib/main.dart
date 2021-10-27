import 'package:digitalink_notetaking_app/features/canvas/ui/canvas_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Digital Ink-Based Notetaking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CanvasScreen(),
    );
  }
}
