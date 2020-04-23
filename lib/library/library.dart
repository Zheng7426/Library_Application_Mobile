import 'package:flutter/material.dart';
import 'package:library_application_mobile/shared/test_data.dart' as test_data;
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/models/favorite_books.dart';
import 'package:library_application_mobile/models/comments.dart';
import 'package:library_application_mobile/models/comment.dart';
import 'package:library_application_mobile/models/book_info.dart';

class Library {

  static String getAuthApiUrl() {
    return "${globals.libraryApplicationUrl}${globals.authApi}?";
  }

  static String getUsersWithEmailApiUrl(String email) {
    return "${globals.libraryApplicationUrl}${globals.usersApi}?email=${email}";
  }

  static Map<String, dynamic> prepareTokenQueryParam(
      String email, String password) {
    return {"user[email]": email, "user[password]": password};
  }

  static Future<Map<String, dynamic>> getUserToken(
      String email, String password) async {
    Map<String, dynamic> result = await globals.httpService.httpRequest(
        "POST",
        getAuthApiUrl(),
        params:prepareTokenQueryParam(email, password));
    return result;
  }

  static bool checkUserToken(Map<String, dynamic> result, BuildContext context) {
    if (result.containsKey('token')) {
      globals.userToken = result['token'];
      return true;
    } else if (result.containsKey('errors')) {
      globals.showMessageDialog(context, result['errors'][0]);
    } else if (result.containsKey('status')) {
      String errMsg = 'status: ' +
          result['status'].toString() +
          ' ' +
          result['error'];
      globals.showMessageDialog(context, errMsg);
    } else {
      globals.showMessageDialog(context, "Unknown Error");
    }
    return false;
  }

  static Future<Map<String, dynamic>> getUserInfoWithEmail(String email) async {
     List<dynamic> result =  await globals.httpService.httpRequest(
        "GET",
        getUsersWithEmailApiUrl(email),
        token:globals.userToken);
    return Map<String,dynamic>.from(result[0]);
  }

  static bool checkUserInfo(Map<String, dynamic> result, BuildContext context) {
    if (result.containsKey('id')) {
      globals.currentUser = getCurrentUserInfo(result);
      return true;
    } else if (result.containsKey('errors')) {
      globals.showMessageDialog(context, result['errors'][0]);
    } else if (result.containsKey('status')) {
      String errMsg = 'status: ' +
          result['status'].toString() +
          ' ' +
          result['error'];
      globals.showMessageDialog(context, errMsg);
    } else {
      globals.showMessageDialog(context, "Unknown Error");
    }
    return false;
  }

  static void initGetData() {
    globals.bookCollectionData = getBookCollectionData();
    //globals.currentUser = Library.getCurrentUserInfo();
    globals.favoriteBooks = Library.getFavoriteBooks(globals.currentUser.id);
  }

  static String addTzToStoreFormat(String dateTimeString) {
    String newDateTimeString = dateTimeString.replaceFirst(' ', 'T') + 'Z';
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

  static List<BookInfo> getBookCollectionData() {
    List<BookInfo> books = [];
    test_data.bookData.forEach((item) {
      books.add(BookInfo.fromJson(item));
    });
    return books;
  }

  static UserInfo getCurrentUserInfo(Map currentUserJson) {
    return UserInfo.fromJson(currentUserJson);
  }

  static List<BookInfo> getGenreBookData(String selectedGenre) {
    List<BookInfo> books = [];
    globals.bookCollectionData.forEach((item) {
      if (item.genre == selectedGenre) {
        books.add(item);
      }
    });
    return books;
  }

  static BookInfo getBookDataFromBookId(int bookId) {
    for (BookInfo item in globals.bookCollectionData) {
      if (item.id == bookId) {
        return item;
      }
    }
    return null;
  }

  static List<String> getGenreList(List<BookInfo> bookList) {
    Set<String> genreSet = {};
    bookList.forEach((item) {
      genreSet.add(item.genre);
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
    if (uid == globals.favoriteBooks.userId) {
      if (globals.favoriteBooks.bookIdList.contains(bid)) {
        globals.favoriteBooks.bookIdList.remove(bid);
        return true;
      }
    }
    return false;
  }

  static bool isFavoriteBook(int uid, int bid) {
    if (uid == globals.favoriteBooks.userId) {
      return globals.favoriteBooks.bookIdList.contains(bid);
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