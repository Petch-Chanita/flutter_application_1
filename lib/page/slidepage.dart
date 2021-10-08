import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/drawer/collapsing_navigation_drawer.dart';
import 'package:flutter_application_1/page/home_page.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({ Key key }) : super(key: key);

  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // drawer: ,
      body: PageStorage(bucket: bucket, child: CollapsingNavigationDrawer()),
    );
  }
}