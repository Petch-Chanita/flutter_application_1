import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'apptheme/app-theme.dart';
import 'create-new-account.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // final routes = <String, WidgetBuilder>{
  // LoginPage.tag: (context) => LoginPage(),
  // HomePage.tag: (context) => HomePage(),
  // };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Approom',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyTheme.drawerBackgroundColor,
        accentColor: MyTheme.selectedColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'Nunito',
      ),
      // home: HomePage(),
      // initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        'CreateNewAccount': (context) => CreateNewAccount(),
        '/HomePage': (context) => HomePage(),
        '/Login': (context) => LoginPage(),
      },
    );
  }
}
