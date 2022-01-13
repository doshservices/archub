import 'package:archub/provider/auth.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:archub/provider/user_post.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../constants.dart';
import 'comment_widget.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool _isInit = true;
  Color color;
  String _usercomment = "";
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _isLoading = false;
  TextEditingController _passwordController = TextEditingController();
  String react = "positive";
  int reactionvalue;
  List<Widget> imageSliders;

  @override
  void didChangeDependencies() async {

    if (_isInit) {
      final data = ModalRoute.of(context).settings.arguments as Map;
      print(data);
      try {
        await Provider.of<UserPost>(context, listen: false)
            .getCommentById(data['id']);
        await Provider.of<UserPost>(context, listen: false).getPostById(data['id']);
        final value = Provider.of<UserPost>(context, listen: false).postDatabyId;
        imageSliders = value.postFiles
            .map(
              (item) => Container(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(item, fit: BoxFit.fill)),
            )
            .toList();
      } catch (error) {}

      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: Text(
        errorMessage.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<void> _submitLogin(id) async {
    if (!_loginFormKey.currentState.validate()) {
      return;
    }
    _loginFormKey.currentState.save();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
      });
      try {
        final data = ModalRoute.of(context).settings.arguments as Map;
        print(data);
        await Provider.of<UserPost>(context, listen: false)
            .creatComment(_usercomment, id);
        await Provider.of<UserPost>(context, listen: false)
            .getCommentById(data['id']);
      } catch (error) {
        if (error.toString().isNotEmpty) {
          _showShackBar(error.toString());
        } else {
          _showShackBar('Invalid credential');
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Not connected');
      _showShackBar('Please check your Internet connection!!!');
      setState(() {
        _isLoading = false;
      });
    }
  }

  update(value) {
    setState(() {
      reactionvalue = value;
    });
    return reactionvalue;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map;
    final value = Provider.of<UserPost>(context, listen: false).postDatabyId;
    final user = Provider.of<Auth>(context, listen: false).user;
    reactionvalue =
        value.reactions == null ? update(0) : update(value.reactions.length);
    // print(value.title.toString());
    for (var map in value.reactions) {
      if (map.containsKey("userId")) {
        if (map["userId"] == user.id) {
          color = Colors.red;
        } else {
          color = Colors.black;
        }
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
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
      body: _isInit
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                color: Color(0xffE5E5E5),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Column(children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Image.network(
                                        data['image'],
                                        height: 35,
                                        width: 35,
                                      ),
                                      title: Text(
                                        value.title.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        value.description.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: user.id != value.sourceId['_id'] ? GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return Dialog(
                                                  child: Container(
                                                    height: 160,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
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
                                                                    FontWeight
                                                                        .w600),
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
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                    ),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Color(0xff8C191C)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 50,
                                                                  width: 150,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child:
                                                                      RoundedRaisedButton(
                                                                    title:
                                                                        'Report post',
                                                                    titleColor:
                                                                        Colors
                                                                            .white,
                                                                    buttonColor:
                                                                        Color(
                                                                            0xff8C191C),
                                                                    onPress:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(context).pushNamed(
                                                                          KReportPort,
                                                                          arguments:
                                                                              value);
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
                                        },
                                        child: Text(
                                          "Report",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff8C191C),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ) : Text(""),
                                    ),
                                    Container(
                                      // height: 400,
                                      child: CarouselSlider(
                                        items: imageSliders,
                                        options: CarouselOptions(
                                          height: 350,
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          enableInfiniteScroll: true,
                                          enlargeCenterPage: false,
                                          aspectRatio: 2.0,
                                          initialPage: 1,
                                          onPageChanged: (index, reason) {},
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    _isInit == false
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Row(children: [
                                                  GestureDetector(
                                                      onTap: () async {
                                                        await Provider.of<
                                                                    UserPost>(
                                                                context,
                                                                listen: false)
                                                            .reacttoPost(
                                                                "negative",
                                                                value.id,
                                                                reactionvalue)
                                                            .then((value) {
                                                          setState(() {
                                                            _isInit = true;
                                                            update(value);
                                                            setState(() {
                                                              _isInit = false;
                                                            });
                                                            // reactionvalue=value;
                                                          });
                                                        });
                                                        await Provider.of<
                                                                    UserPost>(
                                                                context,
                                                                listen: false)
                                                            .getPostById(
                                                                data['id']);
                                                        await Provider.of<
                                                                    UserPost>(
                                                                context,
                                                                listen: false)
                                                            .getAllUserPort();
                                                        final valuedata =
                                                            Provider.of<UserPost>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .postDatabyId;
                                                        final user =
                                                            Provider.of<Auth>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .user;
                                                        reactionvalue = valuedata
                                                                    .reactions ==
                                                                null
                                                            ? update(0)
                                                            : update(valuedata
                                                                .reactions
                                                                .length);
                                                        // print(value.title.toString());
                                                        if (valuedata.reactions
                                                                .length !=
                                                            0) {
                                                          for (var map
                                                              in valuedata
                                                                  .reactions) {
                                                            if (map.containsKey(
                                                                "userId")) {
                                                              if (map["userId"] ==
                                                                  user.id) {
                                                                color =
                                                                    Colors.red;
                                                              } else {
                                                                color = Colors
                                                                    .black;
                                                              }
                                                            }
                                                          }
                                                        } else {
                                                          color = Colors.black;
                                                        }

                                                        setState(() {});
                                                        // setState(() {
                                                        //   if(react=="positive"){
                                                        //     reactionvalue+=1;
                                                        //     react = "negative";
                                                        //   }
                                                        // });
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: color,
                                                      )),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    _isInit == true
                                                        ? 0
                                                        : reactionvalue
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Icon(Icons.maps_ugc),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    value.numberOfComments
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  if (user.id ==
                                                      value.sourceId["_id"])
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) {
                                                              return Dialog(
                                                                child:
                                                                    Container(
                                                                  height: 160,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.7,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15,
                                                                        vertical:
                                                                            15),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Center(
                                                                            child:
                                                                                Text(
                                                                          "Do you like to delete this post?",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600),
                                                                        )),
                                                                        SizedBox(
                                                                            height:
                                                                                30),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                    horizontal: 10,
                                                                                  ),
                                                                                  child: Text(
                                                                                    "Cancel",
                                                                                    style: TextStyle(fontSize: 15, color: Color(0xff8C191C)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 50,
                                                                                width: 150,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                                                                child: RoundedRaisedButton(
                                                                                  title: 'Delete post',
                                                                                  titleColor: Colors.white,
                                                                                  buttonColor: Color(0xff8C191C),
                                                                                  onPress: () async {
                                                                                    Navigator.of(context).pop();
                                                                                    try {
                                                                                      await Provider.of<JobProvider>(context, listen: false).deletePost(value.id);
                                                                                      Get.snackbar('Success!', 'Post successfully deleted', barBlur: 0, dismissDirection: SnackDismissDirection.VERTICAL, backgroundColor: Colors.green, overlayBlur: 0, animationDuration: Duration(milliseconds: 1000), duration: Duration(seconds: 2));
                                                                                      setState(() {
                                                                                        _isInit = true;
                                                                                      });
                                                                                      // await Provider.of<UserPost>(context, listen: false).getAllUserStory();
                                                                                      await Provider.of<UserPost>(context, listen: false).getAllUserPort();
                                                                                      Navigator.of(context).pushNamedAndRemoveUntil(KDashboard, (route) => false);
                                                                                      setState(() {
                                                                                        _isInit = false;
                                                                                      });
                                                                                    } catch (e) {}
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
                                                      },
                                                      child: Icon(Icons.delete),
                                                    ),
                                                ]),
                                              ])
                                        : Shimmer.fromColors(
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white10,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(children: [
                                                    GestureDetector(
                                                        onTap: () async {
                                                          await Provider.of<
                                                                      UserPost>(
                                                                  context,
                                                                  listen: false)
                                                              .reacttoPost(
                                                                  "negative",
                                                                  value.id,
                                                                  reactionvalue)
                                                              .then((value) {
                                                            setState(() {
                                                              _isInit = true;
                                                              update(value);
                                                              setState(() {
                                                                _isInit = false;
                                                              });
                                                              // reactionvalue=value;
                                                            });
                                                          });
                                                        },
                                                        child: Icon(
                                                            Icons.favorite)),
                                                    SizedBox(width: 5),
                                                    Consumer<UserPost>(builder:
                                                        (ctx, data, text) {
                                                      return Text(
                                                        data.postDatabyId
                                                            .reactions.length
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      );
                                                    }),
                                                    SizedBox(width: 10),
                                                    Icon(Icons.maps_ugc),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      value.numberOfComments
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                  ]),
                                                ])),
                                  ]),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        value.description.toString(),
                                        textAlign: TextAlign.justify,
                                        // maxLines: 6,
                                      ),
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // pacing: 2,
                                        children: [
                                          // 'Test One Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim a  mollit non deserunt ullamco est sit aliqua d')
                                        ]),
                                    SizedBox(height: 10),
                                    Text('Comments'),
                                    CommentWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xff28384F)),
                          ),
                          child: Row(children: [
                            Expanded(
                                child: Center(
                                    child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Form(
                                key: _loginFormKey,
                                child: TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Leave a comment",
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _usercomment = value;
                                  },
                                ),
                              ),
                            ))),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff8C191C),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _submitLogin(value.id);
                                  _passwordController.clear();
                                },
                                child: _isLoading == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator()),
                                      )
                                    : Icon(
                                        Icons.near_me,
                                        color: Colors.white,
                                      ),
                              ),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: 10)
                    ]),
              ),
            ),
    );
  }
}
