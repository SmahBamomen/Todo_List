import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Center(child: Text("To Do List")),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Task Name :'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter the Name of Task :'),

          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Date :'),
              IconButton(onPressed: () =>
              {
                showDialog(
                    context: context,
                    builder: (context) =>
                        DatePickerDialog(initialDate: DateTime(2023,10,4), firstDate: DateTime(2023), lastDate: DateTime(2024))
                )
              },
                icon: Icon(Icons.date_range_sharp),)
            ],
          )



        ],
      ),

      actions: [
        TextButton(onPressed: addToDo, child: Text('Add'))
      ],
    );
  }

  void addToDo(){
    Navigator.of(context).pop();
  }
}
