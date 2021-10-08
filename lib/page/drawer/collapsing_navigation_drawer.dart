import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/drawer/collapsing_list_tile.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/page/page1.dart';

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
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(_animationController);
  }
  dynamic page = HomePage();
  @override
  Widget build(BuildContext context) {
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
  }

  var pageAll = [
    HomePage(),
    Page1()
  ];

  Widget getWidget(context, widget) {
    return Material(
      elevation: 8.0,
      child: Container(
        width: widthAnimation.value,
        color: MyTheme.drawerBackgroundColor,
        child: Column(
          children: [
            // CollapsingListTile(
            //   title: 'Sarah Pulson',
            //   icon: Icons.person,
            //   animationController: _animationController,
            // ),
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
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/236x/30/72/0e/30720e3bf3dd008a1a962ebb4742e58d.jpg"),
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
                            SizedBox(height: 5,),
                            (widthAnimation.value == 45) ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/236x/30/72/0e/30720e3bf3dd008a1a962ebb4742e58d.jpg"),
                          radius: 14,
                        ) : Container()
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
                          "Jony Blake",
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
                          "xxxxx@gmail.com",
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
  NavigationModel(title: "สถิติ", icon: Icons.calendar_today_outlined),
];
