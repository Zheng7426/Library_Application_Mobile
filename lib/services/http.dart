import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:library_application_mobile/models/comments.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;

class HttpService {
  final String uid;
  HttpService({this.uid});
  var response;

  Future<void> fetchComments() async {
    response = await http.get(globals.libraryApplicationUrl);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> leaveComments(Comments comment) async {
    response = await http.post(globals.libraryApplicationUrl);
    if (response.statusCode == 200) {
      print('Success!');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

class Session {
  Map<String, String> headers = {};

  Future<Map> get(String url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return convert.jsonDecode(response.body);
  }

  Future<Map> post(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    updateCookie(response);
    return convert.jsonDecode(response.body);
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}