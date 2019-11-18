import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/const.dart';

import 'jencz_page.dart';
import 'kowal_page.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "About us",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30.0),
          Center(
            child: Text(
              "AUTHORS",
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
          ),
          SizedBox(height: 50,),
          ListTile(
            leading: Icon(Icons.person,size: 54.0,color: themeColor,),
            title: Text("Bartłomiej Jencz",style: TextStyle(fontSize: 32),),
            subtitle: Text("FTIMS STUDENT"),
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Jencz()),
              );
            }),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.person,size: 54.0,color: themeColor,),
            title: Text("Krystian Kowalski",style: TextStyle(fontSize: 32),),
            subtitle: Text("FTIMS STUDENT"),
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Kowal()),
              );

            }),
          ),

          //    Text("Phone Number :"+ "",textAlign: TextAlign.left,style: TextStyle(color: darkGrey,fontWeight: FontWeight.bold,fontSize: 16.0),),
        ],
      ),
    );
  }
}
