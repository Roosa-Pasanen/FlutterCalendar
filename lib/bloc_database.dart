import 'dart:convert';
import 'dart:io';
import 'package:flutter_calendar/note.dart';
import 'package:path_provider/path_provider.dart';

/// Fetch the existing notes.json file.
/// Returns the notes.json file
Future<File> fetchFile() async {
  final directory = await getApplicationDocumentsDirectory();
  const fileName = "notes.json";
  return File("${directory.path}/$fileName");
}

/// Create a new notes.json file.
/// Returns the new notes.json file initialized with a "notes" table.
Future<File> createFile() async {
  final directory = await getApplicationDocumentsDirectory();
  const fileName = "notes.json";
  File file = await File("${directory.path}/$fileName").create();
  await file.writeAsString("""{
    "notes": [

    ]
    }
    """);
  return file;
}

/// Fetch data from a file's notes table.
/// Returns the contents of the notes table.
Future<List> fetchData() async {
  try {
    final File file = await fetchFile();
    final String response = file.readAsStringSync();
    final data = await json.decode(response);
    return data["notes"];
  } on PathNotFoundException {
    // If path doesn't exist
    final File file = await createFile();
    final String response = file.readAsStringSync();
    final data = await json.decode(response);
    return data["notes"];
  }
}

/// Delete entry from json data.
/// Takes the entry to be deleted as an argument.
Future<void> deleteEntry(obj) async {
  List<Note> noteList = [];
  int? updateIndex;
  List objectList = await fetchData();

  objectList.forEach((element) {
    noteList.add(Note.fromJson(element));
  });
  Note toDelete = Note.fromJson(obj);

  noteList.forEach((element) {
    if (element.fileCreated == toDelete.fileCreated) {
      updateIndex = noteList.indexOf(element);
    }
  });

  if (updateIndex != null) {
    noteList.removeAt(updateIndex!);
  }

  await writeFile(noteList);
}

/// Saves an entry to the json data
/// Takes the entry to be saved as an argument
Future<void> saveEntry(obj) async {
  List<Note> noteList = [];
  int? updateIndex; // If null, the entry is new
  List objectList = await fetchData();

  objectList.forEach((element) {
    noteList.add(Note.fromJson(element));
  });
  Note toUpdate = Note.fromJson(obj);

  noteList.forEach((element) {
    if (element.fileCreated == toUpdate.fileCreated) {
      updateIndex = noteList.indexOf(element);
    }
  });

  if (updateIndex != null) {
    noteList.removeAt(updateIndex!);
  }

  noteList.insert(0, toUpdate);

  await writeFile(noteList);
}

/// Writes a list of notes into json-format
/// Takes the list to be converted as the argument
Future<void> writeFile(List<Note> noteList) async {
  String stringList = "";

  noteList.forEach((element) {
    stringList += element.toJsonString();
    if (noteList.indexOf(element) != noteList.length - 1) {
      stringList += ",";
    }
    stringList += "\n";
  });

  File file = await fetchFile();
  String start = """{
    "notes": [
  """;
  String end = """]
  }
  """;

  String jsonString = start + stringList + end;
  await file.writeAsString(jsonString);
}
