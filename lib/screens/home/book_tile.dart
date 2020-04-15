import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/models/book_info.dart';
import 'package:flutter/material.dart';

class BookInfoTile extends StatelessWidget {
  final BookInfo bookInfo;

  BookInfoTile({this.bookInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 6.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(bookInfo.title),
            subtitle: Text(bookInfo.author),
            //dense: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              globals.styledRaisedButton(
                  "Show", 15.0, Colors.black54, Colors.white, () {}),
              SizedBox(width:5),
              globals.styledRaisedButton(
                  "Favorite", 15.0, Colors.green, Colors.white, () {}),
              SizedBox(width:5),
              globals.styledRaisedButton(
                  "Unfavorite", 15.0, Colors.amber, Colors.black, () {}),
              SizedBox(width:5),
            ],
          )
        ],
      ),
    );
  }
}
