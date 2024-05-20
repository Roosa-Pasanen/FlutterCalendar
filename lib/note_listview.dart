import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/notes.json');
    final data = await json.decode(response);
    print(data);
    setState(() {
      items = data["notes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: readJson, child: const Text("show content"));
  }
}
