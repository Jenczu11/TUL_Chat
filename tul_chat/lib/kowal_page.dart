import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_demo/const.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_flutter_app_icons.dart';

class Kowal extends StatefulWidget {
  Kowal({Key key}) : super(key: key);

  @override
  _Kowal createState() => _Kowal();
}

class _Kowal extends State<Kowal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Krystian Kowalski",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
            Image.network("https://avatars1.githubusercontent.com/u/49548559?s=460&v=4"),
          Text("Follow me on",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: (() async {
                await _launchURL('https://github.com/krystiankowalski95');
              }), icon: Icon(MyFlutterApp.github_circled), label: Text("GitHub")),
              FlatButton.icon(onPressed: (() async {
                await _launchURL('https://www.facebook.com/krystian.kowalski2');
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
