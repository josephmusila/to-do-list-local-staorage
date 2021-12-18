import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator/controller/taskController.dart';
import 'package:navigator/database/databaseHelper.dart';
class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}



class _TaskPageState extends State<TaskPage> {
  var taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My tasks"),
          centerTitle: true,
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            color: Colors.blue,
            child: FutureBuilder<List>(
              future: DataBaseHelper.instance.getAllRecords("tasks"),

              builder: (context,snapshot){
                if(snapshot.hasData==true){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        final item=snapshot.data![index];
                        return Card(

                          child: ListTile(
                            leading: Text(snapshot.data![index].row[2]),
                            title: Text(snapshot.data![index].row[1]),
                            trailing: Icon(Icons.delete,color: Colors.red,

                            ),
                            onTap: () async{
                              await DataBaseHelper.instance.delete(item.row[0]);
                              setState(() {

                              });
                              Get.snackbar("Task deleted", "",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);

                            },
                          ),
                        );
                      });
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
              ,
            )
        ),
    );
  }
}
