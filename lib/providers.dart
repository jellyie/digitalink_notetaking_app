import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/canvas/models/widgets/models/widget_list/widget_list.dart';
import 'features/canvas/models/widgets/widget_notifier.dart';

final widgetNotifierProvider =
    StateNotifierProvider<WidgetNotifier, WidgetList>(
        (ref) => WidgetNotifier());

final widgetListProvider =
    Provider<WidgetList>((ref) => ref.watch(widgetNotifierProvider));
