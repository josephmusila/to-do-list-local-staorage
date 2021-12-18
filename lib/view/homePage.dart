import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator/controller/taskController.dart';
import 'package:navigator/database/databaseHelper.dart';
import 'package:navigator/view/taskPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskController=Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("My Todo List"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        color: Colors.pink,
        child:Wrap(
          spacing: 10,
          runSpacing: 20,

          children: [
            TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              controller: taskController.taskNameController,
              decoration: InputDecoration(

                  labelText: "Task",
                  hintText: "Task name",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  )
              ),
            ),
            TextFormField(
              controller: taskController.category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                labelText: "Category",
                hintText: "Category",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue
                  )
                )
              ),
            ),
            TextFormField(
              controller: taskController.priority,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  labelText: "Priority",
                  hintText: "Priority",
                  focusedBorder:
                  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  )
              ),
            ),
            ListTile(
              leading: Text("Date Set",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              hoverColor: Colors.blue,
              trailing: Icon(Icons.date_range,color: Colors.white,),
              onTap: (){
                _selectDate(context);
              },
            ),
            // ignore: deprecated_member_use
            Center(
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Add Task"),
                  onPressed: ()async{
                    taskController.validation();
                    int i=await DataBaseHelper.instance.insert({
                      DataBaseHelper.columnname: taskController.taskNameController.text,
                      DataBaseHelper.columnCategory:taskController.category.text,
                      DataBaseHelper.columnPriorities:taskController.priority.text
                    });
                    print("the inserted id is $i");

                  }),

            ),
            Center(
              // ignore: deprecated_member_use
              child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("View Tasks"),
                  onPressed: (){
                    Get.to(TaskPage());
                  }),

            ),


          ],
        ) ,
      ),
    );
  }
  Future<void> _selectDate(BuildContext context)async{
    final DateTime? picked=await showDatePicker(
        context: context,
        initialDate: taskController.currentDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2025)
    );
    if(picked !=null && picked !=taskController.currentDate){
      setState(() {
        taskController.currentDate=picked;
        print(taskController.currentDate);
      });
    }
  }
}
