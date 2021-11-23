import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableWidget extends ConsumerWidget {
  const TableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'First Column',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Second Column',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(cells: <DataCell>[
            DataCell(Text('Empty data cell')),
            DataCell(Text('Empty data cell')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('Empty data cell')),
            DataCell(Text('Empty data cell')),
          ]),
        ],
      ),
    );
  }
}
