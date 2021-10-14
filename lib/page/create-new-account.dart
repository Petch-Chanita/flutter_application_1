import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dataRegister.dart';

import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/page/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class CreateNewAccount extends StatefulWidget {
  static String tag = 'CreateNewAccount-page';
  @override
  _CreateNewAccountState createState() => new _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final _formKey = GlobalKey<FormState>();

  UserRegister dataRegister;
  Future save() async {
    // final byteData = await rootBundle.load('assets/images/alucard.jpg');
    var value;
    var res = await http.post("http://202.28.34.197:9000/authen/register",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode({
          'email': user.email,
          'username': user.username,
          'password': user.password,
          'Image':
              './assets/dist/img/138-1388270_transparent-user-png-icon.png',
        }));

    dataRegister = userRegisterFromJson(res.body);

    print('email' + ': ' + user.email);
    print('username' + ': ' + user.username);
    print('password' + ': ' + user.password);
    print(res.body);
    //
    value = jsonDecode(res.body);
    print(dataRegister.email);
    // print(dataRegister.error.keyValue.email);
    // print('===>${dataRegister.error.keyValue.username}');
    if (dataRegister.success == 0) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    } else {
      String t_err = "";

      if (dataRegister.error.keyValue.email != null) {
        t_err = "อีเมล :${dataRegister.error.keyValue.email} นี้ถูกใช้งานแล้ว";
      } else if (dataRegister.error.keyValue.username != null) {
        t_err =
            "ชื่อผู้ใช้ :${dataRegister.error.keyValue.username} นี้ถูกใช้งานแล้ว";
      }
      showDialog(
          context: context,
          builder: (context) => CustomDialogNotificationPost(
                text: "เกิดข้อผิดพลาด",
                textError: t_err,
              ));
    }
  }

  User user = User('', '', '', '');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Center(
                    child: Text(
                      'REGISTER',
                      style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: TextFormField(
                                cursorColor: Colors.white,
                                validator: (value) {
                                  print(value);
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim() == "") {
                                    return 'Email is required';
                                  } else if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return null;
                                  }
                                  // else if (value == ){

                                  // }
                                  else {
                                    return 'Enter valid email';
                                  }
                                },
                                controller:
                                    TextEditingController(text: user.email),
                                onChanged: (value) {
                                  user.email = value;
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                    fillColor:
                                        Colors.grey[500].withOpacity(0.5),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter Email',
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
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
                                    fillColor:
                                        Colors.grey[500].withOpacity(0.5),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim() == "") {
                                  return 'Password is required';
                                } else if (value.length < 5) {
                                  return 'Password too small. Should be atleast 5 character';
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
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
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
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              height: 55,
                              width: 340,
                              child: FlatButton(
                                  color: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      print("ok");
                                      save();
                                    }
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account ? ",
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
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  "Log in",
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
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        // image: AssetImage('assets/images/backG.jpg'
      ],
    );
  }
}

class CustomDialogNotificationPost extends StatelessWidget {
  final String text;
  final String textError;

  CustomDialogNotificationPost({this.text, this.textError});
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
                  this.textError,
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
