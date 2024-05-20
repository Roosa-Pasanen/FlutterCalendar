import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class NoteEditing extends StatefulWidget {
  const NoteEditing({super.key});

  @override
  State<NoteEditing> createState() => _NoteEditingState();
}

class _NoteEditingState extends State<NoteEditing> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextField(
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
