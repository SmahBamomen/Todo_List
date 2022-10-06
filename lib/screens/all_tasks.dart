
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:intl/intl.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  bool todoDone = false;
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
                            trailing: Container(
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
                                onPressed: () {

                                  DocumentReference documentReference =
                                  FirebaseFirestore.instance.collection("tasks").doc(snapshot.data!.docs[index].id);
                                  documentReference.delete().whenComplete(() => print("deleted successfully"));


                                },
                              ),
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
}
