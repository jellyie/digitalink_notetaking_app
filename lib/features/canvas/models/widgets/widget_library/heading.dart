import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_data.dart';
import 'package:flutter/material.dart';

class Heading extends StatefulWidget {
  final WidgetData widgetData;
  final int index;
  const Heading({Key? key, required this.widgetData, required this.index})
      : super(key: key);

  @override
  _HeadingState createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  static List<TextStyle> values = [h1, h2, h3, h4, h5, h6];

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

  @override
  Widget build(BuildContext context) {
    final GlobalKey _key = GlobalKey();
    return Container(
        child: GestureDetector(
      onTapUp: (details) {
        if (widget.widgetData.isSelected(widget.index)) {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
                details.globalPosition.dx, details.globalPosition.dy, 0, 0),
            items: <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: Text("h1"),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text("h2"),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text("h3"),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text("h4"),
              ),
              const PopupMenuItem(
                value: 4,
                child: Text("h5"),
              ),
              const PopupMenuItem(
                value: 5,
                child: Text("h6"),
              ),
            ],
          ).then((value) => {
                if (value != null)
                  widget.widgetData.updateParam(value, widget.index)
              });
        } else {
          widget.widgetData.updateSelectedNum(widget.index);
        }
      },
      child: Text(
        widget.widgetData.getContent(widget.index).isEmpty
            ? "Header"
            : widget.widgetData.getContent(widget.index),
        style: values[widget.widgetData.getParam(widget.index)],
      ),
    ));
  }
}
