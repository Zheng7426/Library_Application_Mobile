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

  Comments.empty(int bid) {
    this.bookId = bid;
    this.comments = [];
  }

  Comments.addComment(int bid, Comment c) {
    if(this.bookId==bid) {
      this.comments.add(c);
    }
  }

  Comments.removeComment(int bid, Comment c) {
    if(this.bookId==bid) {
      this.comments.remove(c);
    }
  }
}
