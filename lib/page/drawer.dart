import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';

// class drawer extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return _drawer();
//   }
// }
// class _drawer extends State<drawer>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

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
                      Text('USER ROOM',
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
                      backgroundImage: AssetImage('assets/images/alucard.jpg'),
                      radius: 45.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '\n'+'Alec Reynolds',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.mali(color: Colors.white,fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.house_sharp ,
              color: Colors.white,
            ),
            title: Text('หน้าหลัก',
              style: GoogleFonts.mali(
                  fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person,
              color: Colors.white,
            ),
            title: Text('บัญชีผู้ใช้',
              style: GoogleFonts.mali(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.sensor_door_outlined,
              color: Colors.white,
            ),
            title: Text('ห้องว่าง',
              style: GoogleFonts.mali(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.remove_circle ,
              color: Colors.white,
            ),
            title: Text('ห้องถูกใช้งาน',
              style: GoogleFonts.mali(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.feed_rounded,
              color: Colors.white,
            ),
            title: Text('สถิติ',
              style: GoogleFonts.mali(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new,
              color: Colors.white,
            ),
            title: Text('Log out',
              style: GoogleFonts.mali(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            onTap: () {
              // Navigator.pushNamed(context, '/Login');
            },
          ),
        ],
      ),
    ),
  );
}