import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_data.dart';
import 'package:flutter/material.dart';

class BulletList extends StatefulWidget {
  final WidgetData widgetData;
  final int index;
  const BulletList({Key? key, required this.widgetData, required this.index})
      : super(key: key);

  @override
  _BulletListState createState() => _BulletListState();
}

class _BulletListState extends State<BulletList> {
  String bullet = "\u2022\t";

  @override
  Widget build(BuildContext context) {
    List listData = widget.widgetData.getList(widget.index);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          for (int i = 0; i < listData.length; i++)
            GestureDetector(
                onTapUp: (details) {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(details.globalPosition.dx,
                          details.globalPosition.dy, 0, 0),
                      items: [
                        const PopupMenuItem(
                          value: 0,
                          child: Text("Ordered/Unordered"),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Text("add bullet point below"),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text("delete bullet point"),
                        ),
                      ]).then((value) => {
                        if (value == 0)
                          {
                            // change the order
                            widget.widgetData.getParam(widget.index) == 0
                                ? widget.widgetData.updateParam(1, widget.index)
                                : widget.widgetData.updateParam(0, widget.index)
                          }
                        else
                          {
                            if (value == 1)
                              {
                                // add bullet point below
                                widget.widgetData
                                    .addBulletPoint(widget.index, i)
                              }
                            else
                              {
                                //delete bullet point
                                widget.widgetData
                                    .deleteBulletPoint(widget.index, i)
                              }
                          }
                      });
                },
                child: widget.widgetData.getParam(widget.index) == 0
                    ? Text(bullet + listData[i])
                    : Text((i + 1).toString() + ".\t" + listData[i]))
        ],
      ),
    );
  }
}