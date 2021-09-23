import 'package:archub/model/user.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/provider/user_post.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import 'image_card.dart';

class FollowCard extends StatefulWidget {
  Map<String, dynamic> data;
  FollowCard({this.data, Key key}) : super(key: key);

  @override
  _FollowCardState createState() => _FollowCardState();
}

class _FollowCardState extends State<FollowCard> {
  bool isloading = false;
  User userdata = User();

  @override
  Widget build(BuildContext context) {
    userdata = Provider.of<Auth>(context).sourceId;
    final user = Provider.of<Auth>(context).user;
    final sourceIdData = Provider.of<UserPost>(context).sourceIdData;
    // final data = ModalRoute.of(context).settings.arguments as Map;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            isloading == false
                ? ImageCard()
                : Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white10,
                    child: ImageCard()),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userdata.fullName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Text(
                      //   'Interior Designer',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                userdata.followers.contains(user.id) == true
                    ? Container(
                        height: 50,
                        width: 150,
                        child: RoundedRaisedButton(
                          isLoading: isloading,
                          title: 'Unfollow',
                          buttonColor: Color(0xff8C191C),
                          onPress: () async {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await Provider.of<UserPost>(context,
                                      listen: false)
                                  .unfollowuser(userdata.id);
                              await Provider.of<UserPost>(context,
                                      listen: false)
                                  .getPostBySourceId(widget.data['_id']);
                              await Provider.of<Auth>(context, listen: false)
                                  .getProfile();
                              Get.snackbar(
                                  'Success!', 'You have unfollowed this user',
                                  barBlur: 0,
                                  dismissDirection:
                                      SnackDismissDirection.VERTICAL,
                                  backgroundColor: Colors.green,
                                  overlayBlur: 0,
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  duration: Duration(seconds: 2));
                              setState(() {
                                isloading = false;
                              });
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(KInfoDetail, arguments: widget.data);});
                            } catch (e) {
                              print(e);
                              Get.snackbar('Error!', '${e.toString()}',
                                  barBlur: 0,
                                  dismissDirection:
                                      SnackDismissDirection.VERTICAL,
                                  backgroundColor: Colors.red,
                                  overlayBlur: 0,
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  duration: Duration(seconds: 2));
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 150,
                        child: RoundedRaisedButton(
                          isLoading: isloading,
                          title: 'Follow',
                          buttonColor: Color(0xff8C191C),
                          onPress: () async {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await Provider.of<UserPost>(context,
                                      listen: false)
                                  .followuser(userdata.id);
                              await Provider.of<UserPost>(context,
                                      listen: false)
                                  .getPostBySourceId(widget.data['_id']);
                              await Provider.of<Auth>(context, listen: false)
                                  .getProfile();
                              Get.snackbar(
                                  'Success!', 'You started following this user',
                                  barBlur: 0,
                                  dismissDirection:
                                      SnackDismissDirection.VERTICAL,
                                  backgroundColor: Colors.green,
                                  overlayBlur: 0,
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  duration: Duration(seconds: 2));
                              setState(() {
                                isloading = false;
                              });
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(KInfoDetail, arguments: widget.data);});
                              
                            } catch (e) {
                              print(e);
                              Get.snackbar('Error!', '${e.toString()}',
                                  barBlur: 0,
                                  dismissDirection:
                                      SnackDismissDirection.VERTICAL,
                                  backgroundColor: Colors.red,
                                  overlayBlur: 0,
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  duration: Duration(seconds: 2));
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                        ),
                      ),
                Container(
                  height: 50,
                  width: 150,
                  child: RoundedRaisedButton(
                    title: 'Message',
                    buttonColor: Color(0xff28384F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      )),
    );
  }
}
