import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';

class SocailMedia extends StatelessWidget {
  const SocailMedia({Key key}) : super(key: key);

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
      body: Column(children: [
        SizedBox(height: 10),
        ListTile(
          leading: Image.asset(
            'assets/icons/link.png',
            height: 70,
          ),
          title: Text(
            "Social links",
            style: TextStyle(color: Color(0xff28384F)),
          ),
        ),
        SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Center(
                              child:
                                  Text('Help others to know more about you')),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                                'assets/images/per2.png'),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: Color(0xffC4C4C4),
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   Image.asset(
                          //                     'assets/images/link1.png',
                          //                     height: 20,
                          //                   ),
                          //                   SizedBox(width: 10),
                          //                   Text(
                          //                     'Social Links',
                          //                     style: TextStyle(
                          //                       fontSize: 12,
                          //                       color: Color(0xff28384F),
                          //                       fontWeight: FontWeight.w600,
                          //                     ),
                          //                     textAlign: TextAlign.left,
                          //                   ),
                          //                 ],
                          //               ),
                          //               Container(
                          //                   padding: EdgeInsets.symmetric(
                          //                       horizontal: 10),
                          //                   decoration: BoxDecoration(
                          //                     color: Color(0xff28384F),
                          //                     borderRadius:
                          //                         BorderRadius.circular(10),
                          //                   ),
                          //                   child: Row(
                          //                     children: [
                          //                       SizedBox(width: 5),
                          //                       Text(
                          //                         'Facebook',
                          //                         style: TextStyle(
                          //                           fontSize: 12,
                          //                           color: Colors.white,
                          //                           fontWeight: FontWeight.w600,
                          //                         ),
                          //                       ),
                          //                       Icon(
                          //                         Icons.arrow_drop_down,
                          //                         color: Colors.white,
                          //                       ),
                          //                     ],
                          //                   ))
                          //             ]),
                          //       ),
                          //       SizedBox(height: 10),
                          //       // Container(
                          //       //   height: 30,
                          //       //   child: ListView(
                          //       //     scrollDirection: Axis.horizontal,
                          //       //     children: [
                          //       //       Container(
                          //       //         decoration: BoxDecoration(
                          //       //             borderRadius:
                          //       //                 BorderRadius.circular(20),
                          //       //             border: Border.all(
                          //       //                 width: 1,
                          //       //                 color: Color(0xff28384F))),
                          //       //         child: Padding(
                          //       //           padding: const EdgeInsets.all(5),
                          //       //           child: Text(
                          //       //             'Instagram',
                          //       //             style: TextStyle(
                          //       //               fontSize: 12,
                          //       //               color: Color(0xff28384F),
                          //       //               fontWeight: FontWeight.w600,
                          //       //             ),
                          //       //           ),
                          //       //         ),
                          //       //       ),
                          //       //       SizedBox(width: 4),
                          //       //       Container(
                          //       //         decoration: BoxDecoration(
                          //       //             borderRadius:
                          //       //                 BorderRadius.circular(20),
                          //       //             border: Border.all(
                          //       //                 width: 1,
                          //       //                 color: Color(0xff28384F))),
                          //       //         child: Padding(
                          //       //           padding: const EdgeInsets.all(5),
                          //       //           child: Text(
                          //       //             'Interior Design',
                          //       //             style: TextStyle(
                          //       //               fontSize: 12,
                          //       //               color: Color(0xff28384F),
                          //       //               fontWeight: FontWeight.w600,
                          //       //             ),
                          //       //           ),
                          //       //         ),
                          //       //       ),
                          //       //       SizedBox(width: 4),
                          //       //       Container(
                          //       //         decoration: BoxDecoration(
                          //       //             borderRadius:
                          //       //                 BorderRadius.circular(20),
                          //       //             border: Border.all(
                          //       //                 width: 1,
                          //       //                 color: Color(0xff28384F))),
                          //       //         child: Padding(
                          //       //           padding: const EdgeInsets.all(5),
                          //       //           child: Text(
                          //       //             'Linkedn',
                          //       //             style: TextStyle(
                          //       //               fontSize: 12,
                          //       //               color: Color(0xff28384F),
                          //       //               fontWeight: FontWeight.w600,
                          //       //             ),
                          //       //           ),
                          //       //         ),
                          //       //       ),
                          //       //       SizedBox(width: 4),
                          //       //       Container(
                          //       //         decoration: BoxDecoration(
                          //       //             borderRadius:
                          //       //                 BorderRadius.circular(20),
                          //       //             border: Border.all(
                          //       //                 width: 1,
                          //       //                 color: Color(0xff28384F))),
                          //       //         child: Padding(
                          //       //           padding: const EdgeInsets.all(5),
                          //       //           child: Text(
                          //       //             'Twitter',
                          //       //             style: TextStyle(
                          //       //               fontSize: 12,
                          //       //               color: Color(0xff28384F),
                          //       //               fontWeight: FontWeight.w600,
                          //       //             ),
                          //       //           ),
                          //       //         ),
                          //       //       ),
                                      
                          //       //     ],
                          //       //   ),
                          //       // ),
                          //       SizedBox(height: 10),
                          //     ],
                          //   ),
                          // ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              title: 'Save changes',
              buttonColor: Color(0xff8C191C),
            ),
          ),
        ),
        SizedBox(height: 40),
      ]),
    );
  }
}
