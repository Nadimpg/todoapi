import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/view/screens/todo/todo_model.dart';

class TodoController extends GetxController {
  var TodoList = RxList<TodoModel>();
  bool isLoading=false;

  ///get todo
  Future<RxList<TodoModel>> getTodos() async {
    isLoading=true;
    update();

    final response = await http.get(
        Uri.parse("https://656abc47dac3630cf7274197.mockapi.io/api/todolist"));
    var data=jsonDecode(response.body.toString());
    // print("============> ${data}");
    if(response.statusCode ==200){
      update();
      for(Map<String,dynamic> index in data){
        TodoList.add(TodoModel.fromJson(index));
        print("============> ${TodoList.length}");
      }
      isLoading=false;
      update();
      return TodoList;

    }else{
      return TodoList;
    }
  }

  ///post todo
  Future<void> postTodos(title)async{
    final response=await http.post(
      Uri.parse("https://656abc47dac3630cf7274197.mockapi.io/api/todolist"),
      headers: {'Content-Type' : 'application/json'},
      body: json.encode(
        {"title" : title}
      )
    );
    if(response.statusCode ==200){
      print('Done');
      TodoList.clear();
      getTodos();
    }else{
      print('Failed');
    }
  }

  ///delete todo
  Future<void> deleteTodos(id)async{
    final response=await http.delete(
        Uri.parse("https://656abc47dac3630cf7274197.mockapi.io/api/todolist/$id"),
    );
    if(response.statusCode ==200){
      print('Done');
      TodoList.clear();
      getTodos();
      Fluttertoast.showToast(
          msg: "Deleted SuccessFully",
          backgroundColor: Colors.red,
          textColor: Colors.brown,
          fontSize: 16.0
      );
    }else{
      print('Failed');
      Fluttertoast.showToast(
          msg: "Deleted unSuccessFully",
          backgroundColor: Colors.red,
          textColor: Colors.brown,
          fontSize: 16.0
      );
    }

  /*  Fluttertoast.showToast(
        msg: "Deleted SuccessFully",
        backgroundColor: Colors.red,
        textColor: Colors.brown,
        fontSize: 16.0
    );*/
  }

  ///edit todo
  Future<void> editTodos(String title,String id)async{
    update();
    final response=await http.put(
        Uri.parse("https://656abc47dac3630cf7274197.mockapi.io/api/todolist/$id"),
        headers: {'Content-Type' : 'application/json'},
        body: json.encode(
            {"title" : title}
        )
    );
    if(response.statusCode ==200){
      print('update success');
      print('=============== ${title}');
      /*TodoList.clear();
      getTodos();*/
      update();
    }else{
      print('Failed');
    }
  }


  @override
  void onInit() {
    getTodos();
    super.onInit();
  }
}
