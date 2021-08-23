import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class JobScreen extends StatefulWidget {
  // const HomeScreen({ Key? key }) : super(key: key);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: AppDrawer(),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Container(
              height: 60,
              width: double.infinity,
              color: Color(0xff8C191C),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Search ',
                                  hintStyle:
                                      TextStyle(color: Color(0xff28384F)),
                                  border: InputBorder.none)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Job postings',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff28384F))),
                      Row(
                        children: [
                          Text('Add new jobs',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff28384F))),
                          SizedBox(width: 5),
                          Icon(
                            Icons.add,
                            color: Color(0xff8C191C),
                          )
                        ],
                      )
                    ]),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(KJobWidget);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 80,
                                    child:
                                        Image.asset('assets/images/job2.png')),
                                SizedBox(width: 20),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nanite',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff28384F))),
                                      Text('Analog Developer',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff28384F))),
                                      Text('Username',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff28384F)
                                                  .withOpacity(0.5))),
                                    ])
                              ],
                            ),
                            Column(
                              children: [
                                Text('Lagos',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff28384F))),
                                Text('',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff28384F))),
                                Text('Fulltime',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff28384F)
                                            .withOpacity(0.5))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ])),
    );
  }
}
