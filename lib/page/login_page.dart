import 'dart:convert';


import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/page/create-new-account.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/page/slidepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  // final String value_id;
  LoginPage({Key key}) : super(key: key);
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  Future save() async {
    var value;
    var user_id;
    var res = await http.post("http://202.28.34.197:9000/authen/login",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode({
      'username': user.username,
      'password': user.password
        }));

    print(user.username);
    print(user.password);
    value = jsonDecode(res.body);
    user_id = value["_id"];
    print(user_id);
    print(value);
    if(value["status"] != 'error'){
     Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SlidePage(),
            ),
            (route) => false);
      // Navigator.push(
      //     context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  User user = User('','','','');
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
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Container(
                          height: size.height * 0.08,
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
                              controller: TextEditingController(text: user.username),
                              onChanged: (value) {
                                user.username = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Username is required';
                                } else {
                                  // return 'Enter valid username';
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.red))
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Container(
                          height: size.height * 0.08,
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
                              controller: TextEditingController(text: user.password),
                              onChanged: (value) {
                                user.password = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.red)),
                              ),
                            ),
                          ),
                        ),
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
                                "Login",
                                style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
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
