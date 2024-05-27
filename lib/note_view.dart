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
          ElevatedButton(
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
              child: Text("Edit"))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent),
              child: Text(content),
            ),
          ),
          const SizedBox(height: 20),
        ],
      )),
    );
  }
}
