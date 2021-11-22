// ignore_for_file: prefer_const_constructors

import '../../../providers.dart';
import 'components/widget_list_builder.dart';
import '../models/widgets/widget_notifier.dart';

import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/templates.dart';

import '../models/canvas_notifier.dart';
import '../models/state/canvas_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'painter/canvas_painter.dart';

final canvasNotifierProvider =
    StateNotifierProvider<CanvasNotifier, CanvasState>(
        (ref) => CanvasNotifier());

class CanvasUI extends ConsumerWidget {
  const CanvasUI({Key? key}) : super(key: key);

  static final List<Gesture> _trainingSet = Templates.templates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetNotifier widgetNotifier = ref.watch(widgetNotifierProvider.notifier);
    CanvasState state = ref.watch(canvasNotifierProvider);
    CanvasNotifier notifier = ref.watch(canvasNotifierProvider.notifier);
    notifier.readWidgetNotifier(widgetNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas Screen'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: notifier.ignore,
            child: WidgetListBuilder(),
          ),
          GestureDetector(
            child: IgnorePointer(
              ignoring: !notifier.ignore,
              child: RepaintBoundary(
                key: notifier.globalkey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(4.0),
                  child: CustomPaint(
                    painter: CanvasPainter(state: state),
                  ),
                ),
              ),
            ),
            onPanStart: notifier.onPanStart,
            onPanUpdate: notifier.onPanUpdate,
            onPanEnd: notifier.onPanEnd,
          ),

          // Build a button to clear the canvas
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
                    notifier.ignoreToFalse();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Swap layers'),
                  onPressed: () {
                    notifier.ignoreToFalse();
                    //print(notifier.ignore);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Delete'),
                  onPressed: () {
                    //notifier.clear();
                    widgetNotifier.deleteWidget();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Recognize shape'),
                  onPressed: () {
                    // notifier.recgoniseText();
                    notifier.recogniseShape(_trainingSet);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Update widget content'),
                  onPressed: () {
                    // notifier.recgoniseText();
                    widgetNotifier.updateWidgetData('this widget is updated');
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
