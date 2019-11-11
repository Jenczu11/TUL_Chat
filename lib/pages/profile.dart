import 'package:flutter/material.dart';


import 'package:tul_mobileapp/constants.dart';

import 'edit_profile.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    print(currentlyLoggedUser.name);
    return Scaffold(
      appBar: CustomAppBar(context),
      body: ListView(
      children: <Widget>[
        Text("Hello "+currentlyLoggedUser.name),
        Text("Your phone number : "+currentlyLoggedUser.phoneNumber),
        Text("Your email : "+currentlyLoggedUser.email)




      ],
    ),
    );
  }


  Widget CustomAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.red,
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.edit),
          onPressed: ((){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditProfile();
                },
                fullscreenDialog: false,
              ),
            );
          }),
        ),
      ],
      centerTitle: true,
      title: Text("User Profile"),
    );
  }

}