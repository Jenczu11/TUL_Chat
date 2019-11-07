import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/objects/task.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:flutter_tags/tag.dart';
import 'package:tul_mobileapp/pages/chat.dart';

import 'myTasks.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Widget newTask;
  String titleValue = "";
  String description = "" ;
  LocationData currentLocation;
  var location = new Location();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () async {
          print(tags);
          if(tags.isEmpty){
            tags.add("");
          }
          await postDataToDB(
              titleValue,
              description,
              tags,
              currentlyLoggedUser.name,
              currentlyLoggedUser.phoneNumber,
              currentlyLoggedUser.email);
          await fetchDataFromDB();
          tags.clear();
          setState(() {
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
              maxLines: 3,
              onChanged: (String value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(height: 10,),
            Tags(
              key: tagStateKey,
              textField: TagsTextField(
                inputDecoration: InputDecoration(labelText: 'Tags'),
                textStyle: TextStyle(fontSize: 12),
                onSubmitted: (String str) {
                  // Add item to the data source.
                  setState(() {
                    // required
                    tags.add(str);
                  });
                },
              ),
              itemCount: tags.length, // required
              itemBuilder: (int index) {
                final item = tags[index];
                return ItemTags(
                  title: item,
                  key: Key(index.toString()),
                  index: index,
                  // required
                  textStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                  combine: ItemTagsCombine.withTextBefore,
                  removeButton: ItemTagsRemoveButton(),
                  onRemoved: () {
                    // Remove the item from the data source.
                    setState(() {
                      // required
                      tags.removeAt(index);
                    });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Null> getUsersLocation() async {
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
  }
}
