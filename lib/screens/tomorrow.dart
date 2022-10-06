
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:intl/intl.dart';
class TomorrowTasks extends StatefulWidget {
  const TomorrowTasks({Key? key}) : super(key: key);

  @override
  State<TomorrowTasks> createState() => _TomorrowTasksState();
}

class _TomorrowTasksState extends State<TomorrowTasks> {
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


                if( DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)) == DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(
                  snapshot.data!.docs[index].data()["date"].millisecondsSinceEpoch,
                  isUtc: false,
                ).toUtc()).toString()){
                  return Dismissible(

                      key: Key(index.toString()),
                      child: Card(
                        elevation: 1,

                        child: ListTile(

                          title: Text(
                            (snapshot.data!.docs[index].data()["name"] != null)
                                ? snapshot.data!.docs[index].data()["name"]
                                : "",
                            style: TextStyle(
                              fontSize: 16,
                              color: colorBlack,
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
