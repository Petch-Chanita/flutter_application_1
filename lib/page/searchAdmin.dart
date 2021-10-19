import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/EditDataRoom.dart';
import 'package:flutter_application_1/models/dataRoom.dart';
import 'package:flutter_application_1/models/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SearchAdmin extends StatefulWidget {
  SearchAdmin({Key key}) : super(key: key);

  @override
  _SearchAdminState createState() => _SearchAdminState();
}

class _SearchAdminState extends State<SearchAdmin> {
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

  List<DataRoom> dataRoom;

  Future<bool> loadRoom() async {
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
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: dataSearch.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                height: MediaQuery.of(context).size.width * 0.65,
                child: Card(
                  color: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black,
                  child: Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dataSearch[index].roomNumber,
                              style: GoogleFonts.mali(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "สถานะ:",
                              style: GoogleFonts.mali(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 50.0,
                            ),
                            Text(
                              dataSearch[index].status,
                              style: GoogleFonts.mali(
                                  color: Colors.greenAccent,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "วัน/เวลา:",
                              style: GoogleFonts.mali(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            dataSearch[index].datetime != null
                                ? Text(
                                    dataSearch[index].datetime,
                                    style: GoogleFonts.mali(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "อุณหภูมิ: ",
                              style: GoogleFonts.mali(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            dataSearch[index].temperature != null
                                ? Text(
                                    '${dataSearch[index].temperature.toStringAsFixed(2)}',
                                    style: GoogleFonts.mali(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10.0,
                            ),
                            dataSearch[index].temperature != null
                                ? Text(
                                    "°C ",
                                    style: GoogleFonts.mali(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal),
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "เคลื่อนไหว: ",
                              style: GoogleFonts.mali(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            dataSearch[index].motion != null
                                ? Text(
                                    '${dataSearch[index].motion.toStringAsFixed(2)}',
                                    style: GoogleFonts.mali(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "แสง: ",
                              style: GoogleFonts.mali(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 70.0,
                            ),
                            dataSearch[index].luminance != null
                                ? Text(
                                    '${dataSearch[index].luminance.toStringAsFixed(2)}',
                                    style: GoogleFonts.mali(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                label: Text(
                                  'แก้ไข',
                                  style: GoogleFonts.mali(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Icon(Icons.create_outlined,
                                    color: Colors.black),
                                onPressed: () {
                                  print('Pressed');
                                  showDialog(
                                          context: context,
                                          builder: (context) => DialogEditRoom(
                                              roomNumber:
                                                  dataSearch[index].roomNumber,
                                              status: dataSearch[index].status,
                                              id: dataSearch[index].id))
                                      .then((value) {
                                    print("LLLLLLLLLLLLLL");
                                    setState(() {});
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.amber[800]),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class DialogEditRoom extends StatefulWidget {
  String roomNumber, status, id;
  DialogEditRoom({this.roomNumber, this.status, this.id});

  @override
  State<DialogEditRoom> createState() => _DialogEditRoomState();
}

class _DialogEditRoomState extends State<DialogEditRoom> {
  String _chosenValue;
  @override
  void initState() {
    super.initState();
    _chosenValue = this.widget.status;
    ctr_number.text = this.widget.roomNumber;
  }

  Future<EditDataRoom> EditRoom() async {
    String apiUrl = 'http://202.28.34.197:9000/rooms/update/${this.widget.id}';
    var data = {"Room_number": ctr_number.text, "status": _chosenValue};
    print('data : ${data}');
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return editDataRoomFromJson(response.body);
    } else {
      return null;
    }
  }

  TextEditingController ctr_number = TextEditingController();
  // TextEditingController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  final _key = GlobalKey<FormState>();
  dialogContent(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _key,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "แก้ไขข้อมูลห้อง",
                  style: GoogleFonts.mali(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text("ชื่อห้อง",
                    style: GoogleFonts.mali(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              cursorColor: Colors.white,
              controller: ctr_number,
              validator: (value) {
                if (value == null || value.isEmpty || value.trim() == "") {
                  return 'Room number is required';
                }
                return null;
              },
              // controller: ctrl_username,
              onChanged: (value) {
                // user.username = value;
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                  fillColor: Colors.grey[500].withOpacity(0.5),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text("สถานะ",
                    style: GoogleFonts.mali(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // color: Colors.amber,
              decoration: BoxDecoration(
                  color: Colors.grey[500].withOpacity(0.5),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              // padding: const EdgeInsets.all(0.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: DropdownButton<String>(
                  focusColor: Colors.white,
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    'ว่าง',
                    'กำลังถูกใช้งาน',
                    'กำลังอัพเดท',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.mali(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          ElevatedButton(
              onPressed: () async {
                if (_key.currentState.validate()) {
                  EditDataRoom E_room = await EditRoom();
                  print("E_room${E_room.data}");
                  // setState(() {});
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              // icon: Icon(Icons.ac_unit_outlined),
              child: Text("บันทึก",
                  style: GoogleFonts.mali(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    ));
  }
}
