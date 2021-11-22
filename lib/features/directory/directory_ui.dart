import 'package:digitalink_notetaking_app/features/canvas/ui/canvas_ui.dart';
import 'file_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

class DirectoryUI extends StatefulWidget {
  const DirectoryUI({Key? key}) : super(key: key);

  @override
  _DirectoryUIState createState() => _DirectoryUIState();
}

class _DirectoryUIState extends State<DirectoryUI> {
  TextEditingController _textFieldController = TextEditingController();

  // Show dialog for creating file name
  Future<void> _displayTextInputDialog(
      BuildContext context, FileData fileData) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                    fileData.addNewFile(codeDialog);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => riverpod.ProviderScope(
                              child: CanvasUI(
                                  canvasNotifierProvider:
                                      fileData.getCanvasNotifierProvider(
                                          fileData.getLength() - 1),
                                  widgetNotifierProvider:
                                      fileData.getWidgetNotifierProvider(
                                          fileData.getLength() - 1))),
                        ));
                  });
                },
              ),
            ],
          );
        });
  }

  String codeDialog = '';
  String valueText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Directory'),
        ),
        body: ChangeNotifierProvider<FileData>(
            create: (_) => FileData(),
            child: Consumer<FileData>(
                builder: (context, FileData fileData, child) {
              return Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 2.0, color: Color(0xFFDFDFDF)))),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    children: [
                      for (int i = 0; i <= fileData.getLength(); i++)
                        i == fileData.getLength()
                            ? Card(
                                color: Colors.lightBlue[100],
                                shadowColor: Colors.blueGrey,
                                child: InkWell(
                                    onTap: () {
                                      _displayTextInputDialog(
                                          context, fileData);
                                    },
                                    child: Icon(Icons.add, size: 80.0)))
                            : Card(
                                color: Colors.lightBlue[100],
                                shadowColor: Colors.blueGrey,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => riverpod.ProviderScope(
                                                child: CanvasUI(
                                                    canvasNotifierProvider: fileData
                                                        .getCanvasNotifierProvider(
                                                            fileData.getLength() -
                                                                1),
                                                    widgetNotifierProvider: fileData
                                                        .getWidgetNotifierProvider(
                                                            fileData.getLength() -
                                                                1))),
                                          ));
                                    },
                                    child: Container(
                                      child: Text(
                                        fileData.getName(i),
                                        style: TextStyle(fontSize: 30.0),
                                      ),
                                      alignment: Alignment.center,
                                    )))
                    ],
                  ));
            })));
  }
}
