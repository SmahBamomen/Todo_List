import 'package:flutter/material.dart';
import 'package:todo_list/screens/add_task.dart';
import 'package:todo_list/screens/today.dart';
import 'package:todo_list/screens/tomorrow.dart';
import 'package:todo_list/screens/upcoming.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Today 🥳',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                SizedBox(width: 230),
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: openAddDialog,
                      child: const Icon(
                        Icons.add,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TodayTasks(),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 20),
            child: const Text(
              'Tomorrow ✨',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          TomorrowTasks(),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 20),
            child: const Text(
              'Upcoming 🤩',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          UpcomingTasks()
        ],
      ),
    );
  }

  Future openAddDialog() =>
      showDialog(context: context, builder: (context) => AddTask());
}
