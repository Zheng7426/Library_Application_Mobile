import 'package:flutter/material.dart';
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/models/book_info.dart';
import 'package:library_application_mobile/models/favorite_books.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/library/library.dart';
import 'package:library_application_mobile/screens/home/book_details.dart';

class BookMarkPage extends StatefulWidget {
  final UserInfo userInfo;

  BookMarkPage({Key key, @required this.userInfo}) : super(key: key);

  @override
  BookMarkPageState createState() => BookMarkPageState();
}

class BookMarkPageState extends State<BookMarkPage> {
  final GlobalKey<BookDetailsPageState> _key = GlobalKey();
  FavoriteBooks _favoriteBooks = null;

  Widget showTitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Personal Bookmark",
              style: globals.ts(28.0, Colors.black, FontWeight.w700)),
          globals.styledRaisedButton("Back", 15.0, Colors.green, Colors.white,
              () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }

  Widget showBookList() {
    int uid = widget.userInfo.id;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: globals.favoriteBooks.bookIdList.length,
      itemBuilder: (context, index) {
        BookInfo bookInfo =
            Library.getBookDataFromBookId(globals.favoriteBooks.bookIdList[index]);
        return Card(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 6.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(bookInfo.title),
                subtitle: Text(bookInfo.author),
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
                          bookInfo: bookInfo,
                        ),
                      ),
                    );
                  }),
                  SizedBox(width: 5),
                  Library.isFavoriteBook(uid, bookInfo.id)
                      ? globals.styledRaisedButton(
                          "Unfavorite", 15.0, Colors.amber, Colors.black, () {
                          setState(() {
                            Library.removeFavoriteBook(uid, bookInfo.id);
                          });
                        })
                      : globals.styledRaisedButton(
                          "Favorite", 15.0, Colors.green, Colors.white, () {
                          setState(() {
                            Library.addFavoriteBook(uid, bookInfo.id);
                          });
                        }),
                  SizedBox(width: 5),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);
    globals.setPortrait();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          globals.headerHpl(),
          showTitle(),
          Expanded(
            child: showBookList(),
          ),
        ]),
      ),
    );
  }
}
