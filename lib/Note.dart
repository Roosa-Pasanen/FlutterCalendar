/*int idCount = 0;

void createNewNote(title, content) {
  final note = Note(
      id: idCount,
      title: title,
      content: content,
      lastOpened: DateTime.now(),
      fileCreated: DateTime.now());
  idCount++;

}*/

class Note {
  //final int id;
  final String title;
  final String content;
  DateTime lastOpened = DateTime.now();
  DateTime fileCreated = DateTime.now();

  Note(
      {required this.title,
      required this.content,
      required this.lastOpened,
      required this.fileCreated});

  Note.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        content = json['content'] as String,
        lastOpened = DateTime.parse(json['last-opened']),
        fileCreated = DateTime.parse(json['file-created']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'last-opened': lastOpened,
        'file-created': fileCreated,
      };

  String toJsonString() => """{
    "title": "$title",
    "content": "$content",
    "last-opened": "$lastOpened",
    "file-created": "$fileCreated"
  }""";
}
