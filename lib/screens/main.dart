import 'package:flutter/material.dart';
import 'package:todo_list/screens/add_task.dart';
import 'package:todo_list/screens/all_tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'All Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             Container(
               height: 100,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [

                 const Text(
                   'Today',
                   style: TextStyle(fontWeight: FontWeight.w900 , fontSize: 25),
                 ),
                 SizedBox(width: 110),
                   FloatingActionButton(
                     onPressed: openDialog,

                   child: const Icon(Icons.add),
                 ),

               ],
             ),
             ),
AllTask()
          ],
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AddTask()
  );

}
