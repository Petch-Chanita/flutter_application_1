// import 'package:flutter/foundation.dart';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/dataRoom.dart';
import 'package:flutter_application_1/models/dataUser.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_1/page/app_bar.dart';
import 'package:flutter_application_1/page/drawer.dart';
import 'package:flutter_application_1/page/searchpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // TabController tabController;

  @override
  // void @override
  void initState() {
    print('kkkkk');
    // tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  String mineID;
  String token;
  DataUser dataUser;
  List<DataRoom> dataRoom;

  Future<bool> loadRoom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mineID = preferences.getString("mineID");
    token = preferences.getString("token");

    String apiUrl = 'http://202.28.34.197:9000/rooms/select';

    final res = await http.get(Uri.parse(apiUrl));
    print('statuscode${res.statusCode}');
    if (res.statusCode == 200) {
      dataRoom = dataRoomFromJson(res.body);
      print('data id${dataRoom[0].id}');
    } else {
      return false;
    }
    return true;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: MyTheme.draweBackgroundColorDrawer,
            title: Text(
              'Home',
              style: GoogleFonts.acme(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          drawer: drawer(),
          // drawer: CollapsingNavigationDrawer(),
          // backgroundColor: MyTheme.selectedColor,
          // drawer: CollapsingNavigationDrawer(),
          backgroundColor: MyTheme.draweBackgroundColorDrawer,
          body: FutureBuilder(
              future: loadRoom(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print('snashot${snapshot.data}');
                  if (snapshot.data == true) {
                    return ListView(
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
              })),
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
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              dataRoom.status,
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
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