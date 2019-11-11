import 'package:flutter/material.dart';
import 'package:tul_mobileapp/logic/authentication.dart';
import 'package:url_launcher/url_launcher.dart';
class Settings extends StatefulWidget {

  Settings({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
        body: new Center(
          child: new InkWell(
              child: new Text('Open Browser'),
              onTap: () => launch('https://www.youtube.com/watch?v=oHg5SJYRHA0')
          ),
        ),
    );
  }
}