import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

//Response response;
Dio dio = new Dio();
String bookBaseURL = 'http://10.0.2.2:3000/api/books/3';
String global_token = '';
final String authURL = 'http://10.0.2.2:3000/api/auth?';
final String bookURL = 'http://10.0.2.2:3000/api/books/1';

class Receiver extends StatefulWidget {

  _ReceiverState createState() => _ReceiverState();
}


class _ReceiverState extends State<Receiver>{
  Future<BookInfo> futureBook;
  var token = '';
  var bookInfo = '';

  @override
  void initState(){
    super.initState();
    //getToken();
    futureBook = getBookInfo();
  }





//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('First Route'),
//      ),
//      body: Center(
//        child: Text('${token}\n${title}\n${author}'),
//      ),
//    );
//  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<BookInfo>(
            future: futureBook,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title+"\n"+snapshot.data.author+"\n"+snapshot.data.summary);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }


//  getToken() async {
//
//    var response = await dio.post("${widget.authURL}", queryParameters: {"user[email]": 'huangz55@mcmaster.ca', "user[password]": "abc123"});
//    var result = response.data;
//    global_token = result['token'];
//
////    setState(() {
////      token = result['token'];
////    });
//  }

}

Future<BookInfo> getBookInfo() async {
//  var status = false;
//  Future.delayed(_ReceiverState.getToken()).whenComplete((){
//    status = true;
//  });
  var response_post = await dio.post("${authURL}", queryParameters: {"user[email]": 'huangz55@mcmaster.ca', "user[password]": "abc123"});
  var result = response_post.data;
  global_token = result['token'];

    final response_get = await http.get(
      bookBaseURL,
      headers: {HttpHeaders.authorizationHeader: "Token ${global_token}"},
    );

    if (response_get.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return BookInfo.fromJson(json.decode(response_get.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load book');
    }
  }

class BookInfo  {
  final String title;
  final String author;
  final String summary;

  BookInfo({this.title, this.author, this.summary});

  factory BookInfo.fromJson(Map<String, dynamic> json) {
    return BookInfo(
      title: json['title'],
      author: json['author'],
      summary: json['summary'],
    );
  }
}


