import 'dart:convert';
import 'dart:io';
import 'package:flutter_calendar/note.dart';
import 'package:path_provider/path_provider.dart';

Future<File> fetchFile() async {
  final directory = await getApplicationDocumentsDirectory();
  const fileName = "notes.json";
  return File("${directory.path}/$fileName");
}

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

Future<List> fileList() async {
  final directory = await getApplicationDocumentsDirectory();
  const fileName = "notes.json";
  final file = File("${directory.path}/$fileName");
  final String response = file.readAsStringSync();
  final data = await json.decode(response);
  return data["notes"];
}

Future<void> deleteEntry(obj) async {
  List<Note> noteList = [];
  int? updateIndex;
  List objectList = await fileList();

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

Future<void> saveEntry(obj) async {
  List<Note> noteList = [];
  int? updateIndex;
  List objectList = await fileList();

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
