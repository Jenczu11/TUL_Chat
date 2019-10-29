import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

import 'objects/task.dart';
import 'objects/user.dart';

TextEditingController phoneNumberController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailAddressController = TextEditingController();
User currentlyLoggedUser;
List<dynamic> tags = [];
final GlobalKey<TagsState> tagStateKey = GlobalKey<TagsState>();


String tagsToString(Task task){
  var result = "";
  if(task.tags.length!=null){
  for(int i = 0 ; i < task.tags.length ; i++){
    result += task.tags[i]+" ";
  }}
  return result;
}