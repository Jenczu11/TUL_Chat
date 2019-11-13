import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:tul_mobileapp/logic/authentication.dart';
// import 'package:url_launcher/url_launcher.dart';
class BountyBoard extends StatefulWidget {
  BountyBoard({Key key}) : super(key: key);

  @override
  _BountyBoardState createState() => _BountyBoardState();
}

class _BountyBoardState extends State<BountyBoard> {
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
    return ListTile(
        title: Row(
      children: <Widget>[
        Expanded(
          child: Text(document['taskDescription']),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: "Bounty Board",
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)],
          context: context,
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (!snapshot.hasData) return const Text('loading...');
            return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.documents[index]['UserID'] != id)
                    return _buildListItem(
                        context, snapshot.data.documents[index]);
                });
          },
        ));
  }

  _getIdfromSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
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