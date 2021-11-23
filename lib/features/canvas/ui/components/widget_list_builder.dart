import '../../models/widgets/models/widget/widget.dart' as our;
import '../../../../providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderables/reorderables.dart';

class WidgetListBuilder extends ConsumerWidget {
  final int index;
  const WidgetListBuilder({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasNotifier = ref.watch(cNPList[index].notifier);
    final notifier = ref.watch(wNPList[index].notifier);
    List<our.Widget> list = List.from(ref.watch(wNPList[index]).widgets);

    void _onReorder(int oldIndex, int newIndex) {
      notifier.reorderWidgets(oldIndex, newIndex);
      canvasNotifier.toggleIgnore();
    }

    void _onReorder(int oldIndex, int newIndex) {
      notifier.reorderWidgets(oldIndex, newIndex);
      canvasNotifier.toggleIgnore();
    }

    int selectedWidgetIndex;

    Widget buildItem(our.Widget widget) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.white,
          key: ValueKey(widget),
<<<<<<< HEAD
<<<<<<< HEAD
          onTap: () {
            notifier.setSelectedIndex(list.indexOf(widget));
            notifier.toggleSelectedWidget();
            canvasNotifier.toggleIgnore();
          },
          // Hover not working here, need to add this function within WidgetNotifier
          onHover: (hovering) {},
          // Show candidates when it's the selected widget
<<<<<<< HEAD
<<<<<<< HEAD
          onDoubleTap: () {
            debugPrint('double tap');
            List<String> candidatesList = canvasNotifier.candidatesList;

            // Check if the widget is selected and candidates exist
            if (widget.selected == true &&
                canvasNotifier.candidatesList.isNotEmpty) {
=======
          onLongPress: () {
=======
          onDoubleTap: () {
            debugPrint('double tap');
>>>>>>> e4d8548 (Working on table)
            List<String> candidatesList = canvasNotifier.candidatesList;

            // Check if the widget is selected and candidates exist
            if (widget.selected == true &&
<<<<<<< HEAD
                canvasNotifier.getCandidateData().isNotEmpty) {
>>>>>>> d41edb1 (Move candidate methods to canvas notifier)
=======
                canvasNotifier.candidatesList.isNotEmpty) {
>>>>>>> bc3ed66 (Move candidate methods to canvas notifier)
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
=======
          shape: (widget.selected == true)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  side: BorderSide(color: Colors.grey.shade300, width: 2),
                )
              : null,
          child: InkWell(
            splashColor: Colors.blue[50],
            highlightColor: Colors.blue[50],
            key: ValueKey(widget),
            onTap: () {
              selectedWidgetIndex = list.indexOf(widget);
              if (notifier.selectedIndex != selectedWidgetIndex) {
                notifier.toggleSelectedWidget();
                notifier.setSelectedIndex(list.indexOf(widget));
              }
              notifier.toggleSelectedWidget();
              canvasNotifier.toggleIgnore();
            },
            // Hover not working here, need to add this function within WidgetNotifier
            onHover: (hovering) {},
            // Show candidates when it's the selected widget
            onDoubleTap: () {
              debugPrint('double tap');
              List<String> candidatesList = canvasNotifier.candidatesList;

=======
          shape: (widget.selected == true)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  side: BorderSide(color: Colors.grey.shade300, width: 2),
                )
              : null,
          child: InkWell(
            splashColor: Colors.blue[50],
            highlightColor: Colors.blue[50],
            key: ValueKey(widget),
            onTap: () {
              selectedWidgetIndex = list.indexOf(widget);
              if (notifier.selectedIndex != selectedWidgetIndex) {
                notifier.toggleSelectedWidget();
                notifier.setSelectedIndex(list.indexOf(widget));
              }
              notifier.toggleSelectedWidget();
              canvasNotifier.toggleIgnore();
            },
            // Hover not working here, need to add this function within WidgetNotifier
            onHover: (hovering) {},
            // Show candidates when it's the selected widget
            onDoubleTap: () {
              debugPrint('double tap');
              List<String> candidatesList = canvasNotifier.candidatesList;

>>>>>>> 6d6bc13be355d5a874f5476415be0c029f12112e
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
            child: Padding(
                padding: const EdgeInsets.all(20.0), child: widget.widget),
          ),
<<<<<<< HEAD
>>>>>>> 6d6bc13 (Added image widget)
=======
>>>>>>> 6d6bc13be355d5a874f5476415be0c029f12112e
        ),
      );
    }

    final ver1 = ReorderableWrap(
      spacing: 10.0,
      runSpacing: 10.0,
      minMainAxisCount: 1,
      maxMainAxisCount: 1,
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
