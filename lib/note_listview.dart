import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import "note_view.dart";
import "note_edit.dart";
import "json_helper.dart";

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List _items = [];

  Future<void> readJson() async {
    try {
      final File file = await fetchFile();
      final String response = file.readAsStringSync();
      final data = await json.decode(response);
      setState(() {
        _items = data["notes"];
      });
    } on PathNotFoundException {
      final File file = await createFile();
      final String response = file.readAsStringSync();
      final data = await json.decode(response);
      setState(() {
        _items = data["notes"];
      });
    }
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("View notes"),
          centerTitle: true,
          actions: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteEditing(
                        title: "",
                        content: "",
                        fileCreated: DateTime.now().toString(),
                      ),
                    ),
                  );
                },
                child: Text("New"))
          ],
        ),
        body: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteView(
                                          title: _items[index]["title"],
                                          content: _items[index]["content"],
                                          fileCreated: _items[index]
                                              ["file-created"]),
                                    )).then((value) => readJson());
                              },
                              child: ListTile(
                                title: Text(_items[index]["title"]),
                                subtitle: Text(_items[index]["content"]),
                              ),
                            ));
                      },
                    ),
                  )
                : Container()
          ],
        ));
  }
}
