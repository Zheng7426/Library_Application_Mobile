import 'package:flutter/material.dart';
import 'package:library_application_mobile/models/user.dart';
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:library_application_mobile/helper/call_no.dart';

class BookMark extends StatefulWidget {
  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
