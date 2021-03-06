import 'package:flutter/material.dart';
import 'package:library_application_mobile/shared/test_data.dart' as test_data;
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/models/favorite_books.dart';
import 'package:library_application_mobile/models/comments.dart';
import 'package:library_application_mobile/models/comment.dart';
import 'package:library_application_mobile/models/book_info.dart';
import 'package:library_application_mobile/services/storage/persistent_storage.dart';

class Library {
  static String getAuthApiUrl() {
    return "${globals.libraryApplicationUrl}${globals.authApi}?";
  }

  static String getUsersWithEmailApiUrl(String email) {
    return "${globals.libraryApplicationUrl}${globals.usersApi}?email=${email}";
  }

  static String getBookBaseUrl() {
    return "${globals.libraryApplicationUrl}${globals.bookBaseApi}";
  }

  static String getBookmarksUrl(int uid) {
    return "${globals.libraryApplicationUrl}${globals.bookmarkApi}${uid}";
  }

  static String getBookmarksBookUrl(int bookId) {
    return "${globals.libraryApplicationUrl}${globals.bookmarkApi}${bookId}";
  }

  static String getCommentsUrl(int bookId) {
    return "${globals.libraryApplicationUrl}${globals.commentsApi}${bookId}";
  }

  static String getAddCommentsUrl() {
    return "${globals.libraryApplicationUrl}${globals.commentsApi}";
  }

  static Map<String, dynamic> prepareTokenQueryParam(
      String email, String password) {
    return {"user[email]": email, "user[password]": password};
  }

  static Map<String, dynamic> prepareAddCommentsParam(
      int bookId, Comment comment) {
    return {
      "comment[book_id]": bookId,
      "comment[title]": comment.title,
      "comment[note]": comment.note
    };
  }

  static Future<Map<String, dynamic>> getUserToken(
      String email, String password) async {
    Map<String, dynamic> result = await globals.httpService.httpRequest(
        "POST", getAuthApiUrl(),
        params: prepareTokenQueryParam(email, password));
    return result;
  }

  static bool checkKnownExceptions(
      Map<String, dynamic> result, BuildContext context) {
    if (result.containsKey('errors')) {
      globals.showMessageDialog(context, result['errors'][0]);
      return false;
    } else if (result.containsKey('status')) {
      String errMsg =
          'status: ' + result['status'].toString() + ' ' + result['error'];
      globals.showMessageDialog(context, errMsg);
      return false;
    }
    return true;
  }

  static bool checkUserToken(
      Map<String, dynamic> result, BuildContext context) {
    if (result.containsKey('token')) {
      globals.userToken = result['token'];
      return true;
    } else {
      if (checkKnownExceptions(result, context)) {
        globals.showMessageDialog(context, "Unknown Error");
      }
    }
    return false;
  }

  static Future<Map<String, dynamic>> getUserInfoWithEmail(String email) async {
    List<dynamic> result = await globals.httpService.httpRequest(
        "GET", getUsersWithEmailApiUrl(email),
        token: globals.userToken);
    return Map<String, dynamic>.from(result[0]);
  }

  static bool checkUserInfo(Map<String, dynamic> result, BuildContext context) {
    if (result.containsKey('id')) {
      globals.currentUser = getCurrentUserInfo(result);
      return true;
    } else {
      if (checkKnownExceptions(result, context)) {
        globals.showMessageDialog(context, "Unknown Error");
      }
    }
    return false;
  }

  static Future<List<dynamic>> getBookList() async {
    List<dynamic> result = await globals.httpService
        .httpRequest("GET", getBookBaseUrl(), token: globals.userToken);
    return result;
  }

  static bool checkBookList(List<dynamic> result, BuildContext context) {
    if (!checkKnownExceptions(result[0], context)) {
      return false;
    } else {
      List<BookInfo> books = [];
      result.forEach((item) {
        books.add(BookInfo.fromJson(Map<String, dynamic>.from(item)));
      });
      globals.bookCollectionData = books;
      return true;
    }
  }

  static Future<Map<String, dynamic>> getFavoriteBooksList(int uid) async {
    Map<String, dynamic> result = await globals.httpService
        .httpRequest("GET", getBookmarksUrl(uid), token: globals.userToken);
    return result;
  }

