class FavoriteBooks {
  int userId;
  List<int> bookIdList;

  FavoriteBooks({
    this.userId,
    this.bookIdList,
  });

  FavoriteBooks.fromJson(Map json) {
    this.userId = json["userId"];
    this.bookIdList = json["bookId"];
  }

  FavoriteBooks.empty(int uid) {
    this.userId = uid;
    this.bookIdList = [];
  }
}
