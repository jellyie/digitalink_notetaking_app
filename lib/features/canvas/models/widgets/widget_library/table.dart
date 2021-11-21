import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_data.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  final WidgetData widgetData;
  final int index;
  const TableWidget({Key? key, required this.widgetData, required this.index})
      : super(key: key);

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  void _updateTable(value) {
    switch (value) {
      case 0: // add column
        break;
      case 1: // delete column
        break;
      case 2: // add row
        break;
      case 3: // delete row
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: [
          TableRow(children: [
            GestureDetector(
                onTapUp: (details) {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(details.globalPosition.dx,
                        details.globalPosition.dy, 0, 0),
                    items: <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 0,
                        child: Text("Add Column"),
                      ),
                      const PopupMenuItem(
                        value: 1,
                        child: Text("Delete Column"),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text("Add Row"),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Text("Delete Row"),
                      ),
                    ],
                  ).then((value) => _updateTable(value));
                },
                child: Text("value")),
          ])
        ],
      ),
    );
  }
}
