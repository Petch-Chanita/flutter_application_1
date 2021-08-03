import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  // void @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Text(
            'Chattie',
            style: MyTheme.kAppTitle,
          ),

          // elevation: 0,
        ),
        backgroundColor: MyTheme.kPrimaryColor,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              height: 80,
              color: MyTheme.kPrimaryColor,
              child: TabBar(
                controller: tabController,
                indicator: ShapeDecoration(
                    color: MyTheme.kAccentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                tabs: [
                  Tab(
                    icon: Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Index 2',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Index 3',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
