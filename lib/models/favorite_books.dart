class FavoriteBooks {
  int userId;
  List<int> bookIdList;

  FavoriteBooks({
    this.userId,
    this.bookIdList,
  });

  FavoriteBooks.fromJson(Map json) {
    this.userId = int.parse(json["user_id"]);
    this.bookIdList =
        json["book_list"].isEmpty ? new List<int>.from(json["book_list"]) : [];
  }

  FavoriteBooks.empty(int uid) {
    this.userId = uid;
    this.bookIdList = [];
  }
}
