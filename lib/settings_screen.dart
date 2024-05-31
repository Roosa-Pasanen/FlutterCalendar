import 'package:flutter/material.dart';
import 'bloc_theme.dart';
import 'package:provider/provider.dart';
import "note_listview.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
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
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Text('Notes app'),
              ),
              ListTile(
                title: const Text('Notes'),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoteListView()));
                  Navigator.pop(context);
                },
              ),
              const ListTile(
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dark mode"),
                SettingsToggle(),
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
  bool light = false;

  void toggleTheme(bool value, ThemeNotifier theme) async {
    if (value) {
      theme.setDarkMode();
    } else {
      theme.setLightMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Switch(
            value: light,
            onChanged: (bool value) {
              toggleTheme(value, theme);
              setState(() {
                light = value;
              });
            }));
  }
}
