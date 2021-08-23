import 'package:archub/model/post_data.dart';
import 'package:archub/provider/user_post.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<PostData> postData = [];
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<UserPost>(context, listen: false).postData;
    print(categoryProvider.length);
    postData = categoryProvider;
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xffC4C4C4), shape: BoxShape.circle),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'My Story',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff28384F),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]),
                  );
                }),
          ),
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
                                hintStyle: TextStyle(color: Color(0xff28384F)),
                                border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: postData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  child: Container(
                    color: Color(0xffE5E5E5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Column(children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(KInfoDetail);
                          },
                          leading: Image.asset(
                            'assets/images/test1.png',
                            height: 35,
                            width: 35,
                          ),
                          title: Text(
                            postData[index].title,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            postData[index].description,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff28384F),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(KPostDetail);
                            },
                            child:
                                postData[index].attachmentURI.contains('.mp4')
                                    ? Container(
                                        height: 200,
                                        width: double.infinity,
                                        child: AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
                                          child: VideoPlayer(
                                              VideoPlayerController.network(
                                                  postData[index].attachmentURI)
                                                ..initialize().then((_) {
                                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                                  setState(() {});
                                                })),
                                        ))
                                    : Container(
                                        height: 200,
                                        width: double.infinity,
                                        child: Image.network(
                                            postData[index].attachmentURI,
                                            fit: BoxFit.fill))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(children: [
                                Icon(Icons.favorite),
                                Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.maps_ugc),
                                Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.remove_red_eye),
                                Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ]),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Report',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff8C191C),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ])
                      ]),
                    ),
                  ),
                ),
              );
            },
          )),
        ]),
      ),
    );
  }
}
