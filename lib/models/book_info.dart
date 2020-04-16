class BookInfo {
  int id;
  String title;
  String author;
  String summary;
  String genre;
  String isbn;

  BookInfo({
    this.id,
    this.title,
    this.author,
    this.summary,
    this.genre,
    this.isbn,
  });

  BookInfo.fromJson(Map json) {
    this.id = json["id"];
    this.title = json["title"];
    this.author = json["author"];
    this.summary = json["summary"];
    this.genre = json["genre"];
    this.isbn = json["isbn"];
  }
}
