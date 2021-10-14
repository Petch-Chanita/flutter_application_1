import 'dart:convert';

import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/page/create-new-account.dart';
import 'package:flutter_application_1/page/drawer.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/page/slidepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  // final String value_id;
  LoginPage({Key key}) : super(key: key);
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    check_token();
  }

  void check_token() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var check_mineID = preferences.get("mineID");
    if (check_mineID != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
          (route) => false);
    }
  }

  Future save() async {
    var value;
    var user_id;
    var res = await http.post("http://202.28.34.197:9000/authen/login",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body:
            jsonEncode({'username': user.username, 'password': user.password}));

    print(user.username);
    print(user.password);
    value = jsonDecode(res.body);
    user_id = value["_id"];

    print(value);
    if (value["status"] != 'error') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('mineID', value["_id"]);
      preferences.setString('token', value["data"]);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
          (route) => false);

      // Navigator.push(
      //     context, new MaterialPageRoute(builder: (context) => HomePage()));

    } else {
      print('hhhhhhhhhhh');
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogNotificationPost(text: "เกิดข้อผิดพลาด"));
    }
  }

  User user = User('', '', '', '');
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.transparent],
          ).createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backG.jpg'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken))),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.acme(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim() == "") {
                              return 'Username is required';
                            } else {
                              return null;
                            }
                          },
                          controller:
                              TextEditingController(text: user.username),
                          onChanged: (value) {
                            user.username = value;
                          },
                          style: TextStyle(
                            color: Colors.white,
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
                              prefixIcon: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.white,
                              ),
                              hintText: 'Enter Username',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim() == "") {
                              return 'Password is required';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          controller:
                              TextEditingController(text: user.password),
                          onChanged: (value) {
                            user.password = value;
                          },
                          style: TextStyle(
                            color: Colors.white,
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
                              prefixIcon: Icon(
                                Icons.vpn_key_rounded,
                                color: Colors.white,
                              ),
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          height: 55,
                          width: 340,
                          child: FlatButton(
                              color: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  print("success ok");
                                  save();
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => CreateNewAccount()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class CustomDialogNotificationPost extends StatelessWidget {
  final String text;

  CustomDialogNotificationPost({
    this.text,
  });
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
                Text(
                  text,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 16.0),
                ),
                Text(
                  "กรุณาตรวจสอบความถูกต้องอีกครั้ง :)",
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
              backgroundImage: NetworkImage(
                'https://png.pngtree.com/png-vector/20190228/ourlarge/pngtree-wrong-false-icon-design-template-vector-isolated-png-image_711430.jpg',
              ),
            ),
          )
        ],
      ),
    );
  }
}
