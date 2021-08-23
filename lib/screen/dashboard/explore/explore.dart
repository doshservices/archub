import 'package:archub/model/imageData.dart';
import 'package:archub/screen/dashboard/explore/widget/explore_widget.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constants.dart';

class ExploreScreen extends StatefulWidget {
  // const HomeScreen({ Key key }) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TabController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Color(0xff8C191C),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Search ',
                                  hintStyle:
                                      TextStyle(color: Color(0xff28384F)),
                                  border: InputBorder.none)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DefaultTabController(
                length: 5,
                child: TabBar(

                    // physics: ScrollPhysics(),
                    controller: _controller,
                    labelStyle: TextStyle(
                      fontSize: 13,
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
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Center(
                              child: Text(
                                'Architecture',
                                style: TextStyle(
                                    color: Color(0xff28384F), fontSize: 4),
                              ),
                            ),
                            // Expanded(child: Text(''))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            // Expanded(child: Text('')),
                            Text(
                              'Interiror Design',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 4),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            // Expanded(child: Text('')),
                            Text(
                              'Strucutural Design',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 4),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            // Expanded(child: Text('')),
                            Text(
                              'Strucutural Design',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 4),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            // Expanded(child: Text('')),
                            Text(
                              'Strucutural Design',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 4),
                            ),
                          ],
                        ),
                      ),
                    ])),
            ExploreWidget(),
            // Container(
            //   height: double.infinity,
            //   child: TabBarView(
            //     controller: _controller,
            //     children: [
            //       ExploreWidget(),
            //       ExploreWidget(),
            //       ExploreWidget(),
            //       ExploreWidget(),
            //       ExploreWidget(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
