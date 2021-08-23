import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Widget> pages;
  int pageIndex = 0;
  PageController _uploadPageController = PageController(initialPage: 0);

  Widget page1() {
    return Column(children: [
      Container(
          width: double.infinity,
          color: Colors.white,
          child: Image.asset('assets/images/post.png')),
      Container(
        height: 55,
        color: Color(0xff28384F),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('All Photos',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
              Row(
                children: [
                  Container(
                      height: 35,
                      child: Image.asset('assets/images/folder.png')),
                  SizedBox(width: 15),
                  Container(
                      height: 35,
                      child: Image.asset('assets/images/camera.png'))
                ],
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: GridView.builder(
            // padding: EdgeInsets.all(20),
            shrinkWrap: true,
            primary: false,
            itemCount: 20,
            itemBuilder: (ctx, index) {
              return Container(
                  child: Image.asset(
                'assets/images/img4.png',
                fit: BoxFit.fill,
              ));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 1,
              mainAxisSpacing: 0,
              childAspectRatio: 1 / 1,
            )),
      )
    ]);
  }

  Widget page2() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(
          height: 10,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 100,
              child: Image.asset('assets/images/flr.png')),
            SizedBox(
              width: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add a caption...'),
            )
          ],
        ), 
        SizedBox(
          height: 10
        ),
        Container(
          height: 4,
          color: Color(0xffE5E5E5)
        ),
        ListTile(
          title: Text('Tag people'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Container(
          height: 4,
          color: Color(0xffE5E5E5)
        ),
        ListTile(
          title: Text('Add location'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff28384F).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    'Lagos',
                    style: TextStyle(
                      color: Color(0xff28384F).withOpacity(0.5)
                    )
                  ),
                )
              ),
              SizedBox(
                width: 10
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff28384F).withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    'Omole estate, ojodu',
                    style: TextStyle(
                      color: Color(0xff28384F).withOpacity(0.5)
                    )
                  ),
                )
              ),
              SizedBox(
                width: 10
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff28384F).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    'Oke-ira',
                    style: TextStyle(
                      color: Color(0xff28384F).withOpacity(0.5)
                    )
                  ),
                )
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10
        ),
        Container(
          height: 4,
          color: Color(0xffE5E5E5)
        ),
        ListTile(
          title: Text('Choose'),
          // trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff28384F).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff28384F)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                )
              ),
              SizedBox(
                width: 10
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff28384F).withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    'Story',
                    style: TextStyle(
                      color: Color(0xff28384F).withOpacity(0.5)
                    )
                  ),
                )
              ),
            ],
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      page1(),
      page2(),
    ];

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
            child: Padding(
          padding: EdgeInsets.only(right: 40),
          child: Image.asset(
            'assets/icons/lg.png',
            height: 40,
          ),
        )),
      ),
      body: Column(children: [
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('  ',
                      style: TextStyle(fontSize: 16, color: Color(0xff28384F))),
                  Text('New post',
                      style: TextStyle(fontSize: 16, color: Color(0xff28384F))),
                  GestureDetector(
                    onTap: pageIndex == pages.length - 1
                        ? () {}
                        : () {
                            Future.delayed(Duration(seconds: 2)).then(
                                (value) => _uploadPageController.animateToPage(
                                      ++pageIndex,
                                      duration: Duration(microseconds: 200),
                                      curve: Curves.easeIn,
                                    ));
                          },
                    child: Text(
                        pageIndex == pages.length - 1 ? "Share" : 'Next',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff8C191C))),
                  ),
                ]),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _uploadPageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [...pages],
          ),
        ),
      ]),
    );
  }
}
