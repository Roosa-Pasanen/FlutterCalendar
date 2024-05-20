import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import "note_edit.dart";

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/notes.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["notes"];
    });
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
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              tooltip: "Return",
            )
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
                                    builder: (context) => NoteEditing(
                                        title: _items[index]["title"],
                                        content: _items[index]["content"]),
                                  ),
                                );
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
