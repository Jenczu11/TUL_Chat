import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:tul_mobileapp/constants.dart';

import 'package:tul_mobileapp/objects/task.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';

class NewTask extends StatefulWidget {
 
  @override
  _NewTaskState createState() => _NewTaskState();

}

class _NewTaskState extends State<NewTask> {
  Widget newTask;
  String titleValue = '';
  String description;
  String category;
  LocationData currentLocation;
  var location = new Location();


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () async{
          await postDataToDB(currentlyLoggedUser.name,currentlyLoggedUser.phoneNumber,currentlyLoggedUser.email);
          await fetchDataFromDB();
          setState(() {
                      taskList.add(Task(
                        title: titleValue,
                        description: description,
                        category: category

                      ));
                      });
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
            maxLines: 4,
            onChanged: (String value) {
              setState(() {
                description = value;
              });
            },
          ),
           TextField(
            decoration: InputDecoration(labelText: 'Category'),
            onChanged: (String value) {
              setState(() {
                category = value;
              });
            },
          ),
        ],
      ),
    ),);
  }

  Future<Null> postDataToDB(String _name, String _phoneNumber, String _email) async{
    final url = "https://lut-mobileapp.firebaseio.com/tasks.json";
    http.post(url, body: json.encode({
      "title" : titleValue,
      "description" : description,
      "category" : category,
      "isDone" : false,
      "name" : _name,
      "phoneNumber" : _phoneNumber,
      "email" : _email

    }),).then((response) {
      taskList.add(new Task(id: json.decode(response.body)['name'],userAssigned: _name,phoneNumber: _phoneNumber,email: _email,category: category, description: description, isDone: false, title: titleValue));
    }
    );
  }

  Future<Null> getUsersLocation() async{
        try {
      currentLocation = await location.getLocation();
    } on Exception {
        currentLocation = null;
      }
    }
  }



