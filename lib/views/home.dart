import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app/views/log_in.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Log_in();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Academy",
            style: TextStyle(fontSize: 40),
          ),
      
        ],
      )),
    );
  }
}
