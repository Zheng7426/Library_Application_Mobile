import 'package:library_application_mobile/models/comment.dart';

class Comments {
  int bookId;
  List<Comment> comments;

  Comments({
    this.bookId,
    this.comments,
  });

  Comments.fromJson(Map json) {
    this.bookId = json["book_id"];
    this.comments = List<Comment>.from(json["comments"]);
  }

  Comments.empty(int bi) {
    this.bookId = bi;
    this.comments = [];
  }
}
