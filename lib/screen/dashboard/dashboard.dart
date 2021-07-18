import 'package:archub/screen/dashboard/cloud/cloud.dart';
import 'package:archub/screen/dashboard/explore/explore.dart';
import 'package:archub/screen/dashboard/home/home.dart';
import 'package:archub/screen/dashboard/job/job.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//pages
// import 'package:badmus/screens/dashboard/profile/profile.dart';
// import 'package:badmus/screens/dashboard/home/home.dart';
// import 'package:badmus/screens/dashboard/chat/chat.dart';
// import 'package:badmus/screens/dashboard/category/category.dart';
// import 'package:badmus/screens/dashboard/favorite/favorite.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TabController tabController;
  bool _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 2, length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        tabController.index = 2;

        _page = 2;
        _isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        items: <Widget>[
          BottomItem(
            page: _page,
            index: 0,
            iconUrl: "assets/icons/home.png",
            text: 'Home'
          ),
          BottomItem(
            page: _page,
            index: 1,
            iconUrl: "assets/icons/explore.png",
            text: 'Explore'
          ),
          BottomItem(
            page: _page,
            index: 2,
            iconUrl: "assets/icons/job.png",
            text: 'Jobs'
          ),
          BottomItem(
            page: _page,
            index: 3,
            iconUrl: "assets/icons/cloud.png",
            text: 'Upload'
          ),
        ],
        onTap: (index) {
          setState(() {
            tabController.index = index;
            _page = index;
          });
        },
        height: 50,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.grey.withOpacity(0.2),
      ),
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ExploreScreen(),
          JobScreen(),
          CloudScreen()
        ],
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  BottomItem({
    Key key,
    @required int page,
    this.index,
    this.iconUrl,
    this.text
  })  : _page = page,
        super(key: key);

  int index, _page;
  String iconUrl, text;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          "$iconUrl",
          width: 25,
          height: 25,
          color: _page == index ? Colors.white : Color(0xffC7C7DD),
        ),
        Text(text)
      ],
    );
  }
}
