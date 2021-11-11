import 'package:archub/provider/user_post.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'comment_widget.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool _isInit = true;
  String _usercomment = "";
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _isLoading = false;
  String react = "positive";
  int reactionvalue;

  @override
  void didChangeDependencies() async {
    print("******************");

    if (_isInit) {
      final data = ModalRoute.of(context).settings.arguments;
      print(data);
      try {
        await Provider.of<UserPost>(context, listen: false)
            .getCommentById(data);
        await Provider.of<UserPost>(context, listen: false).getPostById(data);

        print("good");
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
        final data = ModalRoute.of(context).settings.arguments;
        await Provider.of<UserPost>(context, listen: false)
            .creatComment(_usercomment, id);
        await Provider.of<UserPost>(context, listen: false).getCommentById(id);
      } catch (error) {
        if (error.toString().isNotEmpty) {
          _showShackBar(error.toString());
        } else {
          _showShackBar('Invalid credential');
        }
      } finally {
        setState(() {
          // errMsg = "";
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
    // final data = ModalRoute.of(context).settings.arguments;
    final value = Provider.of<UserPost>(context, listen: false).postDatabyId;
    reactionvalue =
        value.reactions == null ? update(0) : update(value.reactions.length);
    // print(value.title.toString());

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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
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
                                    leading: Image.asset(
                                      'assets/images/test1.png',
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
                                  ),
                                  Container(
                                      height: 350,
                                      width: double.infinity,
                                      child: Image.network(
                                          value.postFiles[0].toString(),
                                          fit: BoxFit.fill)),
                                  SizedBox(height: 10),
                                  _isInit == false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                              Row(children: [
                                                GestureDetector(
                                                    onTap: () async {
                                                      await Provider.of<UserPost>(context,listen: false)
                                                          .reacttoPost("negative",value.id,reactionvalue)
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
                                                      await Provider.of<UserPost>(context, listen: false).getAllUserPort();
                                                      // setState(() {
                                                      //   if(react=="positive"){
                                                      //     reactionvalue+=1;
                                                      //     react = "negative";
                                                      //   }
                                                      // });
                                                    },
                                                    child:
                                                        Icon(Icons.favorite)),
                                                SizedBox(width: 5),
                                                Text(
                                                  _isInit == true
                                                      ? 0
                                                      : reactionvalue
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(Icons.remove_red_eye),
                                                SizedBox(width: 5),
                                                Text(
                                                  reactionvalue.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ]),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(
                                              //       horizontal: 10),
                                              //   child: Text(
                                              //     'Report',
                                              //     style: TextStyle(
                                              //       fontSize: 12,
                                              //       color: Color(0xff8C191C),
                                              //       fontWeight: FontWeight.w400,
                                              //     ),
                                              //   ),
                                              // )
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
                                                        // setState(() {
                                                        //   if(react=="positive"){
                                                        //     reactionvalue+=1;
                                                        //     react = "negative";
                                                        //   }
                                                        // });
                                                      },
                                                      child:
                                                          Icon(Icons.favorite)),
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
                                                  Icon(Icons.remove_red_eye),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    reactionvalue.toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ]),
                                              ])),
                                ]),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
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
    );
  }
}
