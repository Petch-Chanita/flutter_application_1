import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/dataUser.dart';
import 'package:flutter_application_1/page/drawer/collapsing_navigation_drawer.dart';
import 'package:flutter_application_1/page/empty.dart';
import 'package:flutter_application_1/page/login_page.dart';
import 'package:flutter_application_1/page/not-empty.dart';
import 'package:flutter_application_1/page/profiles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class drawer extends StatefulWidget {
  drawer({Key key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

String mineID;
String token;
DataUser dataUser;
Future<bool> loadData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  mineID = preferences.getString("mineID");
  token = preferences.getString("token");

  String apiUrl = 'http://202.28.34.197:9000/users/user/$mineID';

  final res = await http.get(Uri.parse(apiUrl));
  print(res.statusCode);
  if (res.statusCode == 200) {
    dataUser = dataUserFromJson(res.body);
  } else {
    return false;
  }

  return true;
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Container(
                child: drawer(),
              );
            } else {
              return Center(
                child: Text("Error"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget drawer() {
    return Drawer(
      child: Container(
        color: MyTheme.drawerBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'USER ROOM',
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.mali(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(
                            base64Decode(dataUser.image.split(",")[1])),
                        radius: 45.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        dataUser.username,
                        textAlign: TextAlign.center,
                        // overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.mali(
                            color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     print('111111');
            //   },
            //   leading: Icon(
            //     Icons.house_sharp,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     'หน้าหลัก',
            //     style: GoogleFonts.mali(
            //         fontSize: 18.0,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profiles()));
              },
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                'บัญชีผู้ใช้',
                style: GoogleFonts.mali(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Empty()));
              },
              leading: Icon(
                Icons.sensor_door_outlined,
                color: Colors.white,
              ),
              title: Text(
                'ห้องว่าง',
                style: GoogleFonts.mali(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Not_empty()));
              },
              leading: Icon(
                Icons.remove_circle,
                color: Colors.white,
              ),
              title: Text(
                'ห้องถูกใช้งาน',
                style: GoogleFonts.mali(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.feed_rounded,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     'สถิติ',
            //     style: GoogleFonts.mali(
            //         fontSize: 18.0,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              title: Text(
                'Log out',
                style: GoogleFonts.mali(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                // preferences.setString('mineID', null);
                // preferences.setString('token', null);

                preferences.clear();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
