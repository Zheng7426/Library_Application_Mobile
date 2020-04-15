import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/models/book_info.dart';
import 'package:library_application_mobile/screens/home/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookList extends StatefulWidget {
  final String selectedGenre;
  BookList({this.selectedGenre});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    List<BookInfo> books = [];
    globals.books.forEach((item) {
      if (item["genre"] == widget.selectedGenre) {
        books.add(BookInfo.fromJson(item));
      }
    });
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookInfoTile(bookInfo: books[index]);
      },
    );
  }
}
