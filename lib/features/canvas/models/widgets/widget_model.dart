import 'package:flutter/material.dart';

enum WidgetType {
  command,
  component,
  paragraph, // Component (8)
  heading,
  blockquote,
  bold,
  italicize,
  image,
  table,
  bulletlist,
  duplicate, // Command (4)
  erase,
  split,
  newline
}

class WidgetModel {
  final String data;

  WidgetModel({required this.data});

  final Map<WidgetType, dynamic> _baseWidgetModel = {
    WidgetType.heading: Heading.widget(content: 'content'),
    WidgetType.paragraph: Paragraph.widget(content: 'content'),
    WidgetType.blockquote: Blockquote.widget(quote: 'quote'),
    // add other gestures as completed
  };

  Map<WidgetType, dynamic> get _widgetModel =>
      Map.unmodifiable(_baseWidgetModel);
}

class Heading {
  const Heading._();
  static const String _id = 'HEADING';

  static get id => _id;

  // Returns Text with default h1 styling, need to change second param to whatever menu button/value will be used
  static widget({required String content, String? style}) =>
      Text(content, style: h1);

  static TextStyle get h1 => const TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      );

  static TextStyle get h2 => const TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      );

  static TextStyle get h3 => const TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      );

  static TextStyle get h4 => const TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      );

  static TextStyle get h5 => const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0,
      );

  static TextStyle get h6 => const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  //static List<Heading> values = [h1, h2, h3, h4, h5, h6];
}

class Paragraph {
  const Paragraph._();

  static Text widget({required String content}) => Text(content, style: style);

  static get style => const TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.normal, letterSpacing: 0.25);
}

class Blockquote {
  const Blockquote._();

  static Padding widget({required String quote}) => Padding(
        padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
        child: Container(
          child: Text(quote, style: Paragraph.style),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );
}

class Bold {
  const Bold._();

  // Change selected text's fontweight to bold fontweight
}

class Italicize {
  // Change selected text's style to FontStyle.italic
}

class BulletList {
  //const BulletList._();
  // Create ordered list and unordered list
  // List items
  var bulletList = <Widget>[];
  final List<String> listItems = [];

  BulletList() {
    for (var i in listItems) {
      // bulletList.add(i);
    }
  }

  static Column widget() => Column(children: const []);

  //static widget() =>
}

class Table {
  const Table._();

  // static Table widget() => Table(
  //       border: TableBorder.all(),
  //       children: <TableRow>[
  //         const TableRow(
  //           children: <Widget>[],
  //         ),
  //       ],
  //     );
}

class Image {
  // Image_picker package
  const Image._();

  // static Image widget() => Image(
  //       image: Image.file(file: null, scale: 1.0, repeat: false),
  //     );
}

class Erase {}

class Duplicate {}

class Split {}

class NewLine {}
