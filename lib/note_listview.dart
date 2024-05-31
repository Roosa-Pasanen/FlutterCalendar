import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import "note_view.dart";
import "note_edit.dart";
import "bloc_database.dart";
import "settings_screen.dart";

class NoteListView extends StatelessWidget {
  const NoteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("View notes"),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
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
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: const Text('Notes app'),
              ),
              const ListTile(
                title: Text('Notes'),
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: const NoteList());
  }
}

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List _items = [];

  Future<void> populateList() async {
    fetchData().then((value) => {
          setState(() {
            _items = value;
          })
        });
  }

  @override
  void initState() {
    populateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _items.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        margin: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoteView(
                                      title: _items[index]["title"],
                                      content: _items[index]["content"],
                                      fileCreated: _items[index]
                                          ["file-created"]),
                                )).then((value) => populateList());
                          },
                          child: ListTile(
                            title: Text(_items[index]["title"]),
                            subtitle: Text(_items[index]["content"]),
                          ),
                        ));
                  },
                ),
              )
            : const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    SizedBox(height: 50),
                    Text("""
                  It seems like you don't have any notes.
                  Create a note by pressing the + button.
                  """),
                  ]))
      ],
    );
  }
}
