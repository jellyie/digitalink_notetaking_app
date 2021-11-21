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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: TableBorder.all(color: Colors.grey),
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
                        value: 0,
                        child: Text("Delete Column"),
                      ),
                      const PopupMenuItem(
                        value: 0,
                        child: Text("Add Row"),
                      ),
                      const PopupMenuItem(
                        value: 0,
                        child: Text("Delete Row"),
                      ),
                    ],
                  );
                },
                child: Text("cell"))
          ])
        ],
      ),
    );
  }
}
