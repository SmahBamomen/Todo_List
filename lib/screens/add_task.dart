import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskNameController = new TextEditingController();
   DateTime newDate = DateTime.now();
   var formatterDate ;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Center(child: Text("To Do List")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Task Name :'),
          TextField(
            controller: taskNameController,
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter the Name of Task :'),

          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Date :'),
              IconButton(onPressed: () async =>
              {
                showDialog(
                    context: context,
                    builder: (context) =>
                        DatePickerDialog(
                            initialDate: DateTime(2023,10,4),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2024))
                ).then((value) => {
                        setState((){
                          newDate = value;
                          formatterDate = DateFormat('yyyy-MM-dd').format(newDate);
                        })
                })

              },
                icon: Icon(Icons.date_range_sharp),)
            ],
          ),
          Text(formatterDate == null ? '' : formatterDate.toString())


        ],
      ),

      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Cancel')),
        TextButton(onPressed: addToDo, child: Text('Add'))
      ],
    );
  }

  void addToDo(){
    FirebaseFirestore.instance
        .collection('tasks')
        .add({'name':taskNameController.text,'date': newDate,'isDone':false });
    Navigator.of(context).pop();
  }
}
