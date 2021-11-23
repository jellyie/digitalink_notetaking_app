import 'package:digitalink_notetaking_app/features/canvas/ui/canvas_ui.dart';
import 'package:digitalink_notetaking_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectoryUI extends ConsumerWidget {
  DirectoryUI({Key? key}) : super(key: key);

  String codeDialog = '';
  String valueText = '';
  TextEditingController _textFieldController = TextEditingController();

  // Show dialog for adding a new file name
  Future<void> _displayTextInputDialog(
      BuildContext context, int fileLength) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New file'),
            content: TextField(
              onChanged: (value) {
                valueText = value;
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Input file name"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK'),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wValue = ref.watch(wNPListProvider);
    final cValue = ref.watch(cNPListProvider);
    final nameValue = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Directory'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
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
                            child: Icon(Icons.add, size: 80.0)))
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
                            child: Container(
                              child: Text(
                                nameValue[i],
                                style: TextStyle(fontSize: 30.0),
                              ),
                              alignment: Alignment.center,
                            )))
            ],
          )),
    );
  }
}
