import 'package:flutter/material.dart';
import 'dart:convert';
import 'Note.dart';
import "note_edit.dart";
import 'package:flutter/services.dart';

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
              icon: Icon(Icons.edit),
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
            )
          ],
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent),
              child: Text(content),
            ),
          ),
        ));
  }
}
