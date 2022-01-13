import 'package:archub/provider/user_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valuedata = Provider.of<UserPost>(context, listen: false).commentData;
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: valuedata.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              valuedata[index].userId['image'],
              height: 25,
              width: 25,
            ),
            title: Text(
              valuedata[index].userId['fullName'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              valuedata[index].comment,
              style: TextStyle(
                fontSize: 10,
                color: Color(0xff28384F),
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        });
  }
}
