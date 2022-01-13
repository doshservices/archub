import 'package:archub/model/categorymodel.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:archub/screen/dashboard/explore/widget/explore_widget.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  List<CategoryModel> categorydata = [];
  String search;

  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<JobProvider>(context, listen: false).fetchCategory();
      if(mounted){
        setState(() {
        _isInit = false;
      });
      }
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = new TabController(length: 8, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    final categoryProvider = Provider.of<JobProvider>(context, listen: false);
    categorydata = categoryProvider.categorydata;
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
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Color(0xff8C191C),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.end,
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
                                onChanged: (value) {
                                  setState(() {
                                    search = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: 'Search ',
                                    // contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    hintStyle: TextStyle(
                                        fontSize: 16, color: Color(0xff28384F)),
                                    border: InputBorder.none)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              // showSearch(
                              //     context: context,
                              //     delegate: CustomSearchDelegate());
                            },
                            icon: Icon(Icons.search)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: DefaultTabController(
                    length: categorydata.length,
                    child: Column(children: [
                      Container(
                        height: 30,
                        child: TabBar(
                          labelColor: Colors.black,
                          labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                          indicatorColor: Theme.of(context).primaryColor,
                          isScrollable: true,
                          tabs: List<Widget>.generate(categorydata.length,
                              (int index) {
                            return new Tab(text: categorydata[index].name);
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: List<Widget>.generate(
                              categorydata.length, (int index) {
                            return new ExploreWidget(
                                id: categorydata[index].id, name: search);
                          }),
                        ),
                      )
                    ])),
              ),
            ),
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
