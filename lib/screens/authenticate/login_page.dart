import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:library_application_mobile/screens/home/home.dart';

const SERVER_IP = 'http://10.0.2.2:3000';
final storage = FlutterSecureStorage();
Dio dio = new Dio();
class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  Future<String> loginAttempt(String email, String password) async {
    var res = await dio.post("${SERVER_IP}/api/auth?",
        queryParameters: {
          "user[email]": email,
          "user[password]": password
        }
    );
    var result = res.data;
    return result['token'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email Address'
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
            ),
            FlatButton(
                onPressed: () async {
                  var email = _emailController.text;
                  var password = _passwordController.text;
                  var jwt = await loginAttempt(email, password);
                  if (jwt != null) {
                    storage.write(key: "jwt", value: jwt);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return new Home(jwt: jwt);
                            }));
                  } else {
                    displayDialog(context, "An Error Occurred",
                        "No account was found matching that email and password");
                  }
                },
                child: Text("Log In")
            ),
          ],
        ),
      ),
    );
  }
}