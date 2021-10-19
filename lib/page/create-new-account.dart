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
    // var value;
    var res = await http.post("http://202.28.34.197:9000/authen/register",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode({
          'email': user.email,
          'username': user.username,
          'password': user.password,
          'Image':
              'data:image/jpeg;base64,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'
        }));

    dataRegister = userRegisterFromJson(res.body);

    print('email' + ': ' + user.email);
    print('username' + ': ' + user.username);
    print('password' + ': ' + user.password);
    print(res.body);
    //
    // value = jsonDecode(res.body);
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
                                    return 'Enter valid Email';
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
          ),
        ],
      ),
    );
  }
}
