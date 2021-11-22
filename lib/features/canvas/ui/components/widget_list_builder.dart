import 'package:digitalink_notetaking_app/features/canvas/models/canvas_notifier.dart';
import 'package:digitalink_notetaking_app/features/canvas/models/widgets/models/widget/widget.dart'
    as our;
import '../../../../providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class WidgetListBuilder extends ConsumerWidget {
  const WidgetListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(widgetNotifierProvider.notifier);
    final state = ref.watch(widgetNotifierProvider);
    List<our.Widget> list = List.from(state.widgets);

    Widget buildItem(our.Widget widget) {
      return Material(
        key: ValueKey(widget),
        borderRadius: BorderRadius.circular(2.0),
        child: InkWell(
          key: ValueKey(widget),
          onTap: () {
            print('tap detexted: ${list.indexOf(widget)}');
            notifier.setSelectedIndex(list.indexOf(widget));
          },
          // Hover not working here, need to add this function within WidgetNotifier
          onHover: (hovering) {
            notifier.onHover = hovering;
          },
          child: widget.widget,
        ),
      );
    }

    return Center(
      child: ReorderableGridView.count(
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 6,
        onReorder: (oldIndex, newIndex) {
          notifier.reorderWidgets(oldIndex, newIndex);
        },
        children: list.map((e) => buildItem(e)).toList(),
      ),
    );
  }
}
