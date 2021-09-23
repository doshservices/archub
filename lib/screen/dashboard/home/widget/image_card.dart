import 'package:archub/model/user.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/provider/user_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatelessWidget {
 ImageCard({Key key}) : super(key: key);
  User userdata = User();

  @override
  Widget build(BuildContext context) {
    userdata = Provider.of<Auth>(context).sourceId;
    final user = Provider.of<Auth>(context).user;
    final sourceIdData = Provider.of<UserPost>(context).sourceIdData;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      
      Column(
        children: [
          SizedBox(height: 10),
          userdata.pictureUrl.contains('/avatar.svg')
              ? CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  radius: 30,
                  child: SvgPicture.network(
                    userdata.pictureUrl.toString().split("'").join(""),
                    fit: BoxFit.contain,
                    height: 30,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(2),
                        child: const CircularProgressIndicator()),
                  ),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    userdata.pictureUrl,
                  ),
                ),

          // SizedBox(height: 10),
          // Image.asset(
          //   'assets/images/p1.png',
          //   height: 80,
          // ),
        ],
      ),
      SizedBox(width: 20),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(height: 3),
            Column(
              children: [
                SizedBox(height: 15),
                Text(
                  'Following',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userdata.following.length.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff28384F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // SizedBox(height: 20),
              ],
            ),

            Column(
              children: [
                SizedBox(height: 15),
                Text(
                  'Folllowers',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userdata.followers.length.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff28384F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 15),
                Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  sourceIdData.length.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff28384F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // SizedBox(height: 20),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
