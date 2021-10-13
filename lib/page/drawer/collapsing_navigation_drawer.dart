import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dataUser.dart';
import 'package:flutter_application_1/page/drawer/collapsing_list_tile.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/page/profiles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({Key key}) : super(key: key);

  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 220;
  double minWidth = 45;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    print("collapsing");
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(_animationController);
  }

  String mineID;
  String token;
  DataUser dataUser;

  Future<bool> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    mineID = preferences.getString("mineID");
    token = preferences.getString("token");

    String apiUrl = 'http://202.28.34.197:9000/users/user/$mineID';

    final res = await http.get(Uri.parse(apiUrl));
    print(res.statusCode);
    if (res.statusCode == 200) {
      dataUser = dataUserFromJson(res.body);
    } else {
      return false;
    }

    return true;
  }

  dynamic page = HomePage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return SafeArea(
                child: Stack(
                  children: [
                    page,
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, widget) => getWidget(context, widget),
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
        });
  }

  var pageAll = [HomePage(), Profiles()];

  Widget getWidget(context, widget) {
    return Material(
      elevation: 8.0,
      child: Container(
        width: widthAnimation.value,
        color: MyTheme.drawerBackgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            (widthAnimation.value < 220)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 16, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: MemoryImage(
                              base64Decode(dataUser.image.split(",")[1])),
                          radius: 40,
                        ),
                        Expanded(child: Container()),
                        (widthAnimation.value < 220)
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  print("object");
                                  setState(() {
                                    isCollapsed = !isCollapsed;
                                    isCollapsed
                                        ? _animationController.forward()
                                        : _animationController.reverse();
                                  });
                                },
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_arrow,
                                  progress: _animationController,
                                  color: Colors.white,
                                  size: 38,
                                ),
                              ),
                      ],
                    ),
                  ),
            (widthAnimation.value < 220)
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                        isCollapsed
                            ? _animationController.forward()
                            : _animationController.reverse();
                      });
                    },
                    child: Column(
                      children: [
                        CollapsingListTile(
                            // onTap: () {
                            //   setState(() {

                            //   });
                            // },

                            title: "test", //navigationItems[counter].title
                            icon: Icons.menu_outlined,
                            animationController: _animationController),
                        SizedBox(
                          height: 5,
                        ),
                        (widthAnimation.value == 45)
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(
                                    base64Decode(dataUser.image.split(",")[1])),
                                radius: 14,
                              )
                            : Container()
                      ],
                    ),
                  )
                : Container(),

            (widthAnimation.value < 220)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Row(
                      children: [
                        Text(
                          dataUser.username,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
            (widthAnimation.value < 220)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Row(
                      children: [
                        Text(
                          dataUser.email,
                          style:
                              TextStyle(color: Colors.white70.withOpacity(0.4)),
                        ),
                      ],
                    ),
                  ),
            // Divider(
            //   color: Colors.grey,
            //   height: 40,
            // ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(
                    // color: Colors.grey,
                    height: 12,
                  );
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                      onTap: () {
                        setState(() {
                          page = pageAll[counter];
                          currentSelectedIndex = counter;
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                      title: navigationItems[counter]
                          .title, //navigationItems[counter].title
                      icon: navigationItems[counter].icon,
                      animationController: _animationController);
                },
                itemCount: navigationItems.length,
              ),
            ),
            CollapsingListTile(
                onTap: () {},
                title: "ออกจากระบบ", //navigationItems[counter].title
                icon: Icons.exit_to_app,
                animationController: _animationController),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "หน้าแรก", icon: Icons.home_outlined),
  NavigationModel(title: "บัญชีผู้ใช้", icon: Icons.person_outline_outlined),
  NavigationModel(title: "ห้องว่าง", icon: Icons.remove_red_eye_outlined),
  NavigationModel(title: "ห้องที่ถูกใช้งาน", icon: Icons.play_circle_outline),
  // NavigationModel(title: "สถิติ", icon: Icons.calendar_today_outlined),
];
