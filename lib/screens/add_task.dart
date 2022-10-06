import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/constants/colors.dart';
class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskNameController = new TextEditingController();
   DateTime newDate = DateTime.now();
   var formatterDate ;
   String errorText = '';
  var errorIcon;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Center(child: Text("To Do List",style: TextStyle(fontWeight: FontWeight.w600,color: colorBlack),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Task Name :',style: TextStyle(fontWeight: FontWeight.w600,color: colorLightGreen),),
          TextField(
            controller: taskNameController,
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter the Name of Task ',hintStyle: TextStyle(fontSize: 10)),

          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Date :',style: TextStyle(fontWeight: FontWeight.w600,color: colorLightGreen),),
              IconButton(onPressed: () async =>
              {
                showDialog(
                    context: context,
                    builder: (context) =>
                        DatePickerDialog(
                            initialDate: DateTime(2022,10,4),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2024))
                ).then((value) => {
                        setState((){
                          newDate = value;
                          formatterDate = DateFormat('yyyy-MM-dd').format(newDate);
                        })
                })

              },
                icon: Icon(Icons.date_range_sharp,size: 20,color: colorVanila,),)
            ],
          ),
          Text(formatterDate == null ? '' : formatterDate.toString(),style: TextStyle(fontSize:14,color: colorBlack),)
        ,
          Row(
          children: [
            errorIcon == null ? Container() :taskNameController.text.isNotEmpty && formatterDate != null ?Container():errorIcon,
          //taskNameController.text.isNotEmpty && formatterDate != null ? Container(): Icon(Icons.error_outline_sharp,size: 14,color: colorRed,),
            SizedBox(width: 10),
            Text(taskNameController.text.isNotEmpty && formatterDate != null ? '': errorText,style: TextStyle(fontSize: 12,color: colorRed ,),),
          ],
        ),

        ],
      ),

      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Cancel',style: TextStyle(color: colorGrey),)),
        TextButton(onPressed: addToDo, child: Text('Add'))
      ],
    );
  }

   void addToDo(){


       if(taskNameController.text.isNotEmpty && formatterDate != null)
       {

         FirebaseFirestore.instance
             .collection('tasks')
             .add({'name':taskNameController.text,'date': newDate,'isDone':false });
         Navigator.of(context).pop();




       }
       else{
         setState((){
           errorIcon = Icon(Icons.error_outline_sharp,size: 14,color: colorRed,);
           errorText = 'Please fill all information';
         });

       }



  }
}
