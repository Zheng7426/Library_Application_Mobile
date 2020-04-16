import 'package:library_application_mobile/helper/library.dart';
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

    List<BookInfo> books = Library.getGenreBookData(widget.selectedGenre);

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
