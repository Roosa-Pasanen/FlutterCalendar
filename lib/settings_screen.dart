import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "note_listview.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
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
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Notes app'),
              ),
              ListTile(
                title: const Text('Notes'),
                onTap: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NoteListView()));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Settings'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dark mode"),
                Container(child: SettingsToggle()),
              ],
            )
          ],
        ));
  }
}

class SettingsToggle extends StatefulWidget {
  const SettingsToggle({super.key});

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {
  bool light = true;

  void toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Dark mode', value);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: light,
        onChanged: (bool value) {
          toggleTheme(value);
          setState(() {
            light = value;
          });
        });
  }
}
