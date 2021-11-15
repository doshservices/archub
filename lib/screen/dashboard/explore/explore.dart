import 'package:archub/model/imageData.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/screen/dashboard/explore/widget/explore_widget.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

var user;

class ExploreScreen extends StatefulWidget {
  // const HomeScreen({ Key key }) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TabController _controller;
  int currentSelection = 0;

  @override
  void initState() {
    _controller = new TabController(length: 8, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(KNotificationsScreen);
              },
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
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
                        SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            },
                            child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Search ',
                                    contentPadding: EdgeInsets.all(10),
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: Color(0xff28384F)),
                                    border: InputBorder.none)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            },
                            icon: Icon(Icons.search)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: DefaultTabController(
                  length: 5,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(maxHeight: 150.0),
                        color: Colors.white,
                        child: Material(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: TabBar(
                                unselectedLabelColor: Color(0xffC4C4C4),
                                labelColor: Colors.black,
                                indicatorColor: Colors.black,
                                isScrollable: true,
                                controller: _controller,
                                labelPadding: EdgeInsets.all(0),
                                indicatorPadding: EdgeInsets.all(0),
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                tabs: [
                                  Container(
                                    // width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 0
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Architecture",
                                      key: Key("architecture"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 1
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Interiror \nDesign",
                                      key: Key("design"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 2
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Strucutural \nDesign",
                                      key: Key("strucutural"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 3
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Product \ndesigner",
                                      key: Key("Product"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 3
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Photography",
                                      key: Key("Photography"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 3
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Paint Art",
                                      key: Key("Paint Art"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 3
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "Motion Graphics Design",
                                      key: Key("Motion Graphics Design"),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: currentSelection == 3
                                      //     ? Color(0xff369F2A).withOpacity(0.2)
                                      //     : Colors.white10,
                                    ),
                                    child: Tab(
                                      text: "3D Animation",
                                      key: Key("3D Animation"),
                                    ),
                                  ),
                                ],
                                onTap: (index) async {
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    setState(() {
                                      currentSelection = index;
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  ExploreWidget(),
                  ExploreWidget(),
                  ExploreWidget(),
                  ExploreWidget(),
                  ExploreWidget(),
                  ExploreWidget(),
                  ExploreWidget(),
                  ExploreWidget(),
                ],
              ),
            ),
            // ExploreWidget(),
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

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    // return Column(
    //   children: [
    //     FutureBuilder(
    //       future: user,
    //       builder: )
    //   ],
    // )
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    throw UnimplementedError();
  }
}
