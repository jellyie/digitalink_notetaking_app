import '../../models/widgets/models/widget/widget.dart' as our;
import '../../../../providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class WidgetListBuilder extends ConsumerWidget {
  const WidgetListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasNotifier = ref.watch(canvasNotifierProvider.notifier);
    final notifier = ref.watch(widgetNotifierProvider.notifier);
    List<our.Widget> list =
        List.from(ref.watch(widgetNotifierProvider).widgets);

    Widget buildItem(our.Widget widget) {
      return Material(
        key: ValueKey(widget),
        shape: (widget.selected == true)
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
                side: const BorderSide(color: Colors.black),
              )
            : null,
        child: InkWell(
          key: ValueKey(widget),
          onTap: () {
            notifier.setSelectedIndex(list.indexOf(widget));
            notifier.toggleSelectedWidget();
            canvasNotifier.toggleIgnore();
          },
          // Hover not working here, need to add this function within WidgetNotifier
          onHover: (hovering) {},
          // Show candidates when it's the selected widget
          onLongPress: () {
            List<String> candidatesList = notifier.getCandidateData();

            // Check if the widget is selected and candidates exist
            if (widget.selected == true &&
                notifier.getCandidateData().isNotEmpty) {
              showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(0, 0, 0, 0),
                  items: [
                    for (int i = 0; i < candidatesList.length; i++)
                      PopupMenuItem(
                          value: candidatesList[i],
                          child: Text(candidatesList[i]))
                  ]).then((value) =>
                  {if (value != null) notifier.updateWidgetData(value)});
            }
          },
          child: widget.widget,
        ),
      );
    }

    return Center(
      child: ReorderableGridView.count(
        padding: const EdgeInsets.all(100.0),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 6,
        onReorder: (oldIndex, newIndex) {
          notifier.reorderWidgets(oldIndex, newIndex);
          canvasNotifier.toggleIgnore();
        },
        children: list.map((e) => buildItem(e)).toList(),
      ),
    );
  }
}
