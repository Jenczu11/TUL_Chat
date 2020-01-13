import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/AcceptedTasks.dart';
import 'package:flutter_chat_demo/BountyBoard.dart';
import 'package:flutter_chat_demo/NewTask.dart';
import 'package:flutter_chat_demo/main.dart';
import 'package:flutter_chat_demo/user_profile.dart';

import 'ChatRooms.dart';
import 'MyTasks.dart';
import 'chat.dart';
import 'const.dart';

class Home extends StatefulWidget {
  final String currentUserId;
  Home({Key key, @required this.currentUserId}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(currentUserId: currentUserId);
}

class _HomeState extends State<Home> {
  _HomeState({Key key, @required this.currentUserId});
  final String currentUserId;
  
  @override
  void initState() {
    print("----- home init State -----");
    // fetchDataFromDB();
    super.initState();
  }

  // Properties & Variables needed
  //var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
  int currentTab = 0; // to keep track of active tab index
  bool onNewTask = false;
  final List<Widget> screens = [
    ChatRooms(),
    NewTask(),
    BountyBoard(),
    MyTasks(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = BountyBoard();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));
    return
      WillPopScope(onWillPop: () async => false,child:Scaffold(
      //backgroundColor: currentColor,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            currentScreen = NewTask();
            // if user taps on this dashboard tab will be active
            currentTab = null;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
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
                        currentScreen = BountyBoard();
                        // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 0 ? themeColor : Colors.grey,
                        ),
                        Text(
                          ' Tasks List ',
                          style: TextStyle(
                            color: currentTab == 0 ? themeColor : Colors.grey,
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
                          color: currentTab == 1 ? themeColor : Colors.grey,
                        ),
                        Text(
                          'My Tasks',
                          style: TextStyle(
                            color: currentTab == 1 ? themeColor : Colors.grey,
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
                        currentScreen = AcceptedTasks(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? themeColor : Colors.grey,
                        ),
                        Text(
                          'Accepted',
                          style: TextStyle(
                            color: currentTab == 2 ? themeColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ChatRooms(
                            currentUserId:
                                currentUserId); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          color: currentTab == 3 ? themeColor : Colors.grey,
                        ),
                        Text(
                          'Help Chat',
                          style: TextStyle(
                            color: currentTab == 3 ? themeColor : Colors.grey,
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
      ));
  }
}
