library library_application_mobile.globals;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/models/favorite_books.dart';
import 'package:library_application_mobile/models/comments.dart';
import 'package:library_application_mobile/models/comment.dart';
import 'package:library_application_mobile/models/book_info.dart';
import 'package:intl/intl.dart';
import 'package:library_application_mobile/services/http_service/http_request.dart';

const libraryApplicationUrl =
    'https://library-application-rails-2.herokuapp.com/';
const authApi = 'api/auth/';
const bookBaseApi = 'api/books/';
const usersApi = 'api/users';


final displayDateFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
final storeDateFormat = DateFormat('yyyy-MM-dd hh:mm:ss.sss');

HttpService httpService;
String userToken;
UserInfo currentUser = null;
FavoriteBooks favoriteBooks = null;
List<BookInfo> bookCollectionData = null;

final int color1 = 0xFF295A8D;
final int color3 = 0xFF92AE85;
final int color6 = 0xFFF6E7A3;
final int color7 = 0xFF525252;
final int color9 = 0xFFD3D4A1;

TextStyle ts(double fsize, Color color, FontWeight fw) {
  return TextStyle(
    fontFamily: 'Segoeui',
    fontSize: fsize,
    color: color,
    fontWeight: fw,
  );
}

void setPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Widget styledRaisedButton(
    String text, double size, Color kColor, Color wColor, Function func) {
  return RaisedButton(
    color: kColor,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(5.0),
      side: BorderSide(
        color: kColor,
      ),
    ),
    onPressed: () {
      func();
    },
    child: Text(
      text,
      style: ts(size, wColor, FontWeight.w400),
    ),
  );
}

void showMessageDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: msg),
                  ),
                  SizedBox(
                    width: 100.0,
                    child: styledRaisedButton(
                      'OK',
                      18.0,
                      Colors.blue,
                      Colors.white,
                      () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Widget headerHpl() {
  return Container(
    padding: const EdgeInsets.only(top: 35),
    color: Color(color1),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/images/hpl_logo.png',
            height: 50,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    ),
  );
}

