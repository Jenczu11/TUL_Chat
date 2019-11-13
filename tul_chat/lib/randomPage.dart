import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/appbar.dart';

// import 'package:tul_mobileapp/logic/authentication.dart';
// import 'package:url_launcher/url_launcher.dart';
class RandomPage extends StatefulWidget {
  RandomPage({Key key}) : super(key: key);

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "RandomPage",
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
        context: context,
      ),
      body: new Center(
        child: new InkWell(
          child: new Text('Open Browser'),
          // onTap: () => launch('https://www.youtube.com/watch?v=oHg5SJYRHA0')
        ),
      ),
    );
  }
}
