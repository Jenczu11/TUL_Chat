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
  String AssignedUser = null;
  SharedPreferences prefs;
  String id;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('Add'),
            onPressed: () async {
              print("Dodaje zadanie");
              prefs = await SharedPreferences.getInstance();
              id = prefs.getString('id') ?? '';
              print(id);
              if((!(titleValue.text.length>=5) && (titleValue.text.isNotEmpty)) ||(titleValue.text.isEmpty) || (titleValue.text.contains("  "))){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Couldn't add new task\nTitle value has to consists of at least 5 characters"),
                  duration: Duration(seconds: 3),
                ));
              }
              else if((!(description.text.length>=10) && (description.text.isNotEmpty)) ||(description.text.isEmpty) || (description.text.contains("  "))){
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Couldn't add new task\nDescription has to consists of at least 10 characters"),
                    duration: Duration(seconds: 3),
                ));
              }else if((!(fieldOfStudy.text.length>=5) && (fieldOfStudy.text.isNotEmpty)) ||(fieldOfStudy.text.isEmpty) || (fieldOfStudy.text.contains("  "))){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Couldn't add new task\n Field of study has to consists of at least 5 characters"),
                  duration: Duration(seconds: 3),
                ));
              }else if(deparment == null){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Couldn't add new task\n Please select department"),
                  duration: Duration(seconds: 3),
                ));
              }else if(yearOfStudy == null){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Couldn't add new task\n Please select year of study"),
                  duration: Duration(seconds: 3),
                ));
              }
              else{
                Firestore.instance.collection('tasks').add({
                  'UserID': id,
                  'taskTitle': titleValue.text,
                  'taskDescription': description.text,
                  'department': deparment,
                  'fieldOfStudy': fieldOfStudy.text,
                  'yearOfStudy': yearOfStudy,
                  'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                  'AssignedUser': ""
                });
                titleValue.clear();
                description.clear();
                fieldOfStudy.clear();

                deparment = null;
                yearOfStudy = null;

              }
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

              setState(() {

              });
              },
          );
        }
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
            TextFormField(
              controller: titleValue,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Title",
              ),
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
