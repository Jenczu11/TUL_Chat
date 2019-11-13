import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Widget newTask;
  String titleValue = "";
  String description = "";
  SharedPreferences prefs;
  String id;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () async {
          print("Dodaje zadanie");
          print(titleValue);
          print(description);
          prefs = await SharedPreferences.getInstance();
          id = prefs.getString('id') ?? '';
          print(id);
          Firestore.instance.collection('tasks').add({
            'UserID': id,
            'taskTitle': titleValue,
            'taskDescription': description,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          });

          // var documentReference = Firestore.instance
          //     .collection('tasks')
          //     .document(id)
          //     .collection(id)
          //     .document(DateTime.now().millisecondsSinceEpoch.toString());

          // Firestore.instance.runTransaction((transaction) async {
          //   await transaction.set(
          //     documentReference,
          //     {
          //       'UserID': id,
          //       'taskTitle': titleValue,
          //       'taskDescription': description,
          //       'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          //     },
          //   );
          // }
          // );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: Text('Create help request'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (String value) {
                setState(() {
                  titleValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onChanged: (String value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
