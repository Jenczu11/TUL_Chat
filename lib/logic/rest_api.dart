import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/constants.dart' as prefix0;
import 'package:tul_mobileapp/objects/task.dart';



List<Task> taskList = new List<Task>();


Future<Null> fetchDataFromDB() async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks.json";
  try{
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String,dynamic>;

    final List<Task> loadedTasks = [];
    if(extractedData!= null) {
      extractedData.forEach((taskId, taskData) {
        if(taskData['phoneNumber']!=prefix0.currentlyLoggedUser.phoneNumber)
        loadedTasks.add(Task(
            id: taskId,
            title: taskData['title'],
            description: taskData['description'],
            tags: taskData['tags'],
            email: taskData['email'],
            phoneNumber: taskData['phoneNumber'],
            isDone: taskData['isDone'],
            userAssigned: taskData['name']
        ));
      });
    }
    taskList = loadedTasks;
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
    "isDone" : false,
    "name" : _name,
    "phoneNumber" : _phoneNumber,
    "email" : _email

  }),).then((response) {
    taskList.add(new Task(id: json.decode(response.body)['name'],userAssigned: _name,phoneNumber: _phoneNumber,email: _email,tags: tags, description: description, isDone: false, title: titleValue));
  }
  );
}


Future<Null> patchDataDB(String userId,String _name, String _email, String _phoneNumber) async{
  print(userId);
  final url = "https://lut-mobileapp.firebaseio.com/users/${userId}/.json";
  http.patch(url, body: json.encode({
    "phoneNumber" : _phoneNumber,
    "name" : _name,
    "email" : _email
  }),).then((response) {
    currentlyLoggedUser.phoneNumber = _phoneNumber;
    currentlyLoggedUser.name = _name;
    currentlyLoggedUser.email = _email;
  });
}


//Future<Null> _signIn(String _phoneNumber) async{
//  final url = "https://lut-mobileapp.firebaseio.com/users.json";
//  bool _exists = false;
//  try{
//    final response = await http.get(url);
//    final extractedData = json.decode(response.body) as Map<String,dynamic>;
//    if(extractedData!=null) {
//      extractedData.forEach((userId, userData) {
//        print(userData['phoneNumber'].toString());
//        if (userData['phoneNumber'].toString() == _phoneNumber) {
//          _exists = true;
//          print("Already exists - do nothing ");
////          currentlyLoggedUser = new User(
////            id: userId,
////            phoneNumber: userData['phoneNumber'],
////            email: userData['email'],
////            name: userData['name'],
////          );
//        }
//      });
//    }
//  } catch(error){
//    throw (error);
//  }
//  if(_exists == false){
//    print("Dosen't exist - add to database");
//    http.post(url, body: json.encode({
//      "phoneNumber" : _phoneNumber,
//      "name" : "",
//      "email" : ""
//    }),).then((response) {
//      currentlyLoggedUser = new User(id:json.decode(response.body)['name'], phoneNumber: _phoneNumber,
//        email: "",
//        name: "",
//      );
//    }
//    );
//  }
//
//}



