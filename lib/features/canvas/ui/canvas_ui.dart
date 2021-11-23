// ignore_for_file: prefer_const_constructors
import 'package:flutter/rendering.dart';

import '../../../providers.dart';
import 'components/widget_list_builder.dart';
import '../models/widgets/widget_notifier.dart';

import '../models/canvas_notifier.dart';
import '../models/state/canvas_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'painter/canvas_painter.dart';

import '../../canvas/models/widgets/models/widget_list/widget_list.dart';

class CanvasUI extends ConsumerWidget {
  final int index;
  const CanvasUI({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetNotifier widgetNotifier = ref.watch(wNPList[index].notifier);
    CanvasState state = ref.watch(cNPList[index]);
    CanvasNotifier notifier = ref.watch(cNPList[index].notifier);
    notifier.readWidgetNotifier(widgetNotifier);

    final canvasName = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(title: Text(canvasName[index])),
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 0.99,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  controller: scrollController,
                  child: Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 1.5,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: IgnorePointer(
                              ignoring: notifier.ignore,
                              child: RepaintBoundary(
                                key: notifier.globalkey,
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0.15,
                                        blurRadius: 15.0,
                                        offset: Offset(6, 5)),
                                  ]),
                                  padding: EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: CustomPaint(
                                      painter: CanvasPainter(state: state),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onPanStart: notifier.onPanStart,
                            onPanUpdate: notifier.onPanUpdate,
                            onPanEnd: notifier.onPanEnd,
                            onLongPress: () => notifier.toggleIgnore(),
                            // onTapDown: notifier.onTapDown,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 1.5,
                          child: IgnorePointer(
                            ignoring: !notifier.ignore,
                            child: WidgetListBuilder(
                              index: index,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

          /// Build a button to clear the canvas
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: const Text('Clear'),
                  onPressed: () {
                    notifier.clear();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
