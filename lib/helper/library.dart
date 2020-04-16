import 'package:library_application_mobile/shared/test_data.dart' as test_data;
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/models/favorite_books.dart';
import 'package:library_application_mobile/models/comments.dart';
import 'package:library_application_mobile/models/comment.dart';
import 'package:library_application_mobile/models/book_info.dart';

class Library {

  static String addTzToStoreFormat(String dateTimeString) {
    String newDateTimeString = dateTimeString.replaceFirst(' ', 'T')+'Z';
    return newDateTimeString;
  }

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    return addTzToStoreFormat(globals.storeDateFormat.format(now));
  }

  static String convertDateTimeStoreToDisplay(String dt) {
    DateTime dateTime = DateTime.parse(dt);
    return globals.displayDateFormat.format(dateTime);
  }

  static String convertDateTimeDisplaytoStore(String dt) {
    DateTime dateTime = DateTime.parse(dt);
    return globals.storeDateFormat.format(dateTime);
  }

  static UserInfo getCurrentUserInfo() {
    return UserInfo.fromJson(test_data.currentUserJson);
  }

  static List<BookInfo> getGenreBookData(String selectedGenre) {
    List<BookInfo> books = [];
    test_data.bookData.forEach((item) {
      if (item["genre"] == selectedGenre) {
        books.add(BookInfo.fromJson(item));
      }
    });
    return books;
  }

  static List<String> getGenreList(List<Map<String, dynamic>> bookList) {
    Set<String> genreSet = {};
    bookList.forEach((item) {
      genreSet.add(item["genre"]);
    });
    return genreSet.toList();
  }

  static FavoriteBooks getFavoriteBooks(int uid) {
    Map<String, dynamic> bookList = test_data.favoriteBookListJson;
    return (uid == bookList["user_id"])
        ? FavoriteBooks.fromJson(bookList)
        : FavoriteBooks.empty(uid);
  }

  static bool addFavoriteBook(int uid, int bid) {
    if (uid == globals.favoriteBooks.userId) {
      globals.favoriteBooks.bookIdList.add(bid);
      return true;
    }
    return false;
  }

  static bool removeFavoriteBook(int uid, int bid) {
    if(uid ==globals.favoriteBooks.userId) {
      if(globals.favoriteBooks.bookIdList.contains(bid)) {
        globals.favoriteBooks.bookIdList.remove(bid);
        return true;
      }
    }
    return false;
  }

  static Comments getBookComments(BookInfo bi) {
    Map<String, dynamic> comments = test_data.bookCommentListJson;
    Map<String, dynamic> comments1 = Map<String, dynamic>();
    if (bi.id == comments["book_id"]) {
      comments1["book_id"] = comments["book_id"];
      comments1["comments"] = [];
      comments["comments"].forEach((item) {
        comments1["comments"].add(Comment.fromJson(item));
      });
    }
    return (bi.id == comments["book_id"])
        ? Comments.fromJson(comments1)
        : Comments.empty(bi.id);
  }
}
