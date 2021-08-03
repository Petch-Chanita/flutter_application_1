import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/password-input.dart';
import 'package:flutter_application_1/widgets/rounded-button.dart';
import 'package:flutter_application_1/widgets/text-field-input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateNewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backG.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
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
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.userAlt,
                      hint: 'User name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Password',
                      inputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundeButton(buttonName: 'Sign up'),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            height: 1.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/HomePage');
                      },
                      child: Container(
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
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
