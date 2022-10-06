import 'package:flutter/material.dart';
import 'package:todo_list/screens/add_task.dart';
import 'package:todo_list/screens/all_tasks.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
      home: Splash(),
      // home: const MyHomePage(title: 'All Task'),
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


                        onPressed: openDialog,
                        child: const Icon(Icons.add,size: 25,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AllTask(),
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 20),
              child:  const Text(
                'Tomorrow ✨',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 20),
              child:  const Text(
                'Upcoming 🤩',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog() =>
      showDialog(context: context, builder: (context) => AddTask());
}
