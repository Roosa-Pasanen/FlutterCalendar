import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

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
    print(data);
    setState(() {
      _items = data["notes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: readJson,
          child: const Text("show content"),
        ),
        _items.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(_items[index]["title"]),
                        subtitle: Text(_items[index]["content"]),
                      ),
                    );
                  },
                ),
              )
            : Container()
      ],
    );
  }
}
