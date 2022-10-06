
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tasks").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {

                return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      elevation: 4,
                      child: Container(
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
                            (snapshot.data!.docs[index].data()["name"] != null)
                                ? snapshot.data!.docs[index].data()["name"]
                                : "",
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

                                // FirebaseFirestore.instance.collection("tasks").doc().
                                //     .delete();
                              },
                            ),
                          ),
                        ),
                      ),
                    ));
              });
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.red,
            ),
          ),
        );
      },
    );

  }
}
