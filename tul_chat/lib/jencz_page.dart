import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_demo/const.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_flutter_app_icons.dart';

class Jencz extends StatefulWidget {
  Jencz({Key key}) : super(key: key);

  @override
  _Jencz createState() => _Jencz();
}

class _Jencz extends State<Jencz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Bartłomiej Jencz",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
            Image.network("https://avatars0.githubusercontent.com/u/39594956?s=400&v=4"),
          Text("Follow me on",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: (() async {
                await _launchURL('https://jenczu11.github.io/');
              }), icon: Icon(MyFlutterApp.github_circled), label: Text("GitHub")),
              FlatButton.icon(onPressed: (() async {
                await _launchURL('https://www.facebook.com/bartek.jencz');
              }), icon: Icon(MyFlutterApp.facebook_squared), label: Text("Facebook"))
            ],
          )
        ],
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
