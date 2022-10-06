import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/screens/add_task.dart';
class TodayTasks extends StatefulWidget {
  const TodayTasks({Key? key}) : super(key: key);

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  TextEditingController taskNameController = new TextEditingController();
  DateTime newDate = DateTime.now();
  var formatterDate ;
  String errorText = '';
  var errorIcon;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tasks").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('OPS ! ');
        } else if (snapshot.hasData || snapshot.data != null) {

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {

                if( DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(
                  snapshot.data!.docs[index].data()["date"].millisecondsSinceEpoch,
                  isUtc: false,
                ).toUtc()).toString()){
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: ListTile(
                            onTap: () {

                              setState(() {

                                if  ( snapshot.data!.docs[index].data()["isDone"] == false ){
                                  DocumentReference documentReference =
                                  FirebaseFirestore.instance.collection("tasks").doc(snapshot.data!.docs[index].id);
                                  documentReference.update({"isDone": true});
                                }
                                else {
                                  DocumentReference documentReference =
                                  FirebaseFirestore.instance.collection("tasks").doc(snapshot.data!.docs[index].id);
                                  documentReference.update({"isDone": false});
                                }

                              });

                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            tileColor: Colors.white,
                            leading: Icon(
                                snapshot.data!.docs[index].data()["isDone"] ? Icons.check_box : Icons.check_box_outline_blank,
                                color: colorLightGreen
                            ),
                            title: Text(
                              (snapshot.data!.docs[index].data()["name"] != null)
                                  ? snapshot.data!.docs[index].data()["name"]
                                  : "",
                              style: TextStyle(
                                fontSize: 16,
                                color: colorBlack,
                                decoration: snapshot.data!.docs[index].data()["isDone"] ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(0),
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                    color: colorWhite,
                                    iconSize: 18,
                                    icon: Icon(Icons.edit),
                                    onPressed: (){

                                      showDialog(context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext cxt) {
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
                                                    decoration: InputDecoration(hintText: snapshot.data!.docs[index].data()["name"],hintStyle: TextStyle(fontSize: 10)),

                                                  ),


                                                ],
                                              ),

                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                }, child: Text('Cancel',style: TextStyle(color: colorGrey),)),
                                                TextButton(onPressed: (){

                                                  DocumentReference documentReference =
                                                  FirebaseFirestore.instance.collection("tasks").doc(snapshot.data!.docs[index].id);
                                                  documentReference.update({"name": taskNameController.text});
                                                  Navigator.of(context).pop();
                                                }, child: Text('Edit'))
                                              ],
                                            );;
                                          });

                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(0),
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: colorRed,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                    color: colorWhite,
                                    iconSize: 18,
                                    icon: Icon(Icons.delete),
                                    onPressed: (){

                                          showDialog(context: context, builder: (context) =>   AlertDialog(
                                            title: Text('Alert !! 🚨',style: TextStyle(color: colorRed)),
                                            content: Text('Are you sure to delete the task ? ',style: TextStyle(color: colorLightGreen)),

                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              }, child: Text('No',style: TextStyle(color: colorGrey),)),
                                              TextButton(onPressed: (){
                                                DocumentReference documentReference =
                                                FirebaseFirestore.instance.collection("tasks").doc(snapshot.data!.docs[index].id);
                                                documentReference.delete().whenComplete(() => print("deleted successfully"));
                                                Navigator.of(context).pop();
                                              }, child: Text('Yes'))
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                }



                else{
                  return Container();
                }
              }


          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              colorLightGreen,
            ),
          ),
        );

      },

    );
  }
  Future openAddDialog() =>
      showDialog(context: context, builder: (context) => AddTask());
}
