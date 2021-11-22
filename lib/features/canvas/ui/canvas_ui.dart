import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_data.dart';
import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_list.dart';
import 'package:digitalink_notetaking_app/features/canvas/q_dollar_recognizer/gesture.dart';
import 'package:digitalink_notetaking_app/features/canvas/q_dollar_recognizer/templates.dart';

import '../models/canvas_notifier.dart';
import '../models/state/canvas_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'painter/canvas_painter.dart';
import 'package:provider/provider.dart' as provider;

final canvasNotifierProvider =
    StateNotifierProvider<CanvasNotifier, CanvasState>(
        (ref) => CanvasNotifier());

class CanvasUI extends ConsumerWidget {
  final WidgetData widgetData;
  const CanvasUI({Key? key, required this.widgetData}) : super(key: key);

  static final List<Gesture> _trainingSet = Templates.templates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CanvasState state = ref.watch(canvasNotifierProvider);
    CanvasNotifier notifier = ref.watch(canvasNotifierProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Canvas Screen'),
        ),
        backgroundColor: Colors.white,
        body: provider.ChangeNotifierProvider<WidgetData>.value(
            value: widgetData,
            child: provider.Consumer<WidgetData>(
                builder: (context, WidgetData widgetData, child) {
              return Row(children: [
                Stack(
                  children: [
                    GestureDetector(
                      child: RepaintBoundary(
                        key: notifier.globalkey,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(4.0),
                          child: CustomPaint(
                            painter: CanvasPainter(state: state),
                          ),
                        ),
                      ),
                      onPanStart: notifier.onPanStart,
                      onPanUpdate: notifier.onPanUpdate,
                      onPanEnd: notifier.onPanEnd,
                    ),
                    // Build a button to clear the canvas
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // notifier.recgoniseText();
                          notifier.recogniseShape(_trainingSet, widgetData);
                          notifier.clear();
                        },
                        child: const Text('Recognize'),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: WidgetList(widgetData: widgetData),
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 2.0, color: Color(0xFFDFDFDF)))),
                )
              ]);
            })));
  }
}
