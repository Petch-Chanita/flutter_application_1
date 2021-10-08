import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class profiles extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _profilesstate();
  }
}
class _profilesstate extends State<profiles>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    );

  }
  
} 
