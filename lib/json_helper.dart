import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_calendar/note.dart';
import 'package:path_provider/path_provider.dart';

Future<File> fetchFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = "notes.json";
  return await File("${directory.path}/$fileName");
}

Future<File> createFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = "notes.json";
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
  final fileName = "notes.json";
  final file = await File("${directory.path}/$fileName");
  final String response = file.readAsStringSync();
  final data = await json.decode(response);
  return data["notes"];
}

Future<void> writeFile(obj) async {
  List<Note> noteList = [];
  int? updateIndex = null;
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
    noteList[updateIndex!] = toUpdate;
  } else {
    noteList.add(toUpdate);
  }

  noteList.forEach((element) {
    print(element.toJson().toString());
  });

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

  String altogether = start + stringList + end;
  print(altogether);
  await file.writeAsString(altogether);
}
