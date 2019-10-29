import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/constants.dart' as prefix0;

import 'package:tul_mobileapp/objects/task.dart';



List<Task> taskList = new List<Task>();
List<Task> userTaskList = new List<Task>();

Future<Null> fetchDataFromDB() async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks.json";
  try{
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String,dynamic>;

    final List<Task> loadedTasks = [];
    final List<Task> loadedUsersTasks = [];
    if(extractedData!= null) {
      extractedData.forEach((taskId, taskData) {
        if(taskData['phoneNumber']!=currentlyLoggedUser.phoneNumber) {
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
        }
        else if(taskData['phoneNumber'] == currentlyLoggedUser.phoneNumber){
          loadedUsersTasks.add(Task(
              id: taskId,
              title: taskData['title'],
              description: taskData['description'],
              tags: taskData['tags'],
              email: taskData['email'],
              phoneNumber: taskData['phoneNumber'],
              isDone: taskData['isDone'],
              userAssigned: taskData['name']
          ));
        }
      });
    }
    taskList = loadedTasks;
    userTaskList = loadedUsersTasks;
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


Future<Null> deleteTask(Task task) async{
  final url = "https://lut-mobileapp.firebaseio.com/tasks/${task.id}.json";
  http.delete(url,).then((response) {
    userTaskList.remove(task);
  }
  );
}

