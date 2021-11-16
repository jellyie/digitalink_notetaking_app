import '../models/canvas_notifier.dart';
import '../models/state/canvas_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'painter/canvas_painter.dart';

final canvasNotifierProvider =
    StateNotifierProvider<CanvasNotifier, CanvasState>(
        (ref) => CanvasNotifier());

class CanvasUI extends ConsumerWidget {
  const CanvasUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CanvasState state = ref.watch(canvasNotifierProvider);
    CanvasNotifier notifier = ref.watch(canvasNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas Screen'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
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
            onPanStart: notifier.onPanStart,
            onPanUpdate: notifier.onPanUpdate,
            onPanEnd: notifier.onPanEnd,
          ),
          // Build a button to clear the canvas
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                notifier.clear();
              },
              child: const Text('Clear'),
            ),
          ),
        ],
      ),
    );
  }
}
