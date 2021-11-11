import 'package:flutter/material.dart';
import 'package:archub/model/post_data.dart';
import 'package:flutter_svg/svg.dart';

class ProfileWidget extends StatelessWidget {
  final PostData user;
  final String date;

  const ProfileWidget({
    @required this.user,
    @required this.date,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              user.sourceId['image'].contains('/avatar.svg')
                  ? CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      radius: 25,
                      child: SvgPicture.network(
                        user.sourceId['image']
                            .toString()
                            .split("'")
                            .join(""),
                        fit: BoxFit.contain,
                        height: 30,
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(2),
                            child: const CircularProgressIndicator()),
                      ),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(user.sourceId['image']),
                    ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.sourceId['fullName'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Text(
                    //   date,
                    //   style: TextStyle(color: Colors.white38),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
