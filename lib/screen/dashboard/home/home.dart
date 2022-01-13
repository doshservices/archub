import 'package:archub/model/post_data.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:archub/provider/user_post.dart';
import 'package:archub/screen/dashboard/dashboard.dart';
import 'package:archub/screen/dashboard/home/storeView/storePage.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
  List<PostData> storyData = [];
  VideoPlayerController _controller;
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<UserPost>(context, listen: false).getAllUserStory();
      await Provider.of<UserPost>(context, listen: false).getAllUserPort();
      await Provider.of<UserPost>(context, listen: false).getTag();
      await Provider.of<Auth>(context, listen: false).getProfile();
      if(mounted){
       setState(() {
        _isInit = false;
      }); 
      }
    }

    // getalldata();
    // startTimer();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<UserPost>(context, listen: false).postData;
    final user = Provider.of<Auth>(context).user;
    final data = Provider.of<UserPost>(context, listen: false).storyData;
    print(categoryProvider.length);
    postData = categoryProvider;
    storyData = data;

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
          // Center(
          //     child: Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: Image.asset(
          //     'assets/icons/chat.png',
          //     height: 30,
          //   ),
          // )),
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
          )),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: AppDrawer(),
        ),
      ),
      body: _isInit
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      // width: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(KStoryScreen);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) {
                              //     return Dashboard(2, "Story");
                              //   }),
                              // );
                            },
                            child: Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xffC4C4C4),
                                      shape: BoxShape.circle,
                                    )),
                                Positioned(
                                    top: -1,
                                    left: 0,
                                    right: 0,
                                    child: Icon(Icons.add_circle))
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'My Story',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff28384F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        color: Colors.white,
                        child: ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: storyData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StoryPage(store: storyData[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: Column(children: [
                                      storyData[index]
                                              .sourceId['image']
                                              .contains('/avatar.svg')
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.2),
                                              radius: 20,
                                              child: SvgPicture.network(
                                                storyData[index]
                                                    .sourceId['image']
                                                    .toString()
                                                    .split("'")
                                                    .join(""),
                                                fit: BoxFit.contain,
                                                height: 30,
                                                placeholderBuilder: (BuildContext
                                                        context) =>
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child:
                                                            const CircularProgressIndicator()),
                                              ),
                                            )
                                          : Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffC4C4C4),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        storyData[index]
                                                            .sourceId['image'],
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          storyData[index]
                                              .sourceId['fullName']
                                              .toString()
                                              .split(' ')
                                              .first,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff28384F),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 6),
                                onTap: () {
                                  Navigator.of(context).pushNamed(KInfoDetail,
                                      arguments: postData[index].sourceId);
                                },
                                leading: 
                                // postData[index].sourceId['image'] ==
                                //         true
                                //     ? 
                                //     CircleAvatar(
                                //         backgroundColor:
                                //             Colors.grey.withOpacity(0.2),
                                //         radius: 25,
                                //         child: SvgPicture.network(
                                //           postData[index]
                                //               .sourceId['image']
                                //               .toString()
                                //               .split("'")
                                //               .join(""),
                                //           fit: BoxFit.contain,
                                //           height: 30,
                                //           placeholderBuilder: (BuildContext
                                //                   context) =>
                                //               Container(
                                //                   padding:
                                //                       const EdgeInsets.all(2),
                                //                   child:
                                //                       const CircularProgressIndicator()),
                                //         ),
                                //       )
                                //     : 
                                    CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          postData[index].sourceId['image'],
                                        ),
                                      ),
                                title: Text(
                                  postData[index].sourceId['fullName'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: postData[index].description == null
                                    ? Container()
                                    : Text(
                                        postData[index].description.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    if(user.id == postData[index].sourceId['_id']){
                                      print("object");
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return Dialog(
                                            child: Container(
                                              height: 160,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Do you like to delete this post?",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                                    SizedBox(height: 30),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 10,
                                                              ),
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xff8C191C)),
                                                              ),
                                                            ),
                                                          ),
                                                      Container(
                                                            height: 50,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child:
                                                                RoundedRaisedButton(
                                                              title:
                                                                  'Delete post',
                                                              titleColor:
                                                                  Colors.white,
                                                              buttonColor: Color(
                                                                  0xff8C191C),
                                                              onPress: () async{
                                                                Navigator.of(context).pop();
                                                                try{
                                                                await Provider.of<JobProvider>(context, listen: false).deletePost(postData[index].id);
                                                                Get.snackbar('Success!', 'Post successfully deleted',
                                                                barBlur: 0,
                                                                dismissDirection: SnackDismissDirection.VERTICAL,
                                                                backgroundColor: Colors.green,
                                                                overlayBlur: 0,
                                                                animationDuration: Duration(milliseconds: 1000),
                                                                duration: Duration(seconds: 2));
                                                                setState(() {
                                                                  _isInit = true;
                                                                });
                                                                // await Provider.of<UserPost>(context, listen: false).getAllUserStory();
                                                                await Provider.of<UserPost>(context, listen: false).getAllUserPort();
                                                                setState(() {
                                                                  _isInit = false;
                                                                });
                                                                
                                                              }catch(e){

                                                              }  
                                                                // Navigator.of(
                                                                //         context)
                                                                //     .pop();
                                                                // Navigator.of(
                                                                //         context)
                                                                //     .pushNamed(
                                                                //         KReportPort,
                                                                //         arguments:
                                                                //             postData[index]);
                                                              },
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                    }else{
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return Dialog(
                                            child: Container(
                                              height: 160,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "What would you like to do?",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                                    SizedBox(height: 30),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 10,
                                                              ),
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xff8C191C)),
                                                              ),
                                                            ),
                                                          ),
                                                      Container(
                                                            height: 50,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child:
                                                                RoundedRaisedButton(
                                                              title:
                                                                  'Report post',
                                                              titleColor:
                                                                  Colors.white,
                                                              buttonColor: Color(
                                                                  0xff8C191C),
                                                              onPress: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamed(
                                                                        KReportPort,
                                                                        arguments:
                                                                            postData[index]);
                                                              },
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                    }
                                  },
                                  child: Icon(
                                    Icons.more_horiz,
                                    size: 30,
                                  ),
                                ),
                              ),
                              if (postData[index].postFiles.length > 0)
                                GestureDetector(
                                    onTap: () {
                                      print("https://res.cloudinary.com/dasek9hic/image/upload/"+"w_1280,h_720,c_fill"+
                                            postData[index].postFiles[0].toString().replaceAll("https://res.cloudinary.com/dasek9hic/image/upload",""));
                                      if (postData[index].postFiles[0] != null) {
                                            print(postData[index].sourceId['image']);
                                        Navigator.of(context).pushNamed(
                                            KPostDetail,
                                            arguments: {"id":postData[index].id, "image" : postData[index].sourceId['image']});
                                      }
                                    },
                                    child: Container(
                                        height: 400,
                                        width: double.infinity,
                                        child: Image.network("https://res.cloudinary.com/dasek9hic/image/upload/"+"w_500,h_500,c_fill"+
                                            postData[index].postFiles[0].toString().replaceAll("https://res.cloudinary.com/dasek9hic/image/upload",""),
                                            fit: BoxFit.fill,
                                            // height: 350,
                                          ))),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: [
                                      Icon(Icons.favorite),
                                      SizedBox(width: 4),
                                      Text(
                                        postData[index]
                                            .reactions
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.maps_ugc),
                                      SizedBox(width: 4),
                                      Text(
                                        postData[index].numberOfComments == null
                                            ? 0.toString()
                                            : postData[index]
                                                .numberOfComments
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.remove_red_eye),
                                      SizedBox(width: 4),
                                      Text(
                                        postData[index]
                                            .reactions
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ]),
                                    // SizedBox(height: 10),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.symmetric(horizontal: 10),
                                    //   child: Text(
                                    //     'Report',
                                    //     style: TextStyle(
                                    //       fontSize: 12,
                                    //       color: Color(0xff8C191C),
                                    //       fontWeight: FontWeight.w400,
                                    //     ),
                                    //   ),
                                    // )
                                  ]),
                              SizedBox(height: 10),
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
