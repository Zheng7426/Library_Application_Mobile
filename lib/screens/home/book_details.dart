import 'package:flutter/material.dart';
import 'package:library_application_mobile/models/book_info.dart';
import 'package:library_application_mobile/models/comments.dart';
import 'package:library_application_mobile/models/comment.dart';
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:library_application_mobile/helper/library.dart';


class BookDetailsPage extends StatefulWidget {
  final BookInfo bookInfo;

  BookDetailsPage({Key key, @required this.bookInfo}) : super(key: key);

  @override
  BookDetailsPageState createState() => BookDetailsPageState();
}

class BookDetailsPageState extends State<BookDetailsPage> {
  TextEditingController _addTitleController = new TextEditingController();
  TextEditingController _addNoteController = new TextEditingController();
  Comments comments;
  Comment _comment = null;

  @override
  void initState() {
    comments = Library.getBookComments(widget.bookInfo);
    super.initState();
  }

  @override
  void dispose() {
    _addTitleController.dispose();
    _addNoteController.dispose();
    super.dispose();
  }

  Widget displayTitle(String s) {
    return Text(s, style: globals.ts(18.0, Colors.black, FontWeight.w700));
  }

  Widget displayContent(String s) {
    return Text(s, style: globals.ts(18.0, Colors.black, FontWeight.w200));
  }

  Widget displayFullRow(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        displayTitle(title),
        SizedBox(width: 5),
        (content != null) ? displayContent(content) : SizedBox(width: 5),
      ],
    );
  }

  Widget showBookDetails(BookInfo bi) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          displayFullRow("Name:", widget.bookInfo.title),
          displayFullRow("Author:", widget.bookInfo.author),
          displayFullRow("Summary:", null),
          Text(
            widget.bookInfo.summary,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: globals.ts(18.0, Colors.black, FontWeight.w200),
          ),
          displayFullRow("Genre:", widget.bookInfo.genre),
          displayFullRow("ISBN:", widget.bookInfo.isbn),
        ],
      ),
    );
  }

  Widget showAddCommentBlock() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            style: globals.ts(18.0, Colors.black, FontWeight.w200),
            decoration: const InputDecoration(
              labelText: 'Title',
              helperText: '',
            ),
            keyboardType: TextInputType.text,
            controller: _addTitleController,
          ),
          TextField(
            controller: _addNoteController,
            style: globals.ts(18.0, Colors.black, FontWeight.w200),
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Something about the book...",
              border: OutlineInputBorder(),
              labelText: 'Note',
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              globals.styledRaisedButton(
                  "Add Note", 15.0, Colors.blue, Colors.white, () {
                setState(() {
                  _comment = Comment.construct(
                    _addTitleController.text,
                    _addNoteController.text,
                    Library.getCurrentTime(),
                  );
                  comments.comments.add(_comment);
                  _addTitleController.text = '';
                  _addNoteController.text = '';
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              }),
              globals.styledRaisedButton(
                  "Back", 15.0, Colors.green, Colors.white, () {
                Navigator.of(context).pop();
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget showComments() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: comments.comments.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.black,
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(
                    comments
                        .comments[comments.comments.length - index - 1].title,
                    style: globals.ts(15.0, Colors.white, FontWeight.w600)),
                subtitle: Text(
                    comments
                        .comments[comments.comments.length - index - 1].note,
                    style: globals.ts(15.0, Colors.white, FontWeight.w300)),
              ),
              Text(
                  Library.convertDateTimeStoreToDisplay(comments
                      .comments[comments.comments.length - index - 1]
                      .createTime),
                  style: globals.ts(12.0, Colors.white, FontWeight.w100)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    globals.setPortrait();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            globals.headerHpl(),
            showBookDetails(widget.bookInfo),
            showAddCommentBlock(),
            Expanded(
              child: showComments(),
            ),
          ],
        ),
      ),
    );
  }
}
