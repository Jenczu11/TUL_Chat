import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/constants.dart' as prefix0;
import 'package:tul_mobileapp/objects/task.dart';

import '../objects/user.dart';



List<Task> taskList = new List<Task>();
List<Task> myTasks = new List<Task>();

Future<Null> fetchDataFromDB() async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks.json";
  try{
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String,dynamic>;

    final List<Task> loadedTasks = [];
    final List<Task> myLoadedTasks = [];
    if(extractedData!= null) {
      extractedData.forEach((taskId, taskData) {
       // if((taskData['email']!=currentlyLoggedUser.email) && (taskData['isAssigned'] == false)){
        if((taskData['email']!=currentlyLoggedUser.email)){
        loadedTasks.add(Task(
            id: taskId,
            title: taskData['title'],
            description: taskData['description'],
            tags: taskData['tags'],
            email: taskData['email'],
            phoneNumber: taskData['phoneNumber'],
            isAssigned: taskData['isAssigned'],
            userAssigned: taskData['name'],
            dateAdded: taskData['dataAdded'],
            dateAssigned: taskData['dateAssigned']
        ));
        }
        else{
          myLoadedTasks.add(Task(
              id: taskId,
              title: taskData['title'],
              description: taskData['description'],
              tags: taskData['tags'],
              email: taskData['email'],
              phoneNumber: taskData['phoneNumber'],
              isAssigned: taskData['isAssigned'],
              userAssigned: taskData['name'],
              dateAdded: taskData['dataAdded'],
              dateAssigned: taskData['dateAssigned']
          ));
        }
      });
    }
    taskList = loadedTasks;
    myTasks = myLoadedTasks;
  } catch(error){
    throw (error);
  }

}


Future<Null> postDataToDB(String titleValue, String description, List<dynamic> tags, String _name, String _phoneNumber, String _email) async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks.json";
  http.post(url, body: json.encode({
    "title" : titleValue,
    "description" : description,
    "tags" : tags,
    "isAssigned" : false,
    "name" : _name,
    "phoneNumber" : _phoneNumber,
    "email" : _email,
    "dateAdded" : DateTime.now().toIso8601String(),
    "userAssigned" : "",
    "dateAssigned" : ""

  }),).then((response) {
    myTasks.add(new Task(id: json.decode(response.body)['name'],userAssigned: _name,phoneNumber: _phoneNumber,email: _email,tags: tags, description: description, isAssigned: false, title: titleValue,dateAdded: DateTime.now().toIso8601String(),dateAssigned: null));
  }
  );
}


Future<Null> patchDataDB(String userId,String _name, String _phoneNumber) async{
  print(userId);
  final url = "https://lut-mobileapp.firebaseio.com/users/${userId}/.json";
  http.patch(url, body: json.encode({
    "phoneNumber" : _phoneNumber,
    "name" : _name,
  }),).then((response) {
    currentlyLoggedUser.phoneNumber = _phoneNumber;
    currentlyLoggedUser.name = _name;
  });
}

Future<Null> assignUserToTask(String taskId,String userEmail) async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks/${taskId}/.json";
  http.patch(url, body: json.encode({
    "userAssigned" : userEmail,
    "dateAssigned" : DateTime.now().toIso8601String(),
    "isAssigned" : true
  }),).then((response) {
    for(int i = 0 ; i < taskList.length; i++){
      if(taskList[i].id == taskId){
        taskList[i].dateAssigned = DateTime.now().toIso8601String();
        taskList[i].userAssigned = userEmail;
        taskList[i].isAssigned = true;
      }
    }
  });
}


Future<Null> signIn(String _email) async{
  final url = "https://lut-mobileapp.firebaseio.com/users.json";
  bool _exists = false;
  try{
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    if(extractedData!=null) {
      extractedData.forEach((userId, userData) {
        print(userData['email'].toString());
        if (userData['email'].toString() == _email) {
          _exists = true;
          print("Already exists - do nothing ");
        }
      });
    }
  } catch(error){
    throw (error);
  }
  if(_exists == false){
    print("Dosen't exist - add to database");
    http.post(url, body: json.encode({
      "phoneNumber" : "",
      "name" : "",
      "email" : _email
    }));
  }

}

Future<Null> deleteTask(String taskId) async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks/${taskId}/.json";
  http.delete(url,).then((response) {
    for(int i = 0 ; i < myTasks.length; i++){
      if(myTasks[i].id == taskId){
        myTasks.removeAt(i);
      }
    }
  });
}



