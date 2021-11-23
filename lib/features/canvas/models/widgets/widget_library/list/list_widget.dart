import 'list_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listDataNotifier =
    ChangeNotifierProvider.autoDispose<ListData>((ref) => ListData());

class ListWidget extends ConsumerWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ListData listData = ref.read(listDataNotifier);
    final ScrollController _controller = ScrollController();

    return ListView.builder(
      controller: _controller,
      itemCount: listData.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final listItem = listData.items[index];
        return ListTile(
          title: Text('\u2022\t  ${listItem.data as String}'),
        );
      },
    );
  }
}
