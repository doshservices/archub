import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoDetail extends StatefulWidget {
  const InfoDetail({Key key}) : super(key: key);

  @override
  _InfoDetailState createState() => _InfoDetailState();
}

class _InfoDetailState extends State<InfoDetail> {
  bool hidden;

  @override
  void initState() {
    hidden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
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
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10),
                          CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                Icons.person_outline,
                                size: 30,
                              )),

                          // SizedBox(height: 10),
                          // Image.asset(
                          //   'assets/images/p1.png',
                          //   height: 80,
                          // ),
                          SizedBox(height: 10),
                          Text(
                            user.fullName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Interior Designer',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 3),
                          Text(
                            'Following',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffC7C7DD),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Folllowers',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffC7C7DD),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
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
                            '0',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffC7C7DD),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ]),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Container(
                    height: 50,
                    width: 200,
                    child: RoundedRaisedButton(
                      title: 'Follow',
                      buttonColor: Color(0xff8C191C),
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            color: Colors.white70,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 30),
                        SizedBox(width: 20),
                        Text(
                          'Bio',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff28384F),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          hidden =! hidden;
                        });
                      },
                      child: Icon(hidden == true ? Icons.arrow_drop_down : Icons.arrow_drop_up)
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     'Amet minim mollit non deserunt ullamco est sit aliqua dAmet minim mollit non deserunt ullamco est sit aliqua d',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Color(0xff96969B),
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              Container(
                height: 10,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              hidden == false ? Container():Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              maxLines: 7,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type here...',
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset('assets/images/per2.png'),
                                        SizedBox(height: 5),
                                        Text(
                                          'Lagos',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff96969B),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      children: [
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff28384F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_drop_down)
                              ]),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/skills.png',
                                          height: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff28384F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Color(0xff28384F),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'Select skills',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ))
                                  ]),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Achitecture',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Interior Design',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Structural Design',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Structural Design',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/link1.png',
                                          height: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Social Links',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff28384F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Color(0xff28384F),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'Facebook',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ))
                                  ]),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Instagram',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Interior Design',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Linkedn',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff28384F))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'Twitter',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff28384F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     'Projects',
              //     style: TextStyle(
              //       fontSize: 16,
              //       color: Color(0xff8C191C),
              //       fontWeight: FontWeight.w400,
              //     ),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: GridView.builder(
              //       itemCount: 6,
              //       itemBuilder: (context, i) {
              //         return Image.asset('assets/images/img1.png');
              //       },
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 10,
              //         childAspectRatio: 1 / 0.9,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child: RoundedRaisedButton(
              //       title: 'Follow',
              //       buttonColor: Color(0xff8C191C),
              //     ),
              //   ),
              // ),
              SizedBox(height: 5),
            ]),
          ),
        )
      ]),
    );
  }
}