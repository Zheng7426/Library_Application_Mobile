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
}
