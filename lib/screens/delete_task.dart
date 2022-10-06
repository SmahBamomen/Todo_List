// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:todo_list/constants/colors.dart';
//
// class DeleteTasks extends StatelessWidget {
//
//   const DeleteTasks({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
// title: Text('Alert !! 🚨'),
//       content: Text('Are you sure to delete the task ? '),
//
//       actions: [
//         TextButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, child: Text('No',style: TextStyle(color: colorGrey),)),
//         TextButton(onPressed: (){
//           DocumentReference documentReference =
//           FirebaseFirestore.instance.collection("tasks").doc(snapshot.data!.docs[index].id);
//           documentReference.delete().whenComplete(() => print("deleted successfully"));
//
//         }, child: Text('Yes'))
//       ],
//     )
//   }
// }
