// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../providers.dart';

// class TableWidget extends ConsumerStatefulWidget {
//   final int index;
//   const TableWidget({Key? key, required this.index}) : super(key: key);

//   @override
//   _TableWidgetState createState() => _TableWidgetState();
// }

// class _TableWidgetState extends ConsumerState<TableWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final canvasNotifier = ref.watch(canvasNotifierProvider.notifier);
//     final notifier = ref.watch(widgetNotifierProvider.notifier);
//     final widgetList = ref.watch(widgetNotifierProvider);

//     final tableList = notifier.selectedWidget!.widget;

//     void setTable(int index, List<List<String>> tableList) {
//       // add to widgetlist?
//     }

//     void _updateTable(value, tableList, row, column) {
//       switch (value) {
//         case 0: //add column
//           {
//             for (int i = 0; i < tableList.length; i++) {
//               tableList[i].insert(column + 1, "cell");
//             }
//             // widget.widgetData.setTable(widget.index, tableList);
//             break;
//           } // add column
//         case 1: // delete column
//           {
//             if (tableList[0].length == 1) {
//               tableList.removeAt(notifier.selectedIndex);
//             } else {
//               for (int i = 0; i < tableList.length; i++) {
//                 tableList[i].removeAt(column);
//               }
//               widget.widgetData.setTable(widget.index, tableList);
//             }
//             break;
//           }
//         case 2: // add row
//           {
//             List<String> newTableRow =
//                 List.generate(tableList[0].length, (index) => "cell");
//             tableList.insert(row, newTableRow);
//             widget.widgetData.setTable(widget.index, tableList);
//             break;
//           }
//         case 3: // delete row
//           {
//             if (tableList.length == 1) {
//               widget.widgetData.deleteWidget();
//             } else {
//               tableList.removeAt(row);
//               widget.widgetData.setTable(widget.index, tableList);
//             }
//             break;
//           }
//         default:
//           break;
//       }
//     }

//     final tableList = notifier.selectedWidget!.widget;

//     return Table(
//       border: TableBorder.all(color: Colors.blueGrey),
//       children: <TableRow>[
//         for (int row = 0; row < tableList.length; row++)
//           TableRow(children: [
//             for (int column = 0; column < tableList[row].length; column++)
//               GestureDetector(
//                   onTapUp: (details) {
//                     widget.widgetData.updateSelectedNum(widget.index);
//                     showMenu(
//                         context: context,
//                         position: RelativeRect.fromLTRB(
//                             details.globalPosition.dx,
//                             details.globalPosition.dy,
//                             0,
//                             0),
//                         items: <PopupMenuEntry>[
//                           const PopupMenuItem(
//                             value: 0,
//                             child: Text("Insert Column Right"),
//                           ),
//                           const PopupMenuItem(
//                             value: 1,
//                             child: Text("Delete this Column"),
//                           ),
//                           const PopupMenuItem(
//                             value: 2,
//                             child: Text("Insert Row Below"),
//                           ),
//                           const PopupMenuItem(
//                             value: 3,
//                             child: Text("Delete this Row"),
//                           ),
//                         ]).then(
//                         (value) => _updateTable(value, tableList, row, column));
//                   },
//                   child: Text(tableList[row][column]))
//           ])
//       ],
//     );
//   }
// }
