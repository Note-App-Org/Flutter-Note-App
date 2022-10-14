class NoteModel {
  String? id;
  String? title;
  String? content;
  String? date;
  int? colorId;

  NoteModel({
    this.id,
    this.title,
    this.content,
    this.date,
    this.colorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'colorId': colorId,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      date: map['date'] as String,
      colorId: map['colorId'] as int,
    );
  }
}
