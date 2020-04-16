class Comment {
  String title;
  String note;

  Comment({
    this.title,
    this.note,
  });

  Comment.fromJson(Map json) {
    this.title = json["title"];
    this.note = json["note"];
  }

  Comment.construct(String title, String note) {
    this.title = title;
    this.note = note;
  }
}
