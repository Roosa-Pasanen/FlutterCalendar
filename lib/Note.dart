class Note {
  final int id;
  final String title;
  final String content;

  Note(this.id, this.title, this.content);

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        content = json['content'] as String;

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content};
}

/*
final DateTime lastOpened;
this.lastOpened
lastOpened = json['last-opened'] as DateTime;
'last-opened': lastOpened
*/
