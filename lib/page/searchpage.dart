import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching = true;

  List<Search> dataSearch = [];
  Future<Null> search(String id) async {
    dataSearch = [];

    final String apiUrl = 'http://202.28.34.197:9000/rooms/search/$id';
    final res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      setState(() {
        dataSearch = searchFromJson(res.body);
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.draweBackgroundColorDrawer,
      appBar: AppBar(
        backgroundColor: MyTheme.draweBackgroundColorDrawer,
        title: TextField(
          onChanged: (value) {
            if (value != "") {
              search(value);
            } else {
              setState(() {
                dataSearch = [];
              });
            }
          },
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search room number',
              hintStyle: TextStyle(color: Colors.grey)),
        ),
        actions: <Widget>[
          // isSearching
          //     ? IconButton(
          //         icon: Icon(Icons.cancel),
          //         onPressed: () {
          //           setState(() {
          //             this.isSearching = false;
          //           });
          //         },
          //       )
          //     : IconButton(
          //         onPressed: () {
          //           setState(() {
          //             this.isSearching = true;
          //           });
          //         },
          //         icon: Icon(Icons.search)),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 18.0,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 180),
              itemCount: dataSearch.length,
              itemBuilder: (BuildContext ctx, index) {
                return Column(
                  children: [
                    WidgetRoom(dataRoom: dataSearch[index]),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

class WidgetRoom extends StatelessWidget {
  const WidgetRoom({
    Key key,
    @required this.dataRoom,
  }) : super(key: key);

  final Search dataRoom;

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
            dataRoom.datetime != null && dataRoom.datetime != ""
                ? Text(
                    dataRoom.datetime.split(' ')[0],
                    style: GoogleFonts.mali(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  )
                : Container(),
            dataRoom.datetime != null && dataRoom.datetime != ""
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
