class Comment {
  String title;
  String note;
  String createTime;

  Comment({
    this.title,
    this.note,
    this.createTime,
  });

  Comment.fromJson(Map json) {
    this.title = json["title"];
    this.note = json["note"];
    this.createTime = json["created_at"];
  }

  Comment.construct(String title, String note, String create_time) {
    this.title = title;
    this.note = note;
    this.createTime = create_time;
  }
}
