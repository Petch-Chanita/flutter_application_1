import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/dataRoom.dart';
import 'package:flutter_application_1/models/dataUser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Not_empty extends StatefulWidget {
  Not_empty({Key key}) : super(key: key);

  @override
  _Not_emptyState createState() => _Not_emptyState();
}

class _Not_emptyState extends State<Not_empty> {
  String mineID;
  String token;
  DataUser dataUser;
  List<DataRoom> dataRoom;

  Future<bool> loadnot_empty() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mineID = preferences.getString("mineID");
    token = preferences.getString("token");

    String apiUrl = 'http://202.28.34.197:9000/rooms/search/status/กำลังถูกใช้';

    final res = await http.get(Uri.parse(apiUrl));
    print('statuscode${res.statusCode}');
    if (res.statusCode == 200) {
      print('Empty${res.statusCode}');
      dataRoom = dataRoomFromJson(res.body);
      print('data id${dataRoom[0].id}');
    } else {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: MyTheme.draweBackgroundColorDrawer,
          title: Text(
            'ห้องถูกใช้งาน',
            style: GoogleFonts.acme(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: MyTheme.draweBackgroundColorDrawer,
        body: FutureBuilder(
          future: loadnot_empty(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if (snapshot.hasError) {
            //   return Text(
            //       "เกิดข้อผิดพลาดในการโหลดข้อมูล ${snapshot.hasError} ${snapshot.error}");
            // }
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Text("ข้อมูลคือ${snapshot.data}");
                break;
              case ConnectionState.done:
                return (dataRoom.length == 0)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ไม่พบข้อมูล",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children: [
                          SizedBox(
                            height: 18.0,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 180),
                              itemCount: dataRoom.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Column(
                                  children: [
                                    WidgetRoom(dataRoom: dataRoom[index]),
                                  ],
                                );
                              }),
                        ],
                      );
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      Text("www"),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              case ConnectionState.none:
                return Text("No Connection");
                break;
              default:
                print("something");
            }
            return null;
          },
        ),
        // body: FutureBuilder(
        //     future: loadnot_empty(),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.hasData) {
        //         print('snashot${snapshot.data}');
        //         if (snapshot.data == true) {
        //           return ListView(
        //             children: [
        //               SizedBox(
        //                 height: 18.0,
        //               ),
        //               GridView.builder(
        //                   shrinkWrap: true,
        //                   physics: NeverScrollableScrollPhysics(),
        //                   gridDelegate:
        //                       SliverGridDelegateWithMaxCrossAxisExtent(
        //                           maxCrossAxisExtent: 200,
        //                           childAspectRatio: 3 / 2,
        //                           crossAxisSpacing: 0,
        //                           mainAxisSpacing: 10,
        //                           mainAxisExtent: 180),
        //                   itemCount: dataRoom.length,
        //                   itemBuilder: (BuildContext ctx, index) {
        //                     return Column(
        //                       children: [
        //                         WidgetRoom(dataRoom: dataRoom[index]),
        //                       ],
        //                     );
        //                   }),
        //             ],
        //           );
        //         } else {
        //           return Center(
        //             child: Text("Error"),
        //           );
        //         }
        //       } else {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     })
      ),
    );
  }
}

class WidgetRoom extends StatelessWidget {
  const WidgetRoom({
    Key key,
    @required this.dataRoom,
  }) : super(key: key);

  final DataRoom dataRoom;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      // margin: EdgeInsets.fromLTRB(100, 20, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              dataRoom.roomNumber,
              style: GoogleFonts.mali(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              dataRoom.status,
              style: GoogleFonts.mali(
                  color: Colors.greenAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            dataRoom.datetime != null
                ? Text(
                    dataRoom.datetime.split(' ')[0],
                    style: GoogleFonts.mali(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  )
                : Container(),
            dataRoom.datetime != null
                ? Text(
                    dataRoom.datetime != null
                        ? dataRoom.datetime.split(' ')[1]
                        : "",
                    style: GoogleFonts.mali(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  )
                : Container(),
          ],
        ),
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyTheme.drawerBackgroundColor,
        ),
      ),
    );
  }
}
