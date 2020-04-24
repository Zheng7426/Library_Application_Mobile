import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/screens/home/book_details.dart';
import 'package:library_application_mobile/models/book_info.dart';
import 'package:library_application_mobile/library/library.dart';
import 'package:flutter/material.dart';

class BookInfoTile extends StatefulWidget {
  final BookInfo bookInfo;

  BookInfoTile({this.bookInfo});

  @override
  _BookInfoTileState createState() => _BookInfoTileState();
}

class _BookInfoTileState extends State<BookInfoTile> {
  final GlobalKey<BookDetailsPageState> _key = GlobalKey();
  bool _isLoading = false;
  int uid = globals.currentUser.id;

  Widget showCard(bool enabled) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 6.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.bookInfo.title),
            subtitle: Text(widget.bookInfo.author),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              enabled
                  ? globals.styledRaisedButton(
                      "Show", 15.0, Colors.black54, Colors.white, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsPage(
                            key: _key,
                            bookInfo: widget.bookInfo,
                          ),
                        ),
                      );
                    })
                  : globals.styledRaisedButton(
                      "Show", 15.0, Colors.black54, Colors.white, null),
              SizedBox(width: 5),
              Library.isFavoriteBook(uid, widget.bookInfo.id)
                  ? (enabled
                      ? globals.styledRaisedButton(
                          "Unfavorite", 15.0, Colors.amber, Colors.black,
                          () async {
                          setState(() => _isLoading = true);
                          Map<String, dynamic> result =
                              await Library.removeFavoriteBookAtServer(
                                  widget.bookInfo.id);
                          if (Library.checkRemoveFavoriteBookAtServer(
                              result, context)) {
                            setState(() {
                              Library.removeFavoriteBook(
                                  uid, widget.bookInfo.id);
                              _isLoading = false;
                            });
                          } else {
                            setState(() => _isLoading = false);
                          }
                        })
                      : globals.styledRaisedButton(
                          "Unfavorite", 15.0, Colors.amber, Colors.black, null))
                  : (enabled
                      ? globals.styledRaisedButton(
                          "Favorite", 15.0, Colors.green, Colors.white,
                          () async {
                          setState(() => _isLoading = true);
                          Map<String, dynamic> result =
                              await Library.addFavoriteBookAtServer(
                                  widget.bookInfo.id);
                          if (Library.checkAddFavoriteBookAtServer(
                              result, context)) {
                            setState(() {
                              Library.addFavoriteBook(uid, widget.bookInfo.id);
                              _isLoading = false;
                            });
                          } else {
                            setState(() => _isLoading = false);
                          }
                        })
                      : globals.styledRaisedButton(
                          "Favorite", 15.0, Colors.green, Colors.white, null)),
              SizedBox(width: 5),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return showCard(!_isLoading);
  }
}
