
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/appbar.dart';
import 'package:flutter_chat_demo/chat.dart';
import 'package:flutter_chat_demo/const.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class ChatRooms extends StatefulWidget {
  final String currentUserId;
  List<dynamic> ableToChatWith = new List();
  ChatRooms({Key key, @required this.currentUserId}) : super(key: key);

  @override
  State createState() => ChatRoomsState(currentUserId: currentUserId);
}

class ChatRoomsState extends State<ChatRooms> {
  ChatRoomsState({Key key, @required this.currentUserId});

  final String currentUserId;
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  List<dynamic> ableToChatWith = new List();
  bool isLoading = false;
  
  @override
  void initState() {
    
    super.initState();
    registerNotification();
    configLocalNotification();
    // _getData();
  }
  void _getData() async 
  {
    DocumentReference documentReference = await Firestore.instance.collection("users").document(currentUserId);
            documentReference.get().then((datasnapshot) {
              if (datasnapshot.exists) {
                print(datasnapshot.data['ableToChatWith'].toString());
                ableToChatWith = datasnapshot.data['ableToChatWith'];
              }
              else{
                 print("No such user");
              }

  });
  }
  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      Firestore.instance
          .collection('users')
          .document(currentUserId)
          .updateData({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.kkbj.tulapp' : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }
  // void _getData
  @override
  Widget build(BuildContext context) {
    // print(Firestore.instance.collection("users").document(currentUserId).toString());
    // QuerySnapshot querySnapshot =
  //  await Firestore.instance.collection("users").getDocuments();
  // var list = querySnapshot.documents;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Help Chat",
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
        context: context,
      ),
      body: Stack(
        children: <Widget>[
          // List
          Container(
            child: StreamBuilder(
              stream:  Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                return StreamBuilder(
                  stream: Firestore.instance.collection('users').snapshots(),
                builder: (context,snapshot){
                  if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                  );
                } else {
                  
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) {
                      if(snapshot.data.documents[index]['id'].toString()==currentUserId)
                      {
                        print("yes");
                          ableToChatWith = snapshot.data.documents[index]['ableToChatWith'];
                      }
                        return buildItem(context, snapshot.data.documents[index]);
                    },
                    
                    itemCount: snapshot.data.documents.length,
                  );
                }
                },);
                }
                
            ),
          ),

          // Loading
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          )
        ],

        // onWillPop: onBackPress,
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    // DocumentReference documentReference = Firestore.instance.collection("users").document(currentUserId);
    //         documentReference.get().then((datasnapshot) {
    //           if (datasnapshot.exists) {
    //             print(datasnapshot.data['ableToChatWith'].toString());
    //             ableToChatWith = datasnapshot.data['ableToChatWith'];
    //           }
    //         };
    // print("userID: "+document['id']);
    if (document['id'] == currentUserId) {
      return Container();
    } else {

      // print(ableToChatWith.toString());
      // //  print("abletoChat: "+document['ableToChatWith'].toString());
      // // if(document['id'] == currentUserId && document['ableToChatWith'].toString().includes)
      if(ableToChatWith.length>0){
      for(var peerID in ableToChatWith)
      {
        print(document['id'].toString()+":"+peerID.toString());
        if(peerID.toString() == document['id'].toString()){
        return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: document['photoUrl'] != null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          width: 50.0,
                          height: 50.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: document['photoUrl'],
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: greyColor,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Nickname: ${document['nickname']}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'About me: ${document['aboutMe'] ?? 'Not available'}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          peerId: document.documentID,
                          peerAvatar: document['photoUrl'],
                        )));
          },
          color: greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
  }
return Container();
      } 
//       // print("-----------------------------------");
    
  }
}