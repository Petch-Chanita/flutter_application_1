import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/dataUser.dart';
import 'package:flutter_application_1/page/EmptyAdmin.dart';
import 'package:flutter_application_1/page/NotEmptyAdmin.dart';
import 'package:flutter_application_1/page/login_page.dart';

import 'package:flutter_application_1/page/profiles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Admindrawer extends StatefulWidget {
  Admindrawer({Key key}) : super(key: key);

  @override
  _Admindrawer createState() => _Admindrawer();
}

String mineID;
String token;
DataUser dataUser;
Future<bool> loadData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  mineID = preferences.getString("mineID");
  token = preferences.getString("token");

  print('sssss${mineID}+ppppp');
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

class _Admindrawer extends State<Admindrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Container(
                child: Admindrawer(),
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

  Widget Admindrawer() {
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
                          'ADMIN ROOM',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmptyAdmin()));
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
                    MaterialPageRoute(builder: (context) => Not_EmptyAdmin()));
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
