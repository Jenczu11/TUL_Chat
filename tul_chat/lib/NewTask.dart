import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'appbar.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Widget newTask;
  final TextEditingController titleValue = new TextEditingController();
  final TextEditingController description = new TextEditingController();
  final TextEditingController fieldOfStudy = new TextEditingController();
  String yearOfStudy = null ;
  String deparment = null;
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
          prefs = await SharedPreferences.getInstance();
          id = prefs.getString('id') ?? '';
          print(id);
          Firestore.instance.collection('tasks').add({
            'UserID': id,
            'taskTitle': titleValue.text,
            'taskDescription': description.text,
            'department': deparment,
            'fieldOfStudy': fieldOfStudy.text,
            'yearOfStudy': yearOfStudy,
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
          titleValue.clear();
          description.clear();
          fieldOfStudy.clear();
          deparment = null;
          yearOfStudy = null;
          setState(() {

          });
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: BaseAppBar(
        title: "Create new help request",
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
        context: context,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: titleValue,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: description,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 5.0,),
            new DropdownButton<String>(
              icon: Icon(Icons.account_balance),
              hint: Text("Deparment  "),
              value: deparment,
              items: <String>['FTIMS', 'EIIA', 'WIPOS', 'BINOZ','ZIIP',"Mechaniczny","Chemiczny","WTMIWT","BAIS",].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                this.deparment = value;
                setState(() {
                });
              },
            ),
            SizedBox(height: 5.0,),
            TextField(
              controller: fieldOfStudy,
              decoration: InputDecoration(labelText: 'Field of study'),
              maxLines: 1,
            ),
            new DropdownButton<String>(
              icon: Icon(Icons.timeline),
              hint: Text("Year of study  "),
              value: yearOfStudy,
              items: <String>["1 ", '2', '3', '4','5',].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                this.yearOfStudy = value;
                setState(() {
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
