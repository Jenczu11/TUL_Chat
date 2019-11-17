import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'const.dart';

QuerySnapshot cache;

// import 'package:tul_mobileapp/logic/authentication.dart';
// import 'package:url_launcher/url_launcher.dart';
class MyTasks extends StatefulWidget {
  MyTasks({Key key}) : super(key: key);

  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  SharedPreferences prefs;
  String id;
  var list;

  @override
  void initState() {
    super.initState();
    _getIdfromSharedPref();
    // _getMarker();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Task: ${document['taskTitle']}',
                        // style: TextStyle(color: primaryColor),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        'Task Description: ${document['taskDescription'] ?? 'Not available'}',
                        // style: TextStyle(color: primaryColor),
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
        color: greyColor2,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
            onPressed: () {
              //TODO : destroy task
              _showDialog(document);
            },
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: "My tasks",
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)],
          context: context,
        ),
        body: StreamBuilder(
          initialData: cache,
          stream: Firestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                ),
              );
            cache = snapshot.data;
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.documents[index]['UserID'] == id) {
                    // print(index);
                    return _buildListItem(
                        context, snapshot.data.documents[index]);
                  } else
                    return SizedBox
                        .shrink(); // <--- to dodałem bo takto listview builder wysypywał się bo przelatywał index a nic nie zwracał + build musi coś zwracać więc mamy sizedbox XD
                });
          },
        ));
  }

  _getIdfromSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
  }

  void _showDialog(DocumentSnapshot document) {
    String taskID = document.documentID;
    String taskTitle = document['taskTitle'];
    String taskTimeStamp = document['timeStamp'];
    String taskDescription = document['taskDescription'];
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Task ?"),
          content: new Text("TaskID ${taskID}\nTaskTitle ${taskTitle}\nTaskDescription ${taskDescription}\n"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Remove Task"),
              onPressed: () {
                Navigator.of(context).pop();
                Firestore.instance.collection('tasks').document(taskID).delete();

              },
            ),
            new FlatButton(
              child: new Text("Dismiss Task"),
              onPressed: () {
                Navigator.of(context).pop();
                // TODO:
                // Jak wcisinie usunac z listy i polaczyc uzytkownikow
                // Firestore.instance.collection("users").document()
                // List<String> ids = <String>[];
                // ids.add(userID); 
                // List<String> ids1 = <String>[];
                // ids1.add(id); 
                // To polecenie usuwa odpowiedni userID z userow
                // Firestore.instance.collection("users").document(id).updateData({"ableToChatWith": FieldValue.arrayRemove(ids)});
                // Firestore.instance.collection("users").document(userID).updateData({"ableToChatWith": FieldValue.arrayRemove(ids1)});
                // Firestore.instance.collection("users").document(id).updateData({"ableToChatWith": ids});
              },
            ),
          ],
        );
      },
    );
  }
  // _getMarker() async {
  // QuerySnapshot querySnapshot =
  // await Firestore.instance.collection("tasks").getDocuments();
  // var list = querySnapshot.documents;
  // String id = "jztSXrgaVEanDrsR89dnp4yK7qE3";
  // print(list.length);
  // print(list[0].data.toString());
  // list[0]
  // Firestore.instance.collection("tasks").document(id).collection(collectionPath)
  // print(list[0]);
  // Firestore.instance
  //     .collection("tasks")
  //     .getDocuments()
  //     .then((QuerySnapshot snapshot) {
  //   snapshot.documents.forEach((f) => print('${f.data}}'));
  // });
  // Firestore.instance.collection("tasks").snapshots().listen((snapshot) {
  //   snapshot.documents.forEach((doc) => debugPrint(doc.data.toString()));
  // });

  // return list;
  // }
}
