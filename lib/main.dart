import 'package:flutter/material.dart';
import 'package:interview1/screens/add_note.dart';

import 'package:interview1/screens/home_page_showing_notes.dart';
import 'package:interview1/screens/on_boarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:OnBoarding(),
      routes: {
        'addnote':(context)=>AddNote()
      },
    );
  }
}
