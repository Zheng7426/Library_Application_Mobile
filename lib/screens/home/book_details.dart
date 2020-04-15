import 'package:flutter/material.dart';
import 'package:library_application_mobile/models/book_info.dart';
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:library_application_mobile/helper/call_no.dart';

class BookDetailsPage extends StatefulWidget {
  final BookInfo bookInfo;
  BookDetailsPage({Key key, @required this.bookInfo}) : super(key: key);

  @override
  BookDetailsPageState createState() => BookDetailsPageState();
}

class BookDetailsPageState extends State<BookDetailsPage> with SingleTickerProviderStateMixin {

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
        body: Column(
          children: <Widget>[
            globals.headerHpl(),
          ]

        ),
      ),
    );
  }
}