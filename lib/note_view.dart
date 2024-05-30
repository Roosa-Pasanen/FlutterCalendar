import 'package:flutter/material.dart';
import 'package:flutter_calendar/note_listview.dart';
import "note_edit.dart";
import 'json_helper.dart';

class NoteView extends StatelessWidget {
  final String title;
  final String content;
  final String fileCreated;
  const NoteView(
      {super.key,
      required this.title,
      required this.content,
      required this.fileCreated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteEditing(
                      title: title,
                      content: content,
                      fileCreated: fileCreated,
                    ),
                  ),
                ).then((value) => null);
              },
            ),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  deleteEntry({
                    "title": title,
                    "content": content,
                    "last-opened": DateTime.now().toString(),
                    "file-created": fileCreated,
                  }).then((value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NoteListView())),
                      });
                })
          ],
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: Text(content),
            ),
          ),
        ));
  }
}
