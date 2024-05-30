import 'package:flutter/material.dart';
import "json_helper.dart";
import 'note_listview.dart';

class NoteEditing extends StatefulWidget {
  final String title;
  final String content;
  final String fileCreated;
  const NoteEditing(
      {super.key,
      required this.title,
      required this.content,
      required this.fileCreated});

  @override
  State<NoteEditing> createState() => _NoteEditingState(
      title: title, content: content, fileCreated: fileCreated);
}

class _NoteEditingState extends State<NoteEditing> {
  final String title;
  final String content;
  final String lastOpened = DateTime.now().toString();
  final String fileCreated;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  _NoteEditingState(
      {required this.title, required this.content, required this.fileCreated});

  @override
  void initState() {
    titleController.text = title;
    contentController.text = content;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            textDirection: TextDirection.ltr,
            controller: titleController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.secondaryContainer,
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "New title"),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                await saveEntry({
                  "title": titleController.text,
                  "content": contentController.text,
                  "last-opened": lastOpened,
                  "file-created": fileCreated,
                }).then((value) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoteListView())),
                    });
              },
            )
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
            child: TextField(
              textDirection: TextDirection.ltr,
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        )));
  }
}
