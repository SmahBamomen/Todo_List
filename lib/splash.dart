import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override

    //return await Future.delayed(const Duration(seconds: 2), (){});
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      startTime();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: initScreen(context),
      );
    }

    startTime() async {
      var duration = new Duration(seconds: 2);
      return new Timer(duration, route);
    }
    route() {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'All Task')
      )
      );
    }

    initScreen(BuildContext context) {
      return Scaffold(
        body: Center(
          child:  Container(
            color: Colors.white,
            child: Image.asset("assets/Splash.gif"),
          ),
        ),
      );
    }
  }