  static bool checkFavoriteBooksList(
      Map<String, dynamic> result, BuildContext context) {
    if (result.containsKey('user_id')) {
      globals.favoriteBooks = FavoriteBooks.fromJson(result);
      return true;
    } else {
      if (checkKnownExceptions(result, context)) {
        globals.showMessageDialog(context, "Unknown Error");
      }
    }
    return false;
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

/*
  static List<BookInfo> getBookCollectionData() {
    List<BookInfo> books = [];
    test_data.bookData.forEach((item) {
      books.add(BookInfo.fromJson(item));
    });
    return books;
  }

  static FavoriteBooks getFavoriteBooks(int uid) {
    Map<String, dynamic> bookList = test_data.favoriteBookListJson;
    return (uid == bookList["user_id"])
        ? FavoriteBooks.fromJson(bookList)
        : FavoriteBooks.empty(uid);
  }
*/
  static bool addFavoriteBook(int uid, int bid) {
    if (uid == globals.favoriteBooks.userId) {
      globals.favoriteBooks.bookIdList.add(bid);
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>> addFavoriteBookAtServer(
      int bookId) async {
    Map<String, dynamic> result = await globals.httpService.httpRequest(
        "PUT", getBookmarksBookUrl(bookId),
        token: globals.userToken);
    return result;
  }

  static bool checkAddFavoriteBookAtServer(
      Map<String, dynamic> result, BuildContext context) {
    if (!checkKnownExceptions(result, context)) {
      return false;
    } else {
      return true;
    }
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

  static Future<Map<String, dynamic>> removeFavoriteBookAtServer(
      int bookId) async {
    Map<String, dynamic> result = await globals.httpService.httpRequest(
        "DELETE", getBookmarksBookUrl(bookId),
        token: globals.userToken);
    return result;
  }

  static bool checkRemoveFavoriteBookAtServer(
      Map<String, dynamic> result, BuildContext context) {
    if (!checkKnownExceptions(result, context)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isFavoriteBook(int uid, int bid) {
    if (uid == globals.favoriteBooks.userId) {
      return globals.favoriteBooks.bookIdList.contains(bid);
    }
    return false;
  }

  static bool isBookMarkEmpty(int uid) {
    if (uid == globals.favoriteBooks.userId) {
      if (globals.favoriteBooks.bookIdList.isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  static Future<List<dynamic>> getBookCommentsFromServer(int bookId) async {
    List<dynamic> result = await globals.httpService
        .httpRequest("GET", getCommentsUrl(bookId), token: globals.userToken);
    return result;
  }

  static Comments checkBookCommentsFromServer(
      List<dynamic> result, BuildContext context, int bookId) {
    if (result.isEmpty || !checkKnownExceptions(result[0], context)) {
      return null;
    } else {
      return getBookCommentsFromList(
          bookId, List<Map<String, dynamic>>.from(result));
    }
  }

  static Comments getBookCommentsFromList(
      int bookId, List<Map<String, dynamic>> comments) {
    Map<String, dynamic> comments1 = Map<String, dynamic>();
    comments1["book_id"] = bookId;
    comments1["comments"] = [];
    comments.forEach((item) {
      if (comments1["book_id"] == item["book_id"]) {
        comments1["comments"].add(Comment.fromJson(item));
      }
    });
    return Comments.fromJson(comments1);
  }

  static Comments getBookComments(int bookId, Map<String, dynamic> comments) {
    //Map<String, dynamic> comments = test_data.bookCommentListJson;
    Map<String, dynamic> comments1 = Map<String, dynamic>();
    if (bookId == comments["book_id"]) {
      comments1["book_id"] = comments["book_id"];
      comments1["comments"] = [];
      comments["comments"].forEach((item) {
        comments1["comments"].add(Comment.fromJson(item));
      });
    }
    return (bookId == comments["book_id"])
        ? Comments.fromJson(comments1)
        : Comments.empty(bookId);
  }

  static Future<Map<String, dynamic>> addBookCommentsToServer(
      int bookId, Comment comment) async {
    Map<String, dynamic> result = await globals.httpService.httpRequest(
        "POST", getAddCommentsUrl(),
        params: prepareAddCommentsParam(bookId, comment),
        token: globals.userToken);
    return result;
  }

  static bool checkaddBookCommentsToServer(
      Map<String, dynamic> result, BuildContext context) {
    if (!checkKnownExceptions(result, context)) {
      return false;
    } else {
      return true;
    }
  }

  static String showEmail(String email) {
    return (email == null) ? '' : " by $email";
  }

  static void setUserCredential(String email, String password) {
    globals.userCredential = {"email": email, "password": password};
  }

  static void saveUserCredential() {
    PersistentStorage.saveData(
        globals.userCredentialStorageTag, globals.userCredential);
  }

  static Future<bool> loadUserCredential() async {
    globals.userCredential = Map<String, String>.from(
        await PersistentStorage.loadSavedData(
            globals.userCredentialStorageTag));
    return true;
  }

  static void clearUserCredential() async {
    PersistentStorage.clearSavedData(globals.userCredentialStorageTag);
    globals.userCredential = {};
  }
}
