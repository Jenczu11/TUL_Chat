import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:tul_mobileapp/objects/user.dart';
import 'package:tul_mobileapp/pages/home.dart';
import 'package:tul_mobileapp/pages/processing.dart';
import 'package:tul_mobileapp/constants.dart';




class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final _phoneNumber = Padding(
    padding: EdgeInsets.all(5),
    child: TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      controller: phoneNumberController,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        hintText: 'Phone number',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    ),
  );


    @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Colors.black12,
      body: ListView(
        children: <Widget>[
          Image.network("https://www.clipartwiki.com/clipimg/full/13-133005_construction-clipart-curriculum-under-construction-png.png"),
          SizedBox(height: 50,),
          _phoneNumber,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: RaisedButton(
              shape: StadiumBorder(),
              child: Text("Log In"),
              onPressed: () async {
                showProcessingDialog(context, "Signing in...");
                await _signIn(phoneNumberController.text);
                await fetchDataFromDB();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                     return Home();
                    },
                    fullscreenDialog: false,
                  ),
                );
              }
            ),
          ),
        ],

      )

      );

  }

  Future<Null> _signIn(String _phoneNumber) async{
    final url = "https://lut-mobileapp.firebaseio.com/users.json";
    bool _exists = false;
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      if(extractedData!=null) {
        extractedData.forEach((userId, userData) {
          print(userData['phoneNumber'].toString());
          if (userData['phoneNumber'].toString() == _phoneNumber) {
            _exists = true;
            print("Already exists - do nothing ");
             currentlyLoggedUser = new User(
               id: userId,
               phoneNumber: userData['phoneNumber'],
               email: userData['email'],
               name: userData['name'],
            );
          }
        });
      }
    } catch(error){
      throw (error);
    }
    if(_exists == false){
      print("Dosen't exist - add to database");
      http.post(url, body: json.encode({
        "phoneNumber" : _phoneNumber,
        "name" : "",
        "email" : ""
      }),).then((response) {
        currentlyLoggedUser = new User(id:json.decode(response.body)['name'], phoneNumber: _phoneNumber,
          email: "",
          name: "",
        );
      }
      );
    }

  }
}
