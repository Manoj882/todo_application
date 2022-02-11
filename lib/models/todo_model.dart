import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{
  late String title;
  late String date;
  late bool isCompleted;

  TodoModel.fromjson(Map obj){
    title = obj['title'];
    date = (obj['date'] as Timestamp).toDate().toString();
    isCompleted = obj['isCompleted'];
  }

}