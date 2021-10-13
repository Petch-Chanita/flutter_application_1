import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0.0,
    // backgroundColor: MyTheme.drawerBackgroundColor,
    backgroundColor: MyTheme.draweBackgroundColorDrawer,
    title: Text(
      'Home',
      style: GoogleFonts.acme(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: <Widget>[
      IconButton(onPressed: () => {}, icon: Icon(Icons.search))
    ],
  );
}
