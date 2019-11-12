class Task{
  final String id;
  final String title;
  final String description;
  final List<dynamic> tags;
  bool isAssigned;
  final String dateAdded;
  String dateAssigned;
  String userAssigned;
  final String email;
  String phoneNumber;

  Task({this.id,this.title,this.description,this.tags,this.isAssigned,this.userAssigned,this.email,this.phoneNumber,this.dateAdded,this.dateAssigned});

}