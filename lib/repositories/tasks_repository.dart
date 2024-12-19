

import 'dart:convert';

import 'package:mais_org/entities/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksRepository {

late  SharedPreferences sharedPreferences;

static String tasksListKey='tasks_list';

 void saveTasksList(List<Task> tasks){
    final jsonString= json.encode(tasks);
    sharedPreferences.setString(tasksListKey, jsonString);
  
 }

 Future<List<Task>> getTasksList()async{
   sharedPreferences= await SharedPreferences.getInstance(); 
   final String jsonString=sharedPreferences.getString(tasksListKey)?? '[]';
   final List jsonDecode=json.decode(jsonString) as List;
   return jsonDecode.map((e)=>Task.fromJson(e)).toList();
 }



}