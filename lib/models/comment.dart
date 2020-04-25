class Comment {
  String title;
  String note;
  String email;
  String createTime;

  Comment({
    this.title,
    this.note,
    this.email,
    this.createTime,
  });

  Comment.fromJson(Map json) {
    this.title = json["title"];
    this.note = json["note"];
    this.email = json["email"];
    this.createTime = json["created_at"];
  }

  Comment.construct(
      String title, String note, String email, String createTime) {
    this.title = title;
    this.note = note;
    this.email = email;
    this.createTime = createTime;
  }
}
