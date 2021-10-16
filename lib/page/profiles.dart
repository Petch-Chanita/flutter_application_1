import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/models/dataUser.dart';
import 'package:flutter_application_1/models/editprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profiles extends StatefulWidget {
  const Profiles({Key key}) : super(key: key);

  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  @override
  void initState() {
    print("page 1");
    // TODO: implement initState
    super.initState();
  }

  String mineID;
  String token;
  DataUser dataUser;

  TextEditingController email_ctrl = TextEditingController();
  TextEditingController username_ctrl = TextEditingController();

  Future<bool> user() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mineID = preferences.getString("mineID");
    token = preferences.getString("token");

    String apiUrl = 'http://202.28.34.197:9000/users/user/$mineID';
    final res = await http.get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      dataUser = dataUserFromJson(res.body);
      email_ctrl.text = dataUser.email;
      username_ctrl.text = dataUser.username;
    } else {
      return false;
    }
    return true;
  }

  File imagefile;
  image_in() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      PlatformFile file = result.files.first;
      imagefile = File(file.path);
      setState(() {});
    }
  }

  Future<EditProfile> editProfile(
      String email, String username, String image) async {
    final String apiUrl = 'http://202.28.34.197:9000/users/user/$mineID';
    var data = {"email": email, "username": username, "Image": image};
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return editProfileFromJson(response.body);
    } else {
      return null;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: MyTheme.draweBackgroundColorDrawer,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'My Profile',
            style: GoogleFonts.acme(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
            future: user(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: MyTheme.draweBackgroundColorDrawer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 8,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "My Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: MemoryImage(
                                            base64Decode(
                                                dataUser.image.split(",")[1])),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Email address",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        dataUser.email,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.alternate_email,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "User name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        dataUser.username,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: MyTheme.draweBackgroundColorDrawer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Email address",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == "") {
                                        return "Please enter a Email.";
                                      }
                                      return null;
                                    },
                                    controller: email_ctrl,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.only(top: 0, left: 10),
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "User name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim() == "") {
                                        return "Please enter user name.";
                                      }
                                      return null;
                                    },
                                    controller: username_ctrl,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.only(top: 0, left: 10),
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Image input",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: (imagefile != null)
                                            ? FileImage(imagefile)
                                            : MemoryImage(
                                                base64Decode(dataUser.image
                                                    .split(",")[1]),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: image_in,
                                  icon: Icon(
                                    Icons.drive_folder_upload,
                                    color: Colors.grey,
                                  ),
                                  label: Text(
                                    'Browse',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.white)),
                                ),
                                // ElevatedButton.icon(
                                //     onPressed: () {},
                                //     icon: ,
                                //     ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              print(email_ctrl.text);
                                              print(username_ctrl.text);
                                              String image = (imagefile != null)
                                                  ? 'data:image/jpeg;base64,' +
                                                      base64Encode(imagefile
                                                          .readAsBytesSync())
                                                  : dataUser.image;

                                              EditProfile dataEditProfile =
                                                  await editProfile(
                                                      email_ctrl.text,
                                                      username_ctrl.text,
                                                      image);
                                              print(
                                                  'dataprofiles${dataEditProfile.success}');
                                              if (dataEditProfile.success ==
                                                  true) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialogNotificationPost(
                                                          image:
                                                              'https://cdn.dribbble.com/users/147386/screenshots/5315437/success-tick-dribbble.gif',
                                                          text: "แก้ไขสำเร็จ",
                                                          discription: "",
                                                        )).then((value) {
                                                  setState(() {});
                                                });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialogNotificationPost(
                                                          image:
                                                              'https://png.pngtree.com/png-vector/20190228/ourlarge/pngtree-wrong-false-icon-design-template-vector-isolated-png-image_711430.jpg',
                                                          text:
                                                              "ไม่สามารถแก้ไขได้",
                                                          discription:
                                                              "มีชื่อผู้ใช้ หรืออีเมล์นี้แล้ว กรุณากรอกข้อมูลใหม่อีกครั้ง",
                                                        ));
                                              }
                                              // print('image,' +
                                              //     base64Encode(
                                              //         imagefile.readAsBytesSync()));
                                            }
                                          },
                                          child: Text('Summit')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
            }));
  }
}

class CustomDialogNotificationPost extends StatelessWidget {
  final String image, text, discription;

  CustomDialogNotificationPost({this.image, this.text, this.discription});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100, bottom: 26, left: 16, right: 16),
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //         title,
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontSize: 22.0, fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //   ],
                // ),

                Text(
                  text,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 16.0),
                ),
                Text(
                  this.discription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'))
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Text(
                    //     "อยู่หน้านี้ต่อ",
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     Navigator.pop(context);
                    //   },
                    //   child: Text("ออกไปหน้าอื่น"),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: NetworkImage(this.image),
            ),
          )
        ],
      ),
    );
  }
}
