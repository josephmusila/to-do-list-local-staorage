import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator/database/databaseHelper.dart';
import 'package:navigator/model/Model.dart';
import 'package:navigator/view/homePage.dart';
import 'package:navigator/view/taskPage.dart';

class TaskController extends GetxController{
  var taskNameController=TextEditingController();
  var category=TextEditingController();
  var priority=TextEditingController();
  DateTime currentDate=DateTime.now();
  var taskList=[].obs;
  var count=0.obs;


  void queryTasks() async{
    List<Map<String,dynamic>> queryRows= await DataBaseHelper.instance.queryAll();
    taskList.value=queryRows;
    print(taskList);
  }


  void validation() {
    if (taskNameController.text.isEmpty) {
      errorSnackBar(msg: "Fill in the task field");
    } else if (category.text.isEmpty) {
      errorSnackBar(msg: "Fill in the category field");
    } else if (priority.text.isEmpty) {
      errorSnackBar(msg: "Fill in the priority field");
    }else{

      Get.to(TaskPage());
    }
  }
  void errorSnackBar({required String msg}){
    return Get.snackbar(
    "$msg", "Error",backgroundColor: Colors.red
    );
  }


}