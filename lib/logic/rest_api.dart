import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/constants.dart' as prefix0;
import 'package:tul_mobileapp/objects/task.dart';

import '../objects/user.dart';



List<Task> taskList = new List<Task>();
List<Task> myTasks = new List<Task>();
List<Task> taskListAssigned = new List<Task>();

Future<List<Task>> fetchDataFromDB() async{
  print("-------------------------");
  print("Fetching from DB");
  print("User Email: "+currentlyLoggedUser.email);
  print("-------------------------");
  final url = "https://lut-mobileapp.firebaseio.com/tasks.json";
  try{
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String,dynamic>;

    final List<Task> loadedTasks = [];
    final List<Task> myLoadedTasks = [];
    final List<Task> taskListLoadedAssigned =[];
    if(extractedData!= null) {
      // print(currentlyLoggedUser.email);
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
            userAssigned: taskData['userAssigned'],
            dateAdded: taskData['dataAdded'],
            dateAssigned: taskData['dateAssigned']
        ));
        }
        if((taskData['userAssigned'] == prefix0.currentlyLoggedUser.email))
          {
            print("W petli");
          taskListLoadedAssigned.add(Task(
              id: taskId,
              title: taskData['title'],
              description: taskData['description'],
              tags: taskData['tags'],
              email: taskData['email'],
              phoneNumber: taskData['phoneNumber'],
              isAssigned: taskData['isAssigned'],
              userAssigned: taskData['userAssigned'],
              dateAdded: taskData['dataAdded'],
              dateAssigned: taskData['dateAssigned']
          ));
        }
         if((taskData['email']==currentlyLoggedUser.email)){
          myLoadedTasks.add(Task(
              id: taskId,
              title: taskData['title'],
              description: taskData['description'],
              tags: taskData['tags'],
              email: taskData['email'],
              phoneNumber: taskData['phoneNumber'],
              isAssigned: taskData['isAssigned'],
              userAssigned: taskData['userAssigned'],
              dateAdded: taskData['dataAdded'],
              dateAssigned: taskData['dateAssigned']
          ));
          // print(prefix0.currentlyLoggedUser.id);
        }
          
      });
    }
    taskListAssigned = taskListLoadedAssigned;
    taskList = loadedTasks;
    myTasks = myLoadedTasks;
    return taskList;
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



Future<Null> patchDataDB(String dbId,String _name, String _phoneNumber) async{
  print(dbId);
  final url = "https://lut-mobileapp.firebaseio.com/users/${dbId}/.json";
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
        if ((userData['email'].toString() == _email)) {
          currentlyLoggedUser.dbId =userId;
          currentlyLoggedUser.name = userData['name'];
          currentlyLoggedUser.phoneNumber = userData['phoneNumber'];
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
    })).then((response) {
      print(response);
    });
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



