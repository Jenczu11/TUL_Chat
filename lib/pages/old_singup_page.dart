//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:tul_mobileapp/logic/rest_api.dart';
//import 'package:tul_mobileapp/objects/user.dart';
//import 'package:tul_mobileapp/pages/home.dart';
//import 'package:tul_mobileapp/pages/processing.dart';
//import 'package:tul_mobileapp/constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//
//
//
//class Start extends StatefulWidget {
//  @override
//  _StartState createState() => _StartState();
//}
//
//class _StartState extends State<Start> {
//  String _email;
//  String _password;
//  Widget showEmailInput() {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
//      child: new TextFormField(
//        maxLines: 1,
//        keyboardType: TextInputType.emailAddress,
//        autofocus: false,
//        decoration: new InputDecoration(
//            hintText: 'Email',
//            icon: new Icon(
//              Icons.mail,
//              color: Colors.grey,
//            )),
//        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//        onSaved: (value) => _email = value.trim(),
//      ),
//    );
//  }
//
//  Widget showPasswordInput() {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//      child: new TextFormField(
//        maxLines: 1,
//        obscureText: true,
//        autofocus: false,
//        decoration: new InputDecoration(
//            hintText: 'Password',
//            icon: new Icon(
//              Icons.lock,
//              color: Colors.grey,
//            )),
//        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
//        onSaved: (value) => _password = value.trim(),
//      ),
//    );
//  }
//
//  Widget showPrimaryButton() {
//    return new Padding(
//        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//        child: SizedBox(
//          height: 40.0,
//          child: new RaisedButton(
//            elevation: 5.0,
//            shape: new RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(30.0)),
//            color: Colors.blue,
//            child: new Text(_isLoginForm ? 'Login' : 'Create account',
//                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
//            onPressed: validateAndSubmit,
//          ),
//        ));
//  }
//
//
//    @override
//  Widget build(BuildContext context) {
//        return Scaffold(
//      backgroundColor: Colors.white,
//      body: ListView(
//        children: <Widget>[
//          Image.network("https://www.clipartwiki.com/clipimg/full/13-133005_construction-clipart-curriculum-under-construction-png.png"),
//          SizedBox(height: 50,),
//          showEmailInput(),
//          showPasswordInput(),
//          Padding(
//            padding: EdgeInsets.symmetric(horizontal: 100.0),
//            child: RaisedButton(
//              shape: StadiumBorder(),
//              child: Text("Log In"),
//              onPressed: () async {
//
//                await _signIn(phoneNumberController.text);
//                await fetchDataFromDB();
//                Navigator.of(context).pop();
//                phoneNumberController.clear();
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) {
//                     return Home();
//                    },
//                    fullscreenDialog: false,
//                  ),
//
//                );
//              }
//            ),
//          ),
//        ],
//
//      )
//
//      );
//
//  }
//
//
//}
