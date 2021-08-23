import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              color: Color(0xffE5E5E5),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/test1.png',
                      height: 35,
                      width: 35,
                    ),
                    title: Text(
                      'Test One',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      'Sam Ben',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xff28384F),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/bg.png'),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 2, children: [
                  Text(
                      'Test One Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim a  mollit non deserunt ullamco est sit aliqua d')
                ]),
                SizedBox(height: 10),
                Text('Comments'),
              ],
            ),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/test1.png',
              height: 25,
              width: 25,
            ),
            title: Text(
              'Sam Ben',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              'Nice! design',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xff28384F),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/test1.png',
              height: 25,
              width: 25,
            ),
            title: Text(
              'Adam Bala',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              'Amet minim mollit non deserunt ullamco est sit aliqua dAmet minim mollit non deserunt ullamco est sit aliqua d',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xff28384F),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/test1.png',
              height: 25,
              width: 25,
            ),
            title: Text(
              'Adam Bala',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              'Amet minim mollit non deserunt ullamco est sit aliqua dAmet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua dAmet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua dAmet minim mollit non deserunt ullamco est sit aliqua d ',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xff28384F),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xff28384F)),
              ),
              child: Row(children: [
                Expanded(child: Center(child: Text('Leave  a comment'))),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff8C191C),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                  ),
                  child: Icon(Icons.near_me, color: Colors.white,),
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
