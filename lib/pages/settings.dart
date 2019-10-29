import 'package:flutter/material.dart';
import 'package:tul_mobileapp/logic/authentication.dart';

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
       body: ListView(
         children: <Widget>[
         ],
       ),
    );
  }
}