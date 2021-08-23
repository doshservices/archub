import 'package:archub/screen/dashboard/cloud/widget/appy_widget.dart';
import 'package:archub/screen/dashboard/cloud/widget/employer_widget.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';

class CloudScreen extends StatefulWidget {
  @override
  _CloudScreenState createState() => _CloudScreenState();
}

class _CloudScreenState extends State<CloudScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TabController _controller;
  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: GestureDetector(
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Center(
            child: Image.asset(
          'assets/icons/lg.png',
          height: 40,
        )),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ))
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: AppDrawer(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            DefaultTabController(
                length: 2,
                child: TabBar(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: "DosisBold",
                      fontWeight: FontWeight.w800,
                    ),
                    indicatorColor: Color(0xff28384F),
                    unselectedLabelColor: Color(0xffC4C4C4),
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    isScrollable: false,
                    tabs: [
                      Tab(
                        child: Row(
                          children: [
                            Text(
                              'Employer',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 13),
                            ),
                            Expanded(child: Text(''))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Expanded(child: Text('')),
                            Text(
                              'Apply',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ])),
            Expanded(
                child: Container(
              color: Color(0xffE5E5E5),
              child: TabBarView(
                controller: _controller,
                children: [EmployerWidget(), ApplyWidget()],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
