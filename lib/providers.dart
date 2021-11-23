import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/canvas/models/canvas_notifier.dart';
import 'features/canvas/models/state/canvas_state.dart';
import 'features/canvas/models/widgets/models/widget_list/widget_list.dart';
import 'features/canvas/models/widgets/widget_notifier.dart';

// final widgetNotifierProvider =
//     StateNotifierProvider<WidgetNotifier, WidgetList>(
//         (ref) => WidgetNotifier());

// final widgetListProvider =
//     Provider<WidgetList>((ref) => ref.watch(widgetNotifierProvider));

// final canvasNotifierProvider =
//     StateNotifierProvider<CanvasNotifier, CanvasState>(
//         (ref) => CanvasNotifier());

final List<StateNotifierProvider<WidgetNotifier, WidgetList>> wNPList =
    []; //widget state notifier provider
final List<StateNotifierProvider<CanvasNotifier, CanvasState>> cNPList =
    []; //canvas state notifier provider
final List<String> nameList = [];
final wNPListProvider = Provider((ref) => wNPList);
final cNPListProvider = Provider((ref) => cNPList);
final nameProvider = Provider((ref) => nameList);

void addNewFile(String newName) {
  final widgetNotifierProvider =
      StateNotifierProvider<WidgetNotifier, WidgetList>(
          (ref) => WidgetNotifier());
  wNPList.add(widgetNotifierProvider);

  final canvasNotifierProvider =
      StateNotifierProvider<CanvasNotifier, CanvasState>(
          (ref) => CanvasNotifier());
  cNPList.add(canvasNotifierProvider);

  nameList.add(newName);
}
