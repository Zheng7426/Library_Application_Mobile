import 'package:library_application_mobile/shared/globals.dart' as globals;
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

  int uid = globals.currentUser.id;

  @override
  Widget build(BuildContext context) {
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
              globals.styledRaisedButton(
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
              }),
              SizedBox(width: 5),
              Library.isFavoriteBook(uid, widget.bookInfo.id)
                  ? globals.styledRaisedButton(
                      "Unfavorite", 15.0, Colors.amber, Colors.black, () {
                      setState(() {
                        Library.removeFavoriteBook(uid, widget.bookInfo.id);
                      });
                    })
                  : globals.styledRaisedButton(
                      "Favorite", 15.0, Colors.green, Colors.white, () {
                      setState(() {
                        Library.addFavoriteBook(uid, widget.bookInfo.id);
                      });
                    }),
              SizedBox(width: 5),
            ],
          )
        ],
      ),
    );
  }
}
