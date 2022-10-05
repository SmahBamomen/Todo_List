
import 'package:flutter/material.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  bool todoDone = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          setState(() {
            if(todoDone == true){
              todoDone = false;
            }
            else {
              todoDone = true;
            }

          });

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todoDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.grey,
        ),
        title: Text(
          "test",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: todoDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {

              // onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
