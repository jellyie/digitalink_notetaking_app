import '../../models/widgets/models/widget/widget.dart' as our;
import '../../../../providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderables/reorderables.dart';

class WidgetListBuilder extends ConsumerWidget {
  const WidgetListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasNotifier = ref.watch(canvasNotifierProvider.notifier);
    final notifier = ref.watch(widgetNotifierProvider.notifier);
    List<our.Widget> list =
        List.from(ref.watch(widgetNotifierProvider).widgets);

    void _onReorder(int oldIndex, int newIndex) {
      notifier.reorderWidgets(oldIndex, newIndex);
      canvasNotifier.toggleIgnore();
    }

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
          onDoubleTap: () {
            debugPrint('double tap');
            List<String> candidatesList = canvasNotifier.candidatesList;

            // Check if the widget is selected and candidates exist
            if (widget.selected == true &&
                canvasNotifier.candidatesList.isNotEmpty) {
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

    final ver1 = ReorderableWrap(
      spacing: 10.0,
      runSpacing: 10.0,
      minMainAxisCount: 1,
      maxMainAxisCount: 3,
      padding: const EdgeInsets.all(100.0),
      children: list.map((e) => buildItem(e)).toList(),
      onReorder: _onReorder,
    );

    // final ver2 = ReorderableGridView.count(
    //   padding: const EdgeInsets.all(100.0),
    //   crossAxisCount: 3,
    //   crossAxisSpacing: 10.0,
    //   mainAxisSpacing: 10.0,
    //   childAspectRatio: 1,
    //   onReorder: (oldIndex, newIndex) {
    //     notifier.reorderWidgets(oldIndex, newIndex);
    //     canvasNotifier.toggleIgnore();
    //   },
    //   children: list.map((e) => buildItem(e)).toList(),
    // );
    return ver1;
  }
}
