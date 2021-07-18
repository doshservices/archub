import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Center(
          child: Image.asset('assets/icons/lg.png', height: 40,)
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
            )
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Color(0xffC4C4C4), shape: BoxShape.circle),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'My Story',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff28384F),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]),
                  );
                }),
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              return Padding(
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
                          SizedBox(
                            width: 5
                          ),
                          Icon(Icons.maps_ugc),
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 5
                          ),
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
              );
            },
          )),
        ]),
      ),
    );
  }
}
