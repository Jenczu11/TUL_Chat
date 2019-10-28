import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tul_mobileapp/constants.dart';

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
        loadedTasks.add(Task(
            id: taskId,
            title: taskData['title'],
            description: taskData['description'],
            category: taskData['category'],
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

