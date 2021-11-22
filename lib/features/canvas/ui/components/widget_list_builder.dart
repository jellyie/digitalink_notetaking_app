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
