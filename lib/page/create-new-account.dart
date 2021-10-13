import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/page/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';

class CreateNewAccount extends StatefulWidget {
  static String tag = 'CreateNewAccount-page';
  @override
  _CreateNewAccountState createState() => new _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final _formKey = GlobalKey<FormState>();

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
    print('email' + ': ' + user.email);
    print('username' + ': ' + user.username);
    print('password' + ': ' + user.password);
    print(res.body);
    //
    value = jsonDecode(res.body);
    print(value);
    if (value["status"] != 'error') {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LoginPage()));
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3,
                            sigmaY: 3,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.pink[100].withOpacity(0.4),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.09,
                      left: size.width * 0.55,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: Colors.blueAccent,
                          size: size.width * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller:
                                    TextEditingController(text: user.email),
                                onChanged: (value) {
                                  user.email = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email is required';
                                  } else if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid email';
                                  }
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintText: 'Enter Email',
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller:
                                    TextEditingController(text: user.username),
                                onChanged: (value) {
                                  user.username = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Username is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.userAlt,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintText: 'Enter Username',
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              controller:
                                  TextEditingController(text: user.password),
                              onChanged: (value) {
                                user.password = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Icon(
                                      Icons.vpn_key,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Enter Password',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
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
                                    borderRadius: BorderRadius.circular(16.0)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print("ok");
                                    save();
                                  } else {
                                    print("not ok");
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
        )
        // image: AssetImage('assets/images/backG.jpg'
      ],
    );
  }
}
