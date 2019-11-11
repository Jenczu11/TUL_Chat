import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tul_mobileapp/logic/authentication.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:tul_mobileapp/pages/myTasks.dart';
import 'package:tul_mobileapp/pages/profile.dart';
import 'package:tul_mobileapp/pages/settings.dart';
import 'package:tul_mobileapp/constants.dart';

import 'chat.dart';
import 'createTask.dart';
class Home extends StatefulWidget {
  Home({Key key, this.auth, this.userId, this.userEmail, this.logoutCallback})
      : super(key: key);

  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;
  String userEmail;
  @override
  _HomeState createState() => _HomeState();
  
}

class _HomeState extends State<Home> {


  // Properties & Variables needed
  //var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
  int currentTab = 0; // to keep track of active tab index
  bool onNewTask = false;
  final List<Widget> screens = [
    Chat(),
    Profile(),
    Settings(),
    NewTask(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Chat();

  @override
  Widget build(BuildContext context) {
  fetchDataFromDB();  
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FlatButton.icon(onPressed: (() async {
              await signOut();
            }), icon: Icon(Icons.power_settings_new,color: Colors.red,), label: Text("Log Out"))
          ],
        ),
      ),
      //backgroundColor: currentColor,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.drafts),
        
        onPressed: () {
          setState(() {
                        currentScreen =
                            NewTask(); // if user taps on this dashboard tab will be active
                        currentTab = null;
                       
                      });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // fetchDataFromDB();
                      setState(() {
                        currentScreen =
                            Chat(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Chats',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MyTasks(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.list,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'My Tasks',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),


              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Profile(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Settings(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }


}
