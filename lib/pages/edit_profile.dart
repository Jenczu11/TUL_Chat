import 'package:flutter/material.dart';


import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _phoneNumber = Padding(
    padding: EdgeInsets.all(5),
    child: TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.text,
      controller: phoneNumberController,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        hintText: 'Phone number',
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    ),
  );


  final _name = Padding(
    padding: EdgeInsets.all(5),
    child: TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.text,
      controller: nameController,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        hintText: 'Your name',
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    ),
  );

  final _email = Padding(
    padding: EdgeInsets.all(5),
    child: TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.text,
      controller: emailAddressController,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(32.0)),
        hintText: 'Email address',
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Edit profile details"),),
      body: ListView(
        children: <Widget>[
          _name,
          _phoneNumber,
          _email,
          SizedBox(height: MediaQuery.of(context).size.height*0.25,),
          FlatButton.icon(onPressed: (() async {
            await patchDataDB(currentlyLoggedUser.id,nameController.text,emailAddressController.text,phoneNumberController.text);
          }), icon: Icon(Icons.send), label: Text("Update"))





        ],
      ),
    );
  }



}