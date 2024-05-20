import 'package:flutter/material.dart';
import 'dart:convert';
import 'Note.dart';
import 'package:flutter/services.dart';

class NoteEditing extends StatefulWidget {
  final String title;
  final String content;
  const NoteEditing({super.key, required this.title, required this.content});

  @override
  State<NoteEditing> createState() =>
      _NoteEditingState(title: title, content: content);
}

class _NoteEditingState extends State<NoteEditing> {
  final String title;
  final String content;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  _NoteEditingState({required this.title, required this.content});

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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.blueAccent,
              hintText: "New title"),
        ),
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
      body: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent),
            child: TextField(
              textDirection: TextDirection.ltr,
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          )),
          const SizedBox(height: 20),
        ],
      )),
    );
  }
}
