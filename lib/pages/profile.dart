import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'package:tul_mobileapp/constants.dart';

import 'edit_profile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {   
    final String imgUrl =
        'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new Stack(
      children: <Widget>[
        new Container(
          color: Colors.white,
        ),
        new Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
        new BackdropFilter(
            filter: new ui.ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )),
        new Scaffold(
            appBar: CustomAppBar(context),
            backgroundColor: Colors.transparent,
            body: new Center(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: _height / 12,
                  ),
                  new CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  new SizedBox(
                    height: _height / 25.0,
                  ),
                  new Text(
                    currentlyLoggedUser.name,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.black),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    child: new Text(
                      //Wymienic na opis uzytkownika
                      'Snowboarder, Superhero and writer.\nSometime I work at google as Executive Chairman ',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        left: _width / 8, right: _width / 8),
                    child: new FlatButton(
                      onPressed: () {},
                      child: new Container(
                          child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.email),
                          new SizedBox(
                            width: _width / 30,
                          ),
                          new Text(currentlyLoggedUser.email)
                        ],
                      )),
                      color: Colors.red[50],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        left: _width / 8, right: _width / 8),
                    child: new FlatButton(
                      onPressed: () {},
                      child: new Container(
                          child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.phone),
                          new SizedBox(
                            width: _width / 30,
                          ),
                          new Text(currentlyLoggedUser.phoneNumber)
                        ],
                      )),
                      color: Colors.red[50],
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }



  Widget CustomAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.red,
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.edit),
          onPressed: (() {
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
