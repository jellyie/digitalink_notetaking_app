import 'package:digitalink_notetaking_app/features/canvas/ui/canvas_ui.dart';
import 'package:digitalink_notetaking_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryUI extends ConsumerWidget {
  const DirectoryUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wValue = ref.watch(wNPListProvider);
    final nameValue = ref.watch(nameProvider);

    // String codeDialog = '';
    String valueText = '';
    TextEditingController _textFieldController = TextEditingController();

    // Show dialog for adding a new file name
    Future<void> _displayTextInputDialog(
        BuildContext context, int fileLength) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New file'),
              content: TextField(
                onChanged: (value) {
                  valueText = value;
                },
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: "Input file name"),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    addNewFile(valueText);
                    // codeDialog = valueText;
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CanvasUI(index: fileLength),
                        ));
                  },
                ),
              ],
            );
          });
    }

    // Show dialog for editing a file
    Future<void> _displayChangeInputDialog(
        BuildContext context, int index) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Edit file'),
              content: TextField(
                onChanged: (value) {
                  valueText = value;
                },
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: "Input file name"),
              ),
              actions: <Widget>[
                // TextButton(
                //   child: Text('DELETE FILE\t'),
                //   onPressed: () {
                //     deleteFile(index);
                //     Navigator.pop(context);
                //   },
                // ),
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    changeFileName(valueText, index);
                    // codeDialog = valueText;
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Files'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: [
              for (int i = 0; i <= wValue.length; i++)
                i == wValue.length
                    ? //add a new file
                    Card(
                        color: Colors.lightBlue[100],
                        shadowColor: Colors.blueGrey,
                        child: InkWell(
                            onTap: () {
                              _displayTextInputDialog(context, wValue.length);
                            },
                            child: const Icon(Icons.add, size: 80.0)))
                    : //enter a current file
                    Card(
                        color: Colors.lightBlue[100],
                        shadowColor: Colors.blueGrey,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CanvasUI(index: i),
                                  ));
                            },
                            onLongPress: () {
                              _displayChangeInputDialog(context, i);
                            },
                            child: Container(
                              child: Text(
                                nameValue[i],
                                style: const TextStyle(fontSize: 30.0),
                              ),
                              alignment: Alignment.center,
                            )))
            ],
          )),
    );
  }
}
