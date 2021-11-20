import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_model.dart';
import 'package:flutter/material.dart';
import 'widget_data.dart';

// For displaying the widget list
class WidgetList extends StatefulWidget {
  final WidgetData widgetData;
  const WidgetList({Key? key, required this.widgetData}) : super(key: key);
  @override
  _WidgetListState createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  @override
  Widget build(BuildContext context) {
    // Styles could be changed, now the grey background is used to create the widget field
    // The child buildWidgetList() is the actual display of the widgets
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 3 / 4,
        decoration: BoxDecoration(
            color: const Color.fromARGB(15, 100, 100, 100),
            border: Border.all(
                color: const Color.fromARGB(100, 100, 100, 100), width: 1)),
        child: buildWidgetList(widget.widgetData),
      ),
    );
  }

  Widget buildWidgetList(WidgetData widgetData) {
    // the reorderable list view is for reordering
    return ReorderableListView(
      shrinkWrap: true,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          widgetData.reorderWidgets(oldIndex, newIndex);
        });
      },
      children: [
        for (var i = 0; i < widgetData.getListLength(); i++)
          InkWell(
            key: Key('$i'),
            child: Container(
              child: WidgetModel(widgetData: widgetData, index: i).getWidget(),
              decoration: BoxDecoration(
                border: widgetData.isSelected(i)
                    ? Border.all(color: Colors.blueGrey.shade200, width: 2.0)
                    : null,
              ),
            ),
            onTap: () {
              widgetData.updateSelectedNum(i);
            },
          )
      ],
    );
  }
}
